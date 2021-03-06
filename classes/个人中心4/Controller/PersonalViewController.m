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
/**
 *  头像照片
 */
@property (nonatomic, strong) UIImage* avatorImage;

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
    BaseCollectionViewCell * cell;
    id object = nil;
    if (indexPath.section == 0)
    {
        PersonalFirstCollectionViewCell * firstCell = [PersonalFirstCollectionViewCell collectionView:collectionView dequeueReusableCellWithReuseIdentifier:personalFirstId forIndexPath:indexPath];
        object = AppManagerSingleton.AvatarUrl;
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
        cell = thirdCell;
    }
    else
    {
        PersonalFourCollectionViewCell * fourCell = [PersonalFourCollectionViewCell collectionView:collectionView dequeueReusableCellWithReuseIdentifier:personalFourId forIndexPath:indexPath];
        cell = fourCell;
    }
    [cell layoutWithObject:object];
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

#pragma mark - 点击选择相机PersonalDataViewControllerDelegate

-(void)didClickShowCameraMethod:(PersonalDataViewController *)personalDataViewController
{
    //    iOS 判断应用是否有使用相机的权限
    
    NSString *mediaType = AVMediaTypeVideo;//读取媒体类型
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];//读取设备授权状态
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied)
    {
        [SVProgressHUD showInfoWithStatus:@"请在iPhone的\"设置-隐私-相机\"中允许访问相机"];
        return;
    }
    
    [TuSDKTSDeviceSettings checkAllowWithController:self
                                               type:lsqDeviceSettingsCamera
                                          completed:^(lsqDeviceSettingsType type, BOOL openSetting)
     {
         if (openSetting)
         {
             lsqLError(@"Can not open camera");
             return;
         }
         [self showCameraController];
     }];
}

- (void)showCameraController;
{
    
    TuSDKPFCameraOptions *opt = [TuSDKPFCameraOptions build];
    /* 这里是 option 配置功能选项，配置相机的功能，请以 TuSDK 官方 demo 为准 */
    TuSDKPFCameraViewController *controller = opt.viewController;
    controller.delegate = self;
    [self presentModalNavigationController:controller animated:YES];
    
}
#pragma mark - TuSDKPFCameraDelegate
/**
 *  获取一个拍摄结果
 *
 *  @param controller 默认相机视图控制器
 *  @param result     拍摄结果
 */
- (void)onTuSDKPFCamera:(TuSDKPFCameraViewController *)controller captureResult:(TuSDKResult *)result;
{
    
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
    self.avatorImage = result.image;
    [self updateAvatorImage];//更新头像
    [self.personalDataViewController.collectionView reloadData];
    
}

#pragma mark - TuSDKCPComponentErrorDelegate
/**
 *  获取组件返回错误信息
 *
 *  @param controller 控制器
 *  @param result     返回结果
 *  @param error      异常信息
 */
- (void)onComponent:(TuSDKCPViewController *)controller result:(TuSDKResult *)result error:(NSError *)error;
{
    lsqLDebug(@"onComponent: controller - %@, result - %@, error - %@", controller, result, error);
}

/**
 *  打开本地相册
 */
-(void)didClickShowLocalAlbumMethod:(PersonalDataViewController *)personalDataViewController
{
    UIImagePickerController* localAlbumImagePicker = [[UIImagePickerController alloc]init];
    [localAlbumImagePicker setSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum  ];
    localAlbumImagePicker.delegate = self;
    localAlbumImagePicker.allowsEditing = YES;
    [self presentViewController:localAlbumImagePicker animated:YES completion:nil];
}
#pragma mark - 照片选择代理方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    
    UIImage* avatorImage = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    self.avatorImage = avatorImage;
    [self updateAvatorImage];//更新头像
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.personalDataViewController.collectionView reloadData];
    
}

#pragma mark - 上传选中的照片，获取photoGuid
-(void)updateAvatorImage
{
    __weak PersonalViewController* weakSelf = self;
    [SVProgressHUD show];
    [self.personalDataViewController postUploadPhotoFileWithImage:self.avatorImage
                                                     withCallback:^(BOOL success, NSError *error, id result)
     {
         if (success)
         {
             NSString* photoGuid = result;
             [weakSelf updateCustomerAvatorWithPhotoGuid:photoGuid];
         }
         else
         {
             if (!result || [result isEqual:[NSNull null]])
             {
                 return;
             }
             [SVProgressHUD showInfoWithStatus:(NSString*)result];
         }
     }];

}
#pragma mark - 得到照片上传后的guid，更新用户头像
-(void)updateCustomerAvatorWithPhotoGuid:(NSString*)photoGuid
{
    [self.personalDataViewController postUpdateCustomerAvatarWithAccessCode:AppManagerSingleton.accessCode
                                                              withPhotoGuid:photoGuid
                                                               withCallback:^(BOOL success, NSError *error, id result)
     {
         if (success)
         {
             [SVProgressHUD showSuccessWithStatus:@"头像更新成功"];
             [[NSUserDefaults standardUserDefaults]setObject:result forKey:@"AvatarUrl"];
             [[NSUserDefaults standardUserDefaults]synchronize];
             [self.personalDataViewController.collectionView reloadData];
         }
         else
         {
             [SVProgressHUD showInfoWithStatus:result];
         }
     }];
    
}
@end
