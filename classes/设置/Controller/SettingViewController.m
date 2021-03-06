//
//  SettingViewController.m
//  automaintain
//
//  Created by eric on 16/7/4.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingDataViewController.h"
#import "SettingFirstCollectionViewCell.h"
#import "SettingSecondCollectionViewCell.h"
#import "LoginViewController.h"
#import "FeedbackViewController.h"
#import "ModifyPasswordViewController.h"

@interface SettingViewController ()<CustomNavigationViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIAlertViewDelegate,SettingSecondCollectionViewCellDelegate>

@property (nonatomic, strong) SettingDataViewController* settingDataViewController;

@property (nonatomic, strong) NSArray* titleArr;
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.settingDataViewController = [[SettingDataViewController alloc]init];
    self.titleArr = @[@{@"image":@"set_icon",@"title":@"意见反馈"},
                        @{@"image":@"set_pwd",@"title":@"修改密码"}];
    [self configureNavigationView];
    [self configureCollectionView];
}


-(void)configureNavigationView
{
    [self.view addSubview:self.settingDataViewController.customNavigationView];
    self.settingDataViewController.customNavigationView.delegate = self;
    self.settingDataViewController.customNavigationView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topEqualToView(self.view).heightIs(ScreenHeight*0.1);
}

-(void)configureCollectionView
{
    [self.view addSubview:self.settingDataViewController.collectionView];
    
    self.settingDataViewController.collectionView.delegate = self;
    self.settingDataViewController.collectionView.dataSource = self;
    
    self.settingDataViewController.collectionView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topSpaceToView(self.settingDataViewController.customNavigationView,0).bottomEqualToView(self.view);
    
}

#pragma mark - CustomNavigationViewDelegate
-(void)didSelectedLeftButtonAtCustomNavigationView:(CustomNavigationView *)customNavigationView
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return self.titleArr.count>0?self.titleArr.count:0;
    }
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell;
    
    if (indexPath.section == 0)
    {
        SettingFirstCollectionViewCell * firstCell = [SettingFirstCollectionViewCell collectionView:collectionView dequeueReusableCellWithReuseIdentifier:SettingFirstCollectionViewCellId forIndexPath:indexPath];
        [firstCell layoutWithObject:self.titleArr[indexPath.row]];
        cell = firstCell;
    }
    else
    {
        SettingSecondCollectionViewCell * secondCell = [SettingSecondCollectionViewCell collectionView:collectionView dequeueReusableCellWithReuseIdentifier:SettingSecondCollectionViewCellId forIndexPath:indexPath];
        secondCell.delegate = self;
        cell =secondCell;
    }
    
    return cell;
}

#pragma mark - UICollectionViewFlowLayoutDelegate

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return CGSizeMake(ScreenWidth, ScreenHeight*0.064);
    }
    else if (indexPath.section == 1)
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
        return UIEdgeInsetsMake(ScreenHeight*0.058, 0, 0, 0);
    }
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark - UICollectionViewDelegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        if (indexPath.row == 0)
        {
            FeedbackViewController* feedbackViewController = [[FeedbackViewController alloc]init];
            
            [self.navigationController pushViewController:feedbackViewController animated:YES];
        }
        else if (indexPath.row == 1)
        {
            ModifyPasswordViewController* modifyPasswordViewController = [[ModifyPasswordViewController alloc]init];
            
            [self.navigationController pushViewController:modifyPasswordViewController animated:YES];
        }
        
    }
}
#pragma mark - 点击退出登录按钮调用
-(void)didClickSubmitButtonWithSettingSecondCollectionViewCell:(SettingSecondCollectionViewCell *)settingSecondCollectionViewCell
{
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"确定退出?" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.alertViewStyle = UIAlertViewStyleDefault;
    [alertView show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        
    }
    else if (buttonIndex == 1)
    {
        [SVProgressHUD show];
        [self.settingDataViewController logoutWithAccessCode:AppManagerSingleton.accessCode withCallback:^(BOOL success, NSError *error, id result)
         {
             if (success)
             {
                 [SVProgressHUD dismiss];
                 /**
                  *  移除plist里面的数据
                  */
                 [AppManagerSingleton removeDataFromPlist];
                 
                 [self.navigationController popToViewController:SharedAppDelegateHelper.loginViewController animated:YES];
             }
             else
             {
                 [SVProgressHUD showInfoWithStatus:result];
             }
         }];
    }
    
}

@end
