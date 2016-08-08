//
//  FeedbackViewController.m
//  automaintain
//
//  Created by eric on 16/7/4.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "FeedbackViewController.h"
#import "FeedbackDataViewController.h"
#import "FeedbackFirstCollectionViewCell.h"
#import "FeedbackSecondCollectionViewCell.h"
#import "FeedbackThirdCollectionViewCell.h"

@interface FeedbackViewController ()<CustomNavigationViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource,FeedbackFirstCollectionViewCellDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, strong) FeedbackDataViewController* feedbackDataViewController;

@property (nonatomic, strong) NSArray* listArr;
/**
 *  当前选择的反馈类型
 */
@property (nonatomic, strong) NSString* feedbackTypeStr;
/**
 *  反馈意见的内容
 */
@property (nonatomic, strong) NSString* feedbackContent;
/**
 *  定时器，用来防止按钮多次点击
 */
@property (nonatomic, strong) NSTimer* timer;
@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.feedbackDataViewController = [[FeedbackDataViewController alloc]init];
    [self configureNavigationView];
    [self configureCollectionView];
    [self configureTableView];
    
    self.listArr = @[@"功能建议",@"页面展示",@"产品反馈",@"售后服务",@"相关活动",@"其他"];
    self.feedbackTypeStr = @"功能建议";
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(feedbackTextViewContentChanged:) name:kNotify_feedback_Content object:nil];
}

#pragma mark - 意见反馈输入文字接收方法
-(void)feedbackTextViewContentChanged:(NSNotification*)object
{
    self.feedbackContent =[object.userInfo objectForKey:@"textViewContent"];
}

-(void)configureNavigationView
{
    [self.view addSubview:self.feedbackDataViewController.customNavigationView];
    self.feedbackDataViewController.customNavigationView.delegate = self;
    self.feedbackDataViewController.customNavigationView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topEqualToView(self.view).heightIs(ScreenHeight*0.1);
}

-(void)configureCollectionView
{
    [self.view addSubview:self.feedbackDataViewController.collectionView];
    
    self.feedbackDataViewController.collectionView.delegate = self;
    self.feedbackDataViewController.collectionView.dataSource = self;
    
    self.feedbackDataViewController.collectionView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topSpaceToView(self.feedbackDataViewController.customNavigationView,0).bottomEqualToView(self.view);
    
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapCollectionView)];
    tapGesture.delegate = self;
    [self.feedbackDataViewController.collectionView addGestureRecognizer:tapGesture];
    
}

/**
 *  反馈类型下拉菜单
 */
-(void)configureTableView
{
    [self.view addSubview:self.feedbackDataViewController.listTableView];
    self.feedbackDataViewController.listTableView.delegate = self;
    self.feedbackDataViewController.listTableView.dataSource = self;
    self.feedbackDataViewController.listTableView.rowHeight = 35;
    self.feedbackDataViewController.listTableView.hidden = YES;
    self.feedbackDataViewController.listTableView.frame = CGRectMake(ScreenWidth*0.24, ScreenHeight*0.167, ScreenWidth*0.520, ScreenHeight*0.2);
}

