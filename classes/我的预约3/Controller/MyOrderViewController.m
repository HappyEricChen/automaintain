//
//  MyOrderViewController.m
//  automaintain
//
//  Created by eric on 16/6/30.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "MyOrderViewController.h"
#import "MyOrderDataViewController.h"
#import "MyOrderTableViewCell.h"
#import "MyCommentViewController.h"
#import "MyOrderModel.h"

@interface MyOrderViewController ()<CustomNavigationViewDelegate,UITableViewDelegate,UITableViewDataSource,MyOrderTableViewCellDelegate>
@property (nonatomic, strong) MyOrderDataViewController * myOrderDataViewController;


/**
 *  刷新翻页，下拉刷新index=0，下拉刷新index+=1
 */
@property (nonatomic, assign) NSInteger index;


@property (nonatomic, strong) NSTimer        *m_timer;
@end

@implementation MyOrderViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.myOrderDataViewController = [[MyOrderDataViewController alloc]init];
    [self configureNavigationView];
    [self configureTableView];

    [self loadMJRefreshMethod];//配置刷新
    
}

- (void)createTimer
{
    
    self.m_timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerEvent) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_m_timer forMode:NSRunLoopCommonModes];
}

- (void)timerEvent
{
    
    for (int count = 0; count < self.myOrderDataViewController.myOrderModelArr.count; count++)
    {
        
        MyOrderModel *myOrderModel = self.myOrderDataViewController.myOrderModelArr[count];
        
        if ([myOrderModel.AppointmentStatus isEqualToString:@"InService"])
        {
            /**
             *  把服务器传回来的时间中的T去掉
             */
//            NSString* startTimeFormate = [myOrderModel.StartTime stringByReplacingOccurrencesOfString:@"T" withString:@" "];
            NSString* endTimeFormate = [myOrderModel.EndTime stringByReplacingOccurrencesOfString:@"T" withString:@" "];
            ;
            //倒计时时间
            myOrderModel.m_countNum=[TransferTimeSingleton.shareTransfer transferTimeStringToIntervalWith:endTimeFormate];
            
            [myOrderModel countDown];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotify_CountDown_Time object:nil];
        }
        else
        {
            myOrderModel.m_countNum = 0;
        }
       
    }
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    /**
     *  开始刷新
     */
    [self.myOrderDataViewController.customTableView.mj_header beginRefreshing];
}

-(void)configureNavigationView
{
    [self.view addSubview:self.myOrderDataViewController.customNavigationView];
    self.myOrderDataViewController.customNavigationView.delegate = self;
    self.myOrderDataViewController.customNavigationView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topEqualToView(self.view).heightIs(ScreenHeight*0.1);
}


-(void)configureTableView
{
    [self.view addSubview:self.myOrderDataViewController.customTableView];
    
    self.myOrderDataViewController.customTableView.delegate = self;
    self.myOrderDataViewController.customTableView.dataSource = self;
    self.myOrderDataViewController.customTableView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topSpaceToView(self.myOrderDataViewController.customNavigationView,0).bottomEqualToView(self.view);
    
}

-(void)loadMJRefreshMethod
{
    self.index = 0;//初始化
    
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadDataFromService:)];
    self.myOrderDataViewController.customTableView.mj_header = header;
    self.myOrderDataViewController.customTableView.mj_header.automaticallyChangeAlpha = YES;
    
    MJRefreshAutoNormalFooter * footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadDataFromService:)];
    self.myOrderDataViewController.customTableView.mj_footer = footer;
    
}

-(void)loadDataFromService:(MJRefreshComponent*)headerFooterView
{
    
    if ([headerFooterView isKindOfClass:[MJRefreshNormalHeader class]])
    {
         self.index = 0;
    }
    
    NSString* indexStr = [NSString stringWithFormat:@"%ld",self.index];
    [self.myOrderDataViewController postMyOrderListWithAccessCode:AppManagerSingleton.accessCode withPageIndex:indexStr withCallback:^(BOOL success, NSError *error, id result)
     {
         if (success)
         {
             /**
              *  创建倒计时的计时器
              */
             if (self.index == 0)
             {
                 [self createTimer];
             }
             
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

#pragma mark - CustomNavigationViewDelegate
-(void)didSelectedLeftButtonAtCustomNavigationView:(CustomNavigationView *)customNavigationView
{
    [self.navigationController popToViewController:SharedAppDelegateHelper.homeViewController animated:YES];
//    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.myOrderDataViewController.myOrderModelArr.count>0?self.myOrderDataViewController.myOrderModelArr.count:0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = nil;
    
    MyOrderTableViewCell* myOrderTableViewCell = [MyOrderTableViewCell tableView:tableView dequeueReusableCellWithReuseIdentifier:MyOrderTableViewCellId forIndexPath:indexPath];
    myOrderTableViewCell.delegate = self;
    [myOrderTableViewCell layoutWithObject:self.myOrderDataViewController.myOrderModelArr[indexPath.row] indexPath:indexPath];
    cell = myOrderTableViewCell;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BaseTableViewCell *tmpCell = (BaseTableViewCell *)cell;
    tmpCell.m_isDisplayed            = YES;
    
    [tmpCell layoutWithObject:self.myOrderDataViewController.myOrderModelArr[indexPath.row] indexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath {
    
    BaseTableViewCell *tmpCell = (BaseTableViewCell *)cell;
    
    tmpCell.m_isDisplayed = NO;
}

#pragma mark -UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScreenHeight*0.18;
}

#pragma mark - MyOrderTableViewCellDelegate
/**
 *  点击评论按钮
 */
-(void)didSelectedCommentButtonWithMyOrderTableViewCell:(MyOrderTableViewCell *)myOrderTableViewCell
{
    NSIndexPath* indexPath = [self.myOrderDataViewController.customTableView indexPathForCell:myOrderTableViewCell];
    MyCommentViewController* myCommentViewController = [[MyCommentViewController alloc]init];
    myCommentViewController.myOrderModel = self.myOrderDataViewController.myOrderModelArr[indexPath.row];
    [self.navigationController pushViewController:myCommentViewController animated:YES];
}
/**
 *  点击取消预约按钮
 */
-(void)didSelectedCancelOrderButtonWithMyOrderTableViewCell:(MyOrderTableViewCell *)myOrderTableViewCell
{
    NSIndexPath* indexpath = [self.myOrderDataViewController.customTableView indexPathForCell:myOrderTableViewCell];
    
    MyOrderModel* myOrderModel = self.myOrderDataViewController.myOrderModelArr[indexpath.row];
    
    [self.myOrderDataViewController postCancelOrderWithAccessCode:AppManagerSingleton.accessCode withAppointmentGuid:myOrderModel.AppointmentGuid withCallback:^(BOOL success, NSError *error, id result)
    {
        if (success)
        {
            [SVProgressHUD showSuccessWithStatus:@"取消成功"];
            [self.myOrderDataViewController.customTableView.mj_header beginRefreshing];//开始刷新
        }
        else
        {
            [SVProgressHUD showInfoWithStatus:result];
        }
    }];
}
@end
