//
//  MyCommentViewController.m
//  automaintain
//
//  Created by eric on 16/7/1.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "MyCommentViewController.h"
#import "MyCommentDataViewController.h"
#import "MyCommentFirstCollectionViewCell.h"
#import "MyCommentSecondCollectionViewCell.h"
#import "MyCommentThirdCollectionViewCell.h"
#import "MyCommentFourCollectionViewCell.h"
#import "MyOrderModel.h"
#import "ImageAmplificationViewController.h"

@interface MyCommentViewController ()<CustomNavigationViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,MyCommentDataViewControllerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,MyCommentThirdCollectionViewCellDelegate,MyCommentFourCollectionViewCellDelegate,TuSDKPFCameraDelegate>

@property (nonatomic, strong) MyCommentDataViewController* myCommentDataViewController;
/**
 *  评论星星的分数
 */
@property (nonatomic, strong) NSString* starScore;
/**
 *  评论的内容
 */
@property (nonatomic, strong) NSString* commentContent;
/**
 *   当前选择的图片
 */
@property (nonatomic, strong) UIImage* image;

/**
 *  照片返回的guid字符串拼接，提交评论时需要
 */
@property (nonatomic, strong) NSString* photoGuidList;
/**
 *  定时器，用来防止按钮多次点击
 */
@property (nonatomic, strong) NSTimer* timer;
/**
 *  提交按钮只能点击一次
 */
@property (nonatomic, assign) BOOL LockButton;
@end

@implementation MyCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myCommentDataViewController = [[MyCommentDataViewController alloc]init];
    self.myCommentDataViewController.delegate = self;
    [self configureNavigationView];
    [self configureCollectionView];
    /**
     *  接收星星数
     */
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveStarScore:) name:kNotify_comment_StarScore object:nil];
    /**
     *  接收评论内容
     */
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveCommentContent:) name:kNotify_comment_Content object:nil];
    /**
     *  接收取消键盘消息
     */
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveCancelKeyboard:) name:kNotify_cancel_Keyboard object:nil];
    
    
    self.starScore = @"5";//初始化星星为5
    
    self.photoGuidList = @"";//初始化图片字符串
    
    self.LockButton = YES;//初始化提交按钮，锁的状态
}


-(void)configureNavigationView
{
    [self.view addSubview:self.myCommentDataViewController.customNavigationView];
    self.myCommentDataViewController.customNavigationView.delegate = self;
    self.myCommentDataViewController.customNavigationView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topEqualToView(self.view).heightIs(ScreenHeight*0.1);
}

-(void)configureCollectionView
{
    [self.view addSubview:self.myCommentDataViewController.collectionView];
    
    self.myCommentDataViewController.collectionView.delegate = self;
    self.myCommentDataViewController.collectionView.dataSource = self;
    
    self.myCommentDataViewController.collectionView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topSpaceToView(self.myCommentDataViewController.customNavigationView,0).bottomEqualToView(self.view);
}


-(void)receiveStarScore:(NSNotification*)object
{
    self.starScore = [object.userInfo objectForKey:@"score"];
}
-(void)receiveCommentContent:(NSNotification*)object
{
    self.commentContent = [object.userInfo objectForKey:@"textViewContent"];
}
#pragma mark - CustomNavigationViewDelegate
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
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BaseCollectionViewCell * cell;
    id object = nil;
    if (indexPath.section == 0)
    {
        MyCommentFirstCollectionViewCell * firstCell = [MyCommentFirstCollectionViewCell collectionView:collectionView dequeueReusableCellWithReuseIdentifier:MyCommentFirstCollectionViewCellId forIndexPath:indexPath];
        object = self.myOrderModel.AppointmentName;
        cell = firstCell;
    }
    else if (indexPath.section == 1)
    {
        MyCommentSecondCollectionViewCell * secondCell = [MyCommentSecondCollectionViewCell collectionView:collectionView dequeueReusableCellWithReuseIdentifier:MyCommentSecondCollectionViewCellId forIndexPath:indexPath];
        cell =secondCell;
    }
    else if (indexPath.section == 2)
    {
        MyCommentThirdCollectionViewCell * thirdCell = [MyCommentThirdCollectionViewCell collectionView:collectionView dequeueReusableCellWithReuseIdentifier:MyCommentThirdCollectionViewCellId forIndexPath:indexPath];
        thirdCell.delegate = self;
        object = self.image;
        cell = thirdCell;
    }
    else
    {
        MyCommentFourCollectionViewCell * fourCell = [MyCommentFourCollectionViewCell collectionView:collectionView dequeueReusableCellWithReuseIdentifier:MyCommentFourCollectionViewCellId forIndexPath:indexPath];
        fourCell.delegate = self;
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
        return CGSizeMake(ScreenWidth, ScreenHeight*0.118);
    }
    else if (indexPath.section == 1)
    {
        return CGSizeMake(ScreenWidth, ScreenHeight*0.163);
    }
    else if (indexPath.section == 2)
    {
        return CGSizeMake(ScreenWidth, ScreenHeight*0.18);
    }
    else if (indexPath.section == 3)
    {
        return CGSizeMake(ScreenWidth, ScreenHeight*0.049);
    }
    return CGSizeZero;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 1)
    {
        return UIEdgeInsetsMake(ScreenHeight*0.03, 0, 0, 0);
    }
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark - 提交评论按钮点击后调用
-(void)didClickSubmitButtonWithMyCommentFourCollectionViewCell:(MyCommentFourCollectionViewCell *)myCommentFourCollectionViewCell
{
    if (self.LockButton)
    {
        /**
         *  保证短时间内点击按钮，只有最后一次有效
         */
        [self.timer invalidate];
        self.timer = nil;
        self.timer =[NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:NO];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
        
    }
    
}

