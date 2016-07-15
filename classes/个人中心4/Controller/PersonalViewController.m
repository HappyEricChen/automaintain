//
//  PersonalViewController.m
//  automaintain
//
//  Created by eric on 16/6/29.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "PersonalViewController.h"
#import "PersonalDataViewController.h"
#import "PersonalFirstCollectionViewCell.h"
#import "PersonalSecondCollectionViewCell.h"
#import "personalThirdCollectionViewCell.h"
#import "PersonalFourCollectionViewCell.h"
#import "MyOrderViewController.h"
#import "OnlineMessageViewController.h"
#import "SettingViewController.h"
#import "PersonalModel.h"

@interface PersonalViewController ()<CustomNavigationViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,PersonalDataViewControllerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, strong) PersonalDataViewController* personalDataViewController;

@property (nonatomic, strong) NSArray* contentArr;//item显示文字/图片

@end

@implementation PersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.personalDataViewController = [[PersonalDataViewController alloc]init];
    self.personalDataViewController.delegate = self;
    self.contentArr = @[@{@"image":@"personal_order",@"name":@"我的预约"},
                        @{@"image":@"personal_online",@"name":@"在线留言"}];
    [self configureNavigationView];
    [self configureCollectionView];
}

-(void)configureNavigationView
{
    [self.view addSubview:self.personalDataViewController.customNavigationView];
    self.personalDataViewController.customNavigationView.delegate = self;
    self.personalDataViewController.customNavigationView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topEqualToView(self.view).heightIs(ScreenHeight*0.1);
}
-(void)configureCollectionView
{
    [self.view addSubview:self.personalDataViewController.collectionView];
    
    self.personalDataViewController.collectionView.delegate = self;
    self.personalDataViewController.collectionView.dataSource = self;
    
    self.personalDataViewController.collectionView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topSpaceToView(self.personalDataViewController.customNavigationView,0).bottomEqualToView(self.view);
}

#pragma mark - CustomNavigationViewDelegate
-(void)didSelectedRightButtonAtCustomNavigationView:(CustomNavigationView *)customNavigationView
{
    SettingViewController* settingViewController = [[SettingViewController alloc]init];
    
    [self.navigationController pushViewController:settingViewController animated:YES];
}
-(void)didSelectedLeftButtonAtCustomNavigationView:(CustomNavigationView *)customNavigationView
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 4;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 2)
    {
        return 2;
    }
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = nil;
    id object = nil;
    if (indexPath.section == 0)
    {
        PersonalFirstCollectionViewCell * firstCell = [PersonalFirstCollectionViewCell collectionView:collectionView dequeueReusableCellWithReuseIdentifier:personalFirstId forIndexPath:indexPath];
        [firstCell layoutWithObject:self.personalDataViewController.personalModel.headImage];
        cell = firstCell;
    }
    else if (indexPath.section == 1)
    {
        PersonalSecondCollectionViewCell * secondCell = [PersonalSecondCollectionViewCell collectionView:collectionView dequeueReusableCellWithReuseIdentifier:personalSecondId forIndexPath:indexPath];
        cell =secondCell;
    }
    else if (indexPath.section == 2)
    {
        PersonalThirdCollectionViewCell * thirdCell = [PersonalThirdCollectionViewCell collectionView:collectionView dequeueReusableCellWithReuseIdentifier:personalThirdId forIndexPath:indexPath];
        object = self.contentArr[indexPath.row];
        [thirdCell layoutWithObject:object];
        cell = thirdCell;
    }
    else if (indexPath.section == 3)
    {
        PersonalFourCollectionViewCell * fourCell = [PersonalFourCollectionViewCell collectionView:collectionView dequeueReusableCellWithReuseIdentifier:personalFourId forIndexPath:indexPath];
        cell = fourCell;
    }
    
    return cell;
}

#pragma mark - UICollectionViewFlowLayoutDelegate

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return CGSizeMake(ScreenWidth, ScreenHeight*0.127);
    }
    else if (indexPath.section == 1)
    {
        return CGSizeMake(ScreenWidth, ScreenHeight*0.073);
    }
    else if (indexPath.section == 2)
    {
        return CGSizeMake(ScreenWidth, ScreenHeight*0.073);
    }
    else if (indexPath.section == 3)
    {
        return CGSizeMake(ScreenWidth, ScreenHeight*0.073);
    }
    return CGSizeZero;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 1 || section == 2 || section == 3)
    {
        return UIEdgeInsetsMake(ScreenHeight*0.024, 0, 0, 0);
    }
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
#pragma mark - UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
//        if ([[[UIDevice currentDevice] systemVersion]doubleValue]>=8)
//        {
//            UIAlertController* alertController = self.personalDataViewController.alertController;
//            [self presentViewController:alertController animated:YES completion:nil];
//        }
//        else
        {
            [self.personalDataViewController.actionSheet showInView:self.view];
        }
    }
    else if (indexPath.section == 2)
    {
        if (indexPath.row == 0)
        {
            MyOrderViewController* myOrderViewController = [[MyOrderViewController alloc]init];
            
            [self.navigationController pushViewController:myOrderViewController animated:YES];
        }
        else if (indexPath.row == 1)
        {
            OnlineMessageViewController* onlineMessageViewController = [[OnlineMessageViewController alloc]init];
            
            [self.navigationController pushViewController:onlineMessageViewController animated:YES];
        }
    }
    else if (indexPath.section == 3)
    {
        /**
         *  跳转到打电话
         */
//        NSString* number = @"4002-9889-888";
        NSURL* url = [NSURL URLWithString:@"telprompt://4002-9889-888"];
        [[UIApplication sharedApplication]openURL:url];
    }
}

#pragma mark - PersonalDataViewControllerDelegate

-(void)didClickShowCameraMethod:(PersonalDataViewController *)personalDataViewController
{
    UIImagePickerController* imagePicker = [[UIImagePickerController alloc]init];
    [imagePicker setDelegate:self];
    [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
    [imagePicker setAllowsEditing:YES];
    [self presentViewController:imagePicker animated:YES completion:nil];
}

-(void)didClickShowLocalAlbumMethod:(PersonalDataViewController *)personalDataViewController
{
    UIImagePickerController* localAlbumImagePicker = [[UIImagePickerController alloc]init];
    [localAlbumImagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    localAlbumImagePicker.delegate = self;
    localAlbumImagePicker.allowsEditing = YES;
    [self presentViewController:localAlbumImagePicker animated:YES completion:nil];
}
#pragma mark - UIImagePickerControllerDelegate选择图片代理方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    
    self.personalDataViewController.personalModel.headImage = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.personalDataViewController.collectionView reloadData];
}

@end
