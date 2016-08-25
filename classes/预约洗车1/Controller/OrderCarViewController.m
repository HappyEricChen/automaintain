 //
//  OrderCarViewController.m
//  一号车库
//
//  Created by eric on 16/6/28.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "OrderCarViewController.h"
#import "OrderCarDataViewController.h"
#import "WashCarFirstCollectionViewCell.h"
#import "WashCarSecondCollectionViewCell.h"
#import "WashCarThirdCollectionViewCell.h"
#import "WashCarFourCollectionViewCell.h"
#import "WashCarFiveCollectionViewCell.h"
#import "CommentHeaderView.h"
#import "UserCommentModel.h"
#import "MyOrderViewController.h"
#import "OrderConfirmViewController.h"
#import "ImageAmplificationViewController.h"

@interface OrderCarViewController ()<CustomNavigationViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,WashCarFiveCollectionViewCellDelegate,WashCarFourCollectionViewCellDelegate>
@property (nonatomic, strong) OrderCarDataViewController* orderCarDataViewController;
/**
 *  准备提交预约的起始时间,格式2016-08-12 14:31:00
 */
@property (nonatomic, strong) NSString* selectedTime;
/**
 *  准备提交预约的当前选中日期
 */
@property (nonatomic, strong) NSString* selectedDate;
/**
 *  选中的时间段8：30-9：00
 */
@property (nonatomic, strong) NSString* timeSegment;
/**
 *  刷新翻页，下拉刷新index=0，下拉刷新index+=1
 */
@property (nonatomic, assign) NSInteger index;


@end

@implementation OrderCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.orderCarDataViewController = [[OrderCarDataViewController alloc]init];
    [self configureNavigationView];
    [self configureCollectionView];
    
    [self loadMJRefreshMethod];
    self.selectedDate = AppManagerSingleton.currentDate;//日期初始为今天
    AppManagerSingleton.selectedDate = AppManagerSingleton.currentDate;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notificationReceived:) name:kNotify_myOrder_StartTime object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(currentDateNotification:) name:kNotify_selected_date object:nil];
    /**
     *  获取时间预约列表
     */
    [self loadDataFromService];
    /**
     *  开始刷新
     */
    [self.orderCarDataViewController.collectionView.mj_header beginRefreshing];
    
}


-(void)notificationReceived:(NSNotification*)object
{
    /**
     *  时间段 8：00-8：30
     */
    NSString* timeSegment = object.userInfo[@"time"];
    
    self.timeSegment = timeSegment;
    /**
     *  选中的起始时间，格式08:15:00
     */
    NSString* startTime = [[timeSegment substringToIndex:5] stringByAppendingString:@":00"];
    /**
     *  拼接完整的日期+时间，提交预约的完整格式 2017-02-03 08:15:00
     */
    self.selectedTime = [NSString stringWithFormat:@"%@ %@",self.selectedDate,startTime];
}

#pragma mark - 当前天数改变时调用
-(void)currentDateNotification:(NSNotification*)object
{
    NSString* currentDateStr = [object.userInfo objectForKey:@"currentDate"];
    
    NSString* dateStringFormate1 = [currentDateStr stringByReplacingOccurrencesOfString:@"年" withString:@"-"];
    NSString* dateStringFormate2 = [dateStringFormate1 stringByReplacingOccurrencesOfString:@"月" withString:@"-"];
    NSString* dateStringFormate3 = [dateStringFormate2 stringByReplacingOccurrencesOfString:@"日" withString:@""];
    self.selectedDate = dateStringFormate3;
    AppManagerSingleton.selectedDate = dateStringFormate3;
    [SVProgressHUD show];
    [self.orderCarDataViewController postListofWashCarPlaceListWithAccessCode:AppManagerSingleton.accessCode
                                                              withCurrentDate:dateStringFormate3
                                                              withSubjectGuid:SubjectGuidWashCar
                                                                 withCallback:^(BOOL success, NSError *error, id result)
     {
         
         if (success)
         {
             [SVProgressHUD dismiss];
             [self.orderCarDataViewController.collectionView reloadData];
         }
         else
         {
             [SVProgressHUD showInfoWithStatus:result];
         }
     }];

}
#pragma mark - 刷新
-(void)loadMJRefreshMethod
{
    self.index = 0;//初始化
    
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadDataFromService:)];
    self.orderCarDataViewController.collectionView.mj_header = header;
    self.orderCarDataViewController.collectionView.mj_header.automaticallyChangeAlpha = YES;
    
    MJRefreshAutoNormalFooter * footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadDataFromService:)];
    self.orderCarDataViewController.collectionView.mj_footer = footer;
    
}
-(void)loadDataFromService:(MJRefreshComponent*)headerFooterView
{
    if ([headerFooterView isKindOfClass:[MJRefreshNormalHeader class]])
    {
        self.index = 0;
    }
    
    NSString* indexStr = [NSString stringWithFormat:@"%ld",self.index];
    [self.orderCarDataViewController postCommentListWithAccessCode:AppManagerSingleton.accessCode withPageIndex:indexStr withCallback:^(BOOL success, NSError *error, id result)
     {
         if (success)
         {
             /**
              *  前一次请求成功后，index再+1
              */
             self.index += 1;
         }
         else
         {
             [SVProgressHUD showInfoWithStatus:result];
         }
         
     }];
}

