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
#import "OrderTypeModel.h"
#import "MaintenanceViewController.h"

@interface TypeSelectedViewController ()<CustomNavigationViewDelegate,UITableViewDelegate,UITableViewDataSource,TypeSelectedViewDelegate,CustomTypeSelectedTableViewCellDelegate>
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
            [self findSelectedOrderTypeModel];//遍历数组寻找已选择的按钮
            [self.typeSelectedDataViewController.customTableView reloadData];
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:result];
        }
    }];
}

-(void)findSelectedOrderTypeModel
{
    if (self.typeSelectedDataViewController.typeSelectedArr.count>0)
    {
        for (OrderTypeModel* tempModel in self.typeSelectedDataViewController.typeSelectedArr)
        {
            if ([self.orderTypeModel.Guid isEqualToString:tempModel.Guid])
            {
                tempModel.IsSelected = YES;
            }
        }
    }
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
    return self.typeSelectedDataViewController.typeSelectedArr.count>0?self.typeSelectedDataViewController.typeSelectedArr.count:0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = nil;
    
    CustomTypeSelectedTableViewCell* customTypeSelectedTableViewCell = [CustomTypeSelectedTableViewCell tableView:tableView dequeueReusableCellWithReuseIdentifier:CustomTypeSelectedTableViewCellId forIndexPath:indexPath];
    customTypeSelectedTableViewCell.delegate = self;
    cell = customTypeSelectedTableViewCell;
    [customTypeSelectedTableViewCell layoutWithObject:self.typeSelectedDataViewController.typeSelectedArr[indexPath.row]];
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
    [self.typeSelectedDataViewController.typeSelectedArr addObjectsFromArray:self.typeSelectedDataViewController.beautyServiceArr];
    [self findSelectedOrderTypeModel];
    [self.typeSelectedDataViewController.customTableView reloadData];
}

-(void)didClickMaintenanceButtonWithTypeSelectedView:(TypeSelectedView *)typeSelectedView
{
    [self.typeSelectedDataViewController.typeSelectedArr removeAllObjects];
    [self.typeSelectedDataViewController.typeSelectedArr addObjectsFromArray:self.typeSelectedDataViewController.maintenanceArr];
    [self findSelectedOrderTypeModel];
    [self.typeSelectedDataViewController.customTableView reloadData];
}
#pragma mark - 点击选择按钮调用CustomTypeSelectedTableViewCellDelegate
-(void)didSelectedCustomTypeSelectedTableViewCell:(CustomTypeSelectedTableViewCell *)customTypeSelectedTableViewCell
{
    NSIndexPath* indexPath = [self.typeSelectedDataViewController.customTableView indexPathForCell:customTypeSelectedTableViewCell];
    OrderTypeModel* orderTypeModel = self.typeSelectedDataViewController.typeSelectedArr[indexPath.row];
    
    orderTypeModel.IsSelected = YES;//选择状态改为已选择
    SharedAppDelegateHelper.maintenanceViewController.orderTypeModel = orderTypeModel;

    [self.navigationController popToViewController:SharedAppDelegateHelper.maintenanceViewController animated:YES];
}
@end