-(void)updateTimer
{
    if (!self.commentContent || [self.commentContent isEqualToString:@""])
    {
        [SVProgressHUD showInfoWithStatus:@"评论不能为空"];
    }
    else
    {
        /**
         *  先锁住按钮
         */
        self.LockButton = NO;
        /**
         *  再上传图片
         */
        [self updateCommentPhotos];
    }
    
}

#pragma mark - 评论图片上传方法
-(void)updateCommentPhotos
{
    __weak MyCommentViewController* weakSelf = self;
    [SVProgressHUD show];
    [self.myCommentDataViewController runDispatchTestWithCallback:^(BOOL success, NSError *error, id result)
     {
         
         if (success)
         {
             [SVProgressHUD dismiss];
             
             /**
              *  拼接返回回来的guid字符串
              */
             for (NSString* guidStr in self.myCommentDataViewController.imageGuidArr)
             {
                 if (!self.photoGuidList || [self.photoGuidList isEqualToString:@""])
                 {
                     weakSelf.photoGuidList = [weakSelf.photoGuidList stringByAppendingString:guidStr];
                 }
                 else
                 {
                     weakSelf.photoGuidList = [NSString stringWithFormat:@"%@|%@",self.photoGuidList,guidStr];
                 }
             }
             
             /**
              *  调用上传评论接口
              */
             [self updateCommentWithGuid];
         }
         else
         {
             /**
              *  解锁
              */
             self.LockButton = YES;
             self.photoGuidList = @"";//清空guid字符串
             [self.myCommentDataViewController.imageGuidArr removeAllObjects];//清空guid数组
             [SVProgressHUD showInfoWithStatus:@"网络不好请重试"];
         }
    }];
       
}
#pragma mark - 调用上传评论接口
-(void)updateCommentWithGuid
{
    /**
     *  去掉首尾空格/回车方法
     */
    self.commentContent = [self.commentContent stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if (!self.commentContent || [self.commentContent isEqualToString:@""])
    {
        [SVProgressHUD showInfoWithStatus:@"评论不能为空"];
        /**
         *  解锁
         */
        self.LockButton = YES;
    }
    else
    {
        [SVProgressHUD show];
        [self.myCommentDataViewController postCommentToServiceWithAccessCode:AppManagerSingleton.accessCode
                                                                   withStars:self.starScore
                                                             withContentText:self.commentContent
                                                     withMaintainSubjectGuid:SubjectGuidWashCar
                                                         withAppointmentGuid:self.myOrderModel.AppointmentGuid
                                                           withPhotoGuidList:self.photoGuidList
                                                                withCallback:^(BOOL success, NSError *error, id result)
         {
             if (success)
             {
                 [SVProgressHUD showSuccessWithStatus:@"评论成功"];
                 [self.navigationController popViewControllerAnimated:YES];
                 /**
                  *  解锁
                  */
                 self.LockButton = YES;
             }
             else
             {
                 [SVProgressHUD showInfoWithStatus:result];
                  self.photoGuidList = @"";//清空guid字符串
                 [self.myCommentDataViewController.imageGuidArr removeAllObjects];//清空guid数组
                 /**
                  *  解锁
                  */
                 self.LockButton = YES;
             }
         }];
    }
}
#pragma mark - MyCommentDataViewControllerDelegate
/**
 *  点击选择相机
 */
-(void)didClickShowCameraMethod:(MyCommentViewController *)personalDataViewController
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
         if (openSetting) {
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
    self.image = result.image;//图片调整方向为正向
    [self.myCommentDataViewController.imageArr addObject:self.image];
    [self.myCommentDataViewController.collectionView reloadData];
    
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
 *  点击选择相册
 */
-(void)didClickShowLocalAlbumMethod:(MyCommentViewController *)personalDataViewController
{
    UIImagePickerController* localAlbumImagePicker = [[UIImagePickerController alloc]init];
    localAlbumImagePicker.delegate = self;
    [localAlbumImagePicker setSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    [localAlbumImagePicker setAllowsEditing:YES];
    [self presentViewController:localAlbumImagePicker animated:YES completion:nil];
    
}

#pragma mark - UIImagePickerControllerDelegate选择图片代理方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage* image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    self.image = image;
    [self.myCommentDataViewController.imageArr addObject:image];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.myCommentDataViewController.collectionView reloadData];
}

#pragma mark - 点击相机按钮，选择照片或拍照
-(void)didSelectedCameraWithMyCommentThirdCollectionViewCell:(MyCommentThirdCollectionViewCell *)myCommentThirdCollectionViewCell
{
    /**
     *  代理方法在DataViewController里面实现
     */
    [self.myCommentDataViewController.actionSheet showInView:self.view];
    
}

#pragma mark - 取消第一响应者
-(void)receiveCancelKeyboard:(NSNotification*)object
{
    [self.view endEditing:YES];
}

#pragma mark - 点击删除照片按钮调用，清除数组中对应的照片
-(void)didClickDeleteImageButtonWithMyCommentThirdCollectionViewCell:(MyCommentThirdCollectionViewCell *)myCommentThirdCollectionViewCell withImage:(UIImage *)image
{
    if (self.myCommentDataViewController.imageArr.count>0)
    {
        [self.myCommentDataViewController.imageArr removeObject:image];
    }
    
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:kNotify_comment_StarScore object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:kNotify_comment_Content object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:kNotify_cancel_Keyboard object:nil];
}

@end
