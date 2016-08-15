//
//  MaintenanceViewController.m
//  automaintain
//
//  Created by eric on 16/6/29.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "MaintenanceViewController.h"
#import "MaintenanceDataViewController.h"
#import "WashCarFiveCollectionViewCell.h"
#import "CommentHeaderView.h"
#import "MaintenanceHeaderView.h"
#import "TypeSelectedViewController.h"
#import "TimeSelectedViewController.h"
#import "ImageAmplificationViewController.h"
#import "MaintenanceHeaderView.h"
#import "OrderTypeModel.h"
#import "MyOrderViewController.h"
#import "UserCommentModel.h"
#import "OrderConfirmViewController.h"

@interface MaintenanceViewController ()<CustomNavigationViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,MaintenanceHeaderViewDelegate,WashCarFiveCollectionViewCellDelegate>

@property (nonatomic, strong) MaintenanceDataViewController* maintenanceDataViewController;
/**
 *  完整的日期+时间 2017-02-03 08:15-08:30
 */
@property (nonatomic, strong) NSString* completedTime;
/**
 *  选中的时间段8：30-9：00
 */
@property (nonatomic, strong) NSString* timeSegment;
/**
 *  刷新翻页，下拉刷新index=0，下拉刷新index+=1
 */
@property (nonatomic, assign) NSInteger index;

@end

@implementation MaintenanceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.maintenanceDataViewController = [[MaintenanceDataViewController alloc]init];
    self.view.backgroundColor = [UIColor whiteColor];
    [self configureNavigationView];
    [self configureHeaderView];
    [self configureCollectionView];
    [self loadMJRefreshMethod];
    /**
     *  开始刷新数据
     */
    [self.maintenanceDataViewController.collectionView.mj_header beginRefreshing];
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(ReceivedCompletedTime:)
                                                name:kNotify_myOrder_CompletedTime
                                              object:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    /**
     *  布局预约类型及预约完整时间
     */
    [self.maintenanceDataViewController.maintenanceHeaderView layoutWithOrderTypeModel:self.orderTypeModel withCompletedTime:self.completedTime];
    
}

-(void)configureNavigationView
{
    [self.view addSubview:self.maintenanceDataViewController.customNavigationView];
    self.maintenanceDataViewController.customNavigationView.delegate = self;
    self.maintenanceDataViewController.customNavigationView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topEqualToView(self.view).heightIs(ScreenHeight*0.1);
}

-(void)configureHeaderView
{
    [self.view addSubview:self.maintenanceDataViewController.maintenanceHeaderView];
    self.maintenanceDataViewController.maintenanceHeaderView.delegate = self;
    self.maintenanceDataViewController.maintenanceHeaderView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topSpaceToView(self.maintenanceDataViewController.customNavigationView,0).heightIs(ScreenHeight*0.255);
}

-(void)configureCollectionView
{
    [self.view addSubview:self.maintenanceDataViewController.collectionView];
    
    self.maintenanceDataViewController.collectionView.delegate = self;
    self.maintenanceDataViewController.collectionView.dataSource = self;
    
    self.maintenanceDataViewController.collectionView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topSpaceToView(self.maintenanceDataViewController.maintenanceHeaderView,ScreenHeight*0.07).bottomEqualToView(self.view);
    
}
#pragma mark - 刷新
-(void)loadMJRefreshMethod
{
    self.index = 0;//初始化
    
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadDataFromService:)];
    self.maintenanceDataViewController.collectionView.mj_header = header;
    self.maintenanceDataViewController.collectionView.mj_header.automaticallyChangeAlpha = YES;
    
    MJRefreshAutoNormalFooter * footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadDataFromService:)];
    self.maintenanceDataViewController.collectionView.mj_footer = footer;
    
}
-(void)loadDataFromService:(MJRefreshComponent*)headerFooterView
{
    if ([headerFooterView isKindOfClass:[MJRefreshNormalHeader class]])
    {
        self.index = 0;
    }
    else
    {
        self.index += 1;
    }
    
    NSString* indexStr = [NSString stringWithFormat:@"%ld",self.index];
    [self.maintenanceDataViewController postCommentListWithAccessCode:AppManagerSingleton.accessCode withPageIndex:indexStr withCallback:^(BOOL success, NSError *error, id result)
     {
         
         if (success)
         {

         }
         else
         {
             [SVProgressHUD showInfoWithStatus:result];
         }
         
     }];
}
#pragma mark - 接收到通知调用，接收到完整的日期+时间
-(void)ReceivedCompletedTime:(NSNotification*)object
{
   self.completedTime = [object.userInfo objectForKey:@"completedTime"];
    
    self.timeSegment = [self.completedTime substringFromIndex:11];
}
#pragma mark - CustomNavigationViewDelegate
-(void)didSelectedLeftButtonAtCustomNavigationView:(CustomNavigationView *)customNavigationView
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.maintenanceDataViewController.userCommentModelArr.count>0?self.maintenanceDataViewController.userCommentModelArr.count:0;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BaseCollectionViewCell * cell;
    
    if (indexPath.section == 0)
    {
        WashCarFiveCollectionViewCell * thirdCell = [WashCarFiveCollectionViewCell collectionView:collectionView dequeueReusableCellWithReuseIdentifier:WashCarFiveCollectionViewCellId forIndexPath:indexPath];
        thirdCell.delegate = self;
        
        [thirdCell layoutWithObject:self.maintenanceDataViewController.userCommentModelArr[indexPath.row]];
        cell = thirdCell;
    }
    
    return cell;
}