-(void)loadDataFromService
{
    [SVProgressHUD show];
    /**
     *  请求当前日期下的时间列表
     */
#pragma mark - 获取时间列表
    [self.orderCarDataViewController postListofWashCarPlaceListWithAccessCode:AppManagerSingleton.accessCode withCurrentDate:AppManagerSingleton.selectedDate withSubjectGuid:SubjectGuidWashCar withCallback:^(BOOL success, NSError *error, id result)
     {
         if (success)
         {
             [SVProgressHUD dismiss];
             [self.orderCarDataViewController.collectionView reloadData];
         }
         else
         {
             [SVProgressHUD showInfoWithStatus:result];
         }
     }];
    
}

-(void)configureNavigationView
{
    [self.view addSubview:self.orderCarDataViewController.customNavigationView];
    self.orderCarDataViewController.customNavigationView.delegate = self;
    self.orderCarDataViewController.customNavigationView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topEqualToView(self.view).heightIs(ScreenHeight*0.1);
}

-(void)configureCollectionView
{
    [self.view addSubview:self.orderCarDataViewController.collectionView];
    
    self.orderCarDataViewController.collectionView.delegate = self;
    self.orderCarDataViewController.collectionView.dataSource = self;
    
    self.orderCarDataViewController.collectionView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topSpaceToView(self.orderCarDataViewController.customNavigationView,0).bottomEqualToView(self.view);
    
}


#pragma mark - CustomNavigationViewDelegate
-(void)didSelectedLeftButtonAtCustomNavigationView:(CustomNavigationView *)customNavigationView
{
    [SVProgressHUD dismiss];
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 5;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    if (section == 4)
    {
        return self.orderCarDataViewController.userCommentModelArr.count>0?self.orderCarDataViewController.userCommentModelArr.count:0;
    }
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BaseCollectionViewCell * cell;
    id object = nil;
    if (indexPath.section == 0)
    {
        WashCarFirstCollectionViewCell * firstCell = [WashCarFirstCollectionViewCell collectionView:collectionView dequeueReusableCellWithReuseIdentifier:washCarFirstId forIndexPath:indexPath];
        [firstCell layoutWithObject:nil];
        cell = firstCell;
    }
    else if (indexPath.section == 1)
    {
        WashCarSecondCollectionViewCell * secondCell = [WashCarSecondCollectionViewCell collectionView:collectionView dequeueReusableCellWithReuseIdentifier:WashCarSecondId forIndexPath:indexPath];
        cell =secondCell;
    }
    else if (indexPath.section == 2)
    {
        WashCarThirdCollectionViewCell * thirdCell = [WashCarThirdCollectionViewCell collectionView:collectionView dequeueReusableCellWithReuseIdentifier:WashCarThirdCollectionViewCellId forIndexPath:indexPath];
        object = self.orderCarDataViewController.washCarDateListModel;
        
        cell = thirdCell;
    }
    else if (indexPath.section == 3)
    {
        WashCarFourCollectionViewCell * fourCell = [WashCarFourCollectionViewCell collectionView:collectionView dequeueReusableCellWithReuseIdentifier:WashCarFourCollectionViewCellId forIndexPath:indexPath];
        fourCell.delegate = self;
        cell = fourCell;
    }
    else
    {
        WashCarFiveCollectionViewCell * fiveCell = [WashCarFiveCollectionViewCell collectionView:collectionView dequeueReusableCellWithReuseIdentifier:WashCarFiveCollectionViewCellId forIndexPath:indexPath];
        object = self.orderCarDataViewController.userCommentModelArr[indexPath.row];
        fiveCell.delegate = self;
        cell = fiveCell;
    }
    
    [cell layoutWithObject:object];
    return cell;
}

