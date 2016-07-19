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

@interface MyOrderViewController ()<CustomNavigationViewDelegate,UITableViewDelegate,UITableViewDataSource,MyOrderTableViewCellDelegate>
@property (nonatomic, strong) MyOrderDataViewController * myOrderDataViewController;

/**
 *  我的预约模型数组
 */
@property (nonatomic, strong) NSArray* myOrderModelArr;

/**
 *  刷新翻页，下拉刷新index=0，下拉刷新index+=1
 */
@property (nonatomic, assign) NSInteger index;
@end

@implementation MyOrderViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.myOrderDataViewController = [[MyOrderDataViewController alloc]init];
    [self configureNavigationView];
    [self configureTableView];

    [self loadMJRefreshMethod];//配置刷新
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
    [self.myOrderDataViewController.customTableView.mj_header beginRefreshing];//开始刷新
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
    else
    {
        self.index += 1;
    }
    
    NSString* indexStr = [NSString stringWithFormat:@"%ld",self.index];
    [self.myOrderDataViewController postMyOrderListWithAccessCode:AppManagerSingleton.accessCode withPageIndex:indexStr withCallback:^(BOOL success, NSError *error, id result)
     {
         [self.myOrderDataViewController.customTableView.mj_header endRefreshing];//结束刷新
         [self.myOrderDataViewController.customTableView.mj_footer endRefreshing];//结束刷新
         if (success)
         {
             self.myOrderModelArr = (NSArray*)result;
             [self.myOrderDataViewController.customTableView reloadData];
         }
         else
         {
             [SVProgressHUD showErrorWithStatus:result];
         }
     }];
   }

#pragma mark - CustomNavigationViewDelegate
-(void)didSelectedLeftButtonAtCustomNavigationView:(CustomNavigationView *)customNavigationView
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.myOrderModelArr.count>0?self.myOrderModelArr.count:0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = nil;
    
    MyOrderTableViewCell* myOrderTableViewCell = [MyOrderTableViewCell tableView:tableView dequeueReusableCellWithReuseIdentifier:MyOrderTableViewCellId forIndexPath:indexPath];
    myOrderTableViewCell.delegate = self;
    [myOrderTableViewCell layoutWithObject:self.myOrderModelArr[indexPath.row]];
    cell = myOrderTableViewCell;
    
    return cell;
}
#pragma mark -UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScreenHeight*0.18;
}

#pragma mark - MyOrderTableViewCellDelegate
-(void)didSelectedCommentButtonWithMyOrderTableViewCell:(MyOrderTableViewCell *)myOrderTableViewCell
{
    MyCommentViewController* myCommentViewController = [[MyCommentViewController alloc]init];
    
    [self.navigationController pushViewController:myCommentViewController animated:YES];
}
@end