#pragma mark - UICollectionViewFlowLayoutDelegate

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        
        UserCommentModel* userCommentModel = self.maintenanceDataViewController.userCommentModelArr[indexPath.row];
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
    if (section == 0)
    {
        return UIEdgeInsetsMake(17, 0, 0, 0);
    }
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return CGSizeMake(ScreenWidth,45);
    }
    return CGSizeZero;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView * reusableView;
    
    if (kind == UICollectionElementKindSectionHeader)
    {
        CommentHeaderView* headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerId forIndexPath:indexPath];
        NSString* commentTotalCount = [[NSUserDefaults standardUserDefaults]objectForKey:@"commentTotalCount"];
        [headerView layoutWithObject:commentTotalCount.integerValue];
        reusableView = headerView;
    }
    
    return reusableView;
}

#pragma mark - UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
  
}

#pragma mark - MaintenanceHeaderViewDelegate
/**
 *  类型选择
 */
-(void)didSelectedTypeChangeButtonWithMaintenanceHeaderView:(MaintenanceHeaderView *)maintenanceHeaderView
{
    
    TypeSelectedViewController* typeSelectedViewController = [[TypeSelectedViewController alloc]init];
    typeSelectedViewController.orderTypeModel = self.orderTypeModel;
    [self.navigationController pushViewController:typeSelectedViewController animated:YES];
    
    /**
     *  跳转到选择类型界面，清除时间
     */
    self.completedTime = @"";
    /**
     *  TimeSelected选中的时间清除
     */
    AppManagerSingleton.selectedTime = @"";
    
    
}
/**
 *  时间选择
 */
-(void)didSelectedTimeChangeButtonWithMaintenanceHeaderView:(MaintenanceHeaderView *)maintenanceHeaderView
{
    if (!self.orderTypeModel.SubjectName || [self.orderTypeModel.SubjectName isEqualToString:@""])
    {
        [SVProgressHUD showInfoWithStatus:@"请先选择预约类型"];
    }
    else
    {
        TimeSelectedViewController* timeSelectedViewController = [[TimeSelectedViewController alloc]init];
        timeSelectedViewController.subjectGuid = self.orderTypeModel.Guid;
        [self.navigationController pushViewController:timeSelectedViewController animated:YES];
    }
    
}

#pragma mark -点击提交预约按钮
-(void)didSelectedSubmitOrderButtonWithMaintenanceHeaderView:(MaintenanceHeaderView *)maintenanceHeaderView
{
    if (!self.orderTypeModel || [self.orderTypeModel.Guid isEqualToString:@""])
    {
        [SVProgressHUD showInfoWithStatus:@"请选择预约类型"];
        return;
    }
    else if (!self.completedTime || [self.completedTime isEqualToString:@""])
    {
        [SVProgressHUD showInfoWithStatus:@"请选择预约时间"];
        return;
    }
    
    /**
     *  通过完整时间截取到，项目起始时间 2017-02-03 08:15
     */
    NSString* appointmentStartTime = [self.completedTime substringToIndex:16];
    
    
    OrderConfirmViewController* orderConfirmViewController = [[OrderConfirmViewController alloc]init];
    
    orderConfirmViewController.timeSegment = [AppTransferTimeSingleton transferCountDownWithTimeString:self.timeSegment];
    orderConfirmViewController.orderTime = appointmentStartTime;
    orderConfirmViewController.orderProject = self.orderTypeModel.SubjectName;
    orderConfirmViewController.subjectGuid = self.orderTypeModel.Guid;
    orderConfirmViewController.price = self.orderTypeModel.Price;
    [self.navigationController pushViewController:orderConfirmViewController animated:YES];
    
}
#pragma mark -点击图片放大WashCarFiveCollectionViewCellDelegate
-(void)didClickCarImageWithWashCarFiveCollectionViewCell:(WashCarFiveCollectionViewCell *)washCarFiveCollectionViewCell withImage:(UIImage *)image
{
    ImageAmplificationViewController* imageAmplificationViewController = [[ImageAmplificationViewController alloc]init];
    imageAmplificationViewController.image = image;
    [imageAmplificationViewController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self presentViewController:imageAmplificationViewController animated:YES completion:nil];
}

-(void)dealloc
{
    /**
     *  TimeSelected选中的时间清除
     */
    AppManagerSingleton.selectedTime = @"";

    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotify_myOrder_CompletedTime object:nil];
}
@end
