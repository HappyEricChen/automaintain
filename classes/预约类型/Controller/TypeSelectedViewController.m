//
//  TypeSelectedViewController.m
//  automaintain
//
//  Created by eric on 16/6/29.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "TypeSelectedViewController.h"
#import "TypeSelectedDataViewController.h"
#import "TypeSelectedView.h"
#import "CustomTypeSelectedTableViewCell.h"

@interface TypeSelectedViewController ()<CustomNavigationViewDelegate,UITableViewDelegate,UITableViewDataSource,TypeSelectedViewDelegate>
@property (nonatomic, strong) TypeSelectedDataViewController * typeSelectedDataViewController;

@end

@implementation TypeSelectedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.typeSelectedDataViewController = [[TypeSelectedDataViewController alloc]init];
    [self configureNavigationView];
    [self configureSelectedView];
    [self configureTableView];
    
    [self loadDataFromService];
}

-(void)configureNavigationView
{
    [self.view addSubview:self.typeSelectedDataViewController.customNavigationView];
    self.typeSelectedDataViewController.customNavigationView.delegate = self;
    self.typeSelectedDataViewController.customNavigationView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topEqualToView(self.view).heightIs(ScreenHeight*0.1);
}

-(void)configureSelectedView
{
    [self.view addSubview:self.typeSelectedDataViewController.typeSelectedView];
    self.typeSelectedDataViewController.typeSelectedView.delegate = self;
    self.typeSelectedDataViewController.typeSelectedView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topSpaceToView(self.typeSelectedDataViewController.customNavigationView,0).heightIs(ScreenHeight*0.052);
}

-(void)configureTableView
{
    [self.view addSubview:self.typeSelectedDataViewController.customTableView];
    
    self.typeSelectedDataViewController.customTableView.delegate = self;
    self.typeSelectedDataViewController.customTableView.dataSource = self;
    
    self.typeSelectedDataViewController.customTableView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topSpaceToView(self.typeSelectedDataViewController.typeSelectedView,6).bottomEqualToView(self.view);
}

-(void)loadDataFromService
{
    [self.typeSelectedDataViewController postOrderTypeListWithAccessCode:AppManagerSingleton.accessCode withCallback:^(BOOL success, NSError *error, id result)
    {
        if (success)
        {
            
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
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = nil;
    
    CustomTypeSelectedTableViewCell* customTypeSelectedTableViewCell = [CustomTypeSelectedTableViewCell tableView:tableView dequeueReusableCellWithReuseIdentifier:CustomTypeSelectedTableViewCellId forIndexPath:indexPath];
    cell = customTypeSelectedTableViewCell;
    [customTypeSelectedTableViewCell layoutWithObject:self.typeSelectedDataViewController.typeSelectedArr[0]];
    return cell;
}
#pragma mark -UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScreenHeight*0.129;
}

#pragma mark - TypeSelectedViewDelegate选择洗车还是维修
-(void)didClickWashCarButtonWithTypeSelectedView:(TypeSelectedView *)typeSelectedView
{
    [self.typeSelectedDataViewController.typeSelectedArr removeAllObjects];
    [self.typeSelectedDataViewController.typeSelectedArr addObjectsFromArray: @[@{@"name":@"全车打蜡",@"content":@"SONAX蜡; 施工约60分钟; 洗车+机器打蜡",@"price":@"￥588"}]];
    
    [self.typeSelectedDataViewController.customTableView reloadData];
}

-(void)didClickMaintenanceButtonWithTypeSelectedView:(TypeSelectedView *)typeSelectedView
{
    [self.typeSelectedDataViewController.typeSelectedArr removeAllObjects];
    [self.typeSelectedDataViewController.typeSelectedArr addObjectsFromArray: @[@{@"name":@"空调电器系统",@"content":@"大修空调系统; 施工约120分钟; 检测/更换空调冷疑器",@"price":@"￥1000"}]];
    [self.typeSelectedDataViewController.customTableView reloadData];
}
@end