#pragma mark - CustomNavigationViewDelegate
-(void)didSelectedLeftButtonAtCustomNavigationView:(CustomNavigationView *)customNavigationView
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = nil;
    
    if (indexPath.section == 0)
    {
        FeedbackFirstCollectionViewCell * firstCell = [FeedbackFirstCollectionViewCell collectionView:collectionView dequeueReusableCellWithReuseIdentifier:FeedbackFirstCollectionViewCellId forIndexPath:indexPath];
        [firstCell layoutWithObject:self.feedbackTypeStr];
        firstCell.delegate = self;
        cell = firstCell;
    }
    else if (indexPath.section == 1)
    {
        FeedbackSecondCollectionViewCell * secondCell = [FeedbackSecondCollectionViewCell collectionView:collectionView dequeueReusableCellWithReuseIdentifier:FeedbackSecondCollectionViewCellId forIndexPath:indexPath];
        cell =secondCell;
    }
    else if (indexPath.section == 2)
    {
        FeedbackThirdCollectionViewCell * thirdCell = [FeedbackThirdCollectionViewCell collectionView:collectionView dequeueReusableCellWithReuseIdentifier:FeedbackThirdCollectionViewCellId forIndexPath:indexPath];
        cell =thirdCell;
    }
    
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
        return CGSizeMake(ScreenWidth, ScreenHeight*0.2);
    }
    else if (indexPath.section == 2)
    {
        return CGSizeMake(ScreenWidth, ScreenHeight*0.05);
    }
    return CGSizeZero;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 0)
    {
        return UIEdgeInsetsMake(ScreenHeight*0.01, 0, 0, 0);
    }
    else if (section == 1)
    {
        return UIEdgeInsetsMake(ScreenHeight*0.022, 0, 0, 0);
    }
    else if (section == 2)
    {
        return UIEdgeInsetsMake(ScreenHeight*0.042, 0, 0, 0);
    }
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark - UICollectionViewDelegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     *  点击提交反馈
     */
    if (indexPath.section == 2)
    {
        /**
         *  保证短时间内点击按钮，只有最后一次有效
         */
        [self.timer invalidate];
        self.timer = nil;
        self.timer =[NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:NO];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
        
    }
    [self.view endEditing:YES];//回缩键盘
    if (!self.feedbackDataViewController.listTableView.isHidden)
    {
        self.feedbackDataViewController.listTableView.hidden = YES;
    }
}

-(void)updateTimer
{
    /**
     *  去掉首尾空格/回车方法
     */
    self.feedbackContent = [self.feedbackContent stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if (!self.feedbackContent || [self.feedbackContent isEqualToString:@""])
    {
        [SVProgressHUD showInfoWithStatus:@"意见不能为空"];
    }
    else
    {
        [self.feedbackDataViewController postFeedbackWithAccessCode:AppManagerSingleton.accessCode
                                                           withType:self.feedbackTypeStr
                                                 withCommentContent:self.feedbackContent
                                                       withCallback:^(BOOL success, NSError *error, id result)
         {
             if (success)
             {
                 [SVProgressHUD showSuccessWithStatus:@"提交成功"];
                 [self.navigationController popViewControllerAnimated:YES];
             }
             else
             {
                 [SVProgressHUD  showInfoWithStatus:result];
             }
         }];
        
    }
    
}


#pragma mark -UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
// 返回每一组有多少行
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listArr.count;
}
// 返回哪一组的哪一行显示什么内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.创建CELL
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    // 2.设置数据
    // 2.1取出对应行的模型
    NSString *name = self.listArr[indexPath.row];
    // 2.2赋值对应的数据
    cell.textLabel.text = name;
    cell.textLabel.font = [UIFont systemFontOfSize:11];
    // 3.返回cell
    return cell;
}
#pragma mark -UITableViewDataSource
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        self.feedbackTypeStr = self.listArr[indexPath.row];
        [self.feedbackDataViewController.collectionView reloadData];
        self.feedbackDataViewController.listTableView.hidden = YES;
    }
}

#pragma mark - FeedbackFirstCollectionViewCellDelegate
-(void)didClickListButtonWithFeedbackFirstCollectionViewCell:(FeedbackFirstCollectionViewCell *)feedbackFirstCollectionViewCell
{
    
    self.feedbackDataViewController.listTableView.hidden = ! self.feedbackDataViewController.listTableView.isHidden;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:kNotify_feedback_Content object:nil];
}

#pragma -mark UICollectionView的点击事件，回缩键盘
-(void)tapCollectionView
{
    [self.view endEditing:YES];
    if (!self.feedbackDataViewController.listTableView.isHidden)
    {
        self.feedbackDataViewController.listTableView.hidden = YES;
    }
    
}
/**
 *  解决collectinView阻挡cell的点击事件/解决UIcollectionView添加手势后不响应其cell的问题
 */
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if (touch.view != self.feedbackDataViewController.collectionView)
    {
        return NO;
    }
    return YES;
}
@end