#pragma mark - UICollectionViewFlowLayoutDelegate

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return CGSizeMake(ScreenWidth, ScreenHeight*0.08);
    }
    else if (indexPath.section == 1)
    {
        return CGSizeMake(ScreenWidth, ScreenHeight*0.065);
    }
    else if (indexPath.section == 2)
    {
        return CGSizeMake(ScreenWidth, ScreenHeight*0.4);
    }
    else if (indexPath.section == 3)
    {
        return CGSizeMake(ScreenWidth, ScreenHeight*0.1);
    }
    else if (indexPath.section == 4)
    {
        UserCommentModel* userCommentModel = self.orderCarDataViewController.userCommentModelArr[indexPath.row];
        CGFloat height = [self calculateHeighWithLabelContent:userCommentModel.CommentContent
                                                 WithFontName:nil
                                                 WithFontSize:11
                                                    WithWidth:ScreenWidth-46-(ScreenWidth*0.026)
                                                     WithBold:NO];
        
        if (userCommentModel.PhotoUrls.count>0)
        {
            return CGSizeMake(ScreenWidth, ScreenHeight*0.27+height);
        }
        else
        {
            return CGSizeMake(ScreenWidth, ScreenHeight*0.1+height);
        }
        
    }
    return CGSizeZero;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
//    if (section == 2)
//    {
//        return UIEdgeInsetsMake(0, ScreenWidth*0.04, 0, ScreenWidth*0.04);
//    }

    return UIEdgeInsetsMake(0, 0, 0, 0);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 4)
    {
        return CGSizeMake(ScreenWidth,45);
    }
    return CGSizeZero;
}
#pragma mark - headView头部的View，用户评价(288条)
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView * reusableView;
    
    CommentHeaderView* headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerId forIndexPath:indexPath];
    NSString* commentTotalCount = [[NSUserDefaults standardUserDefaults]objectForKey:@"commentTotalCount"];
    [headerView layoutWithObject:commentTotalCount.integerValue];
    reusableView = headerView;
    
    return reusableView;
}

#pragma mark -WashCarFiveCollectionViewCellDelegate点击图片放大
-(void)didClickCarImageWithWashCarFiveCollectionViewCell:(WashCarFiveCollectionViewCell *)washCarFiveCollectionViewCell withImageUrl:(NSString *)imageUrl
{
    ImageAmplificationViewController* imageAmplificationViewController = [[ImageAmplificationViewController alloc]init];
    imageAmplificationViewController.imageUrl = imageUrl;
    [imageAmplificationViewController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self presentViewController:imageAmplificationViewController animated:YES completion:nil];
}

#pragma mark - 点击提交预约按钮调用WashCarFourCollectionViewCellDelegate
-(void)didClickSubmitButtonWithWashCarFourCollectionViewCell:(WashCarFourCollectionViewCell *)washCarFourCollectionViewCell
{
    
    if (!AppManagerSingleton.CardNo || AppManagerSingleton.CardNo.integerValue == 0)
    {
        UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil message:@"该功能目前只对会员卡用户开放\n详情咨询客服：021-6547387" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
        alertView.alertViewStyle = UIAlertViewStyleDefault;
        [alertView show];
        return;
    }
    else if (!self.selectedTime || [self.selectedTime isEqualToString:@""])
    {
        [SVProgressHUD showInfoWithStatus:@"请选择预约时间"];
        return;
    }
    
    OrderConfirmViewController* orderConfirmViewController = [[OrderConfirmViewController alloc]init];
    
    orderConfirmViewController.timeSegment = [AppTransferTimeSingleton transferCountDownWithTimeString:self.timeSegment];
    orderConfirmViewController.orderTime = self.selectedTime;
    orderConfirmViewController.orderProject = @"普通洗车";
    orderConfirmViewController.subjectGuid = SubjectGuidWashCar;
    orderConfirmViewController.price = self.orderCarDataViewController.washCarDateListModel.Pirce;
    [self.navigationController pushViewController:orderConfirmViewController animated:YES];
    
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:kNotify_myOrder_StartTime object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotify_selected_date object:nil];
}
@end
