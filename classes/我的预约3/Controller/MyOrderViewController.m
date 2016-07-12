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

@property (nonatomic, strong) NSArray* stateArr;

@end

@implementation MyOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myOrderDataViewController = [[MyOrderDataViewController alloc]init];
    self.stateArr = @[@{@"state":@"已审核",@"button":@"取消预约",@"time":@""},
                      @{@"state":@"服务中",@"button":@"",@"time":@"距离完成时间：01:20:30"},
                      @{@"state":@"已完成",@"button":@"发表评论",@"time":@""}];
    [self configureNavigationView];
    [self configureTableView];
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
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = nil;
    
    MyOrderTableViewCell* myOrderTableViewCell = [MyOrderTableViewCell tableView:tableView dequeueReusableCellWithReuseIdentifier:MyOrderTableViewCellId forIndexPath:indexPath];
    myOrderTableViewCell.delegate = self;
    [myOrderTableViewCell layoutWithObject:self.stateArr[indexPath.row]];
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
