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

@interface MyCommentViewController ()<CustomNavigationViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,MyCommentDataViewControllerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,MyCommentThirdCollectionViewCellDelegate>

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
    BaseCollectionViewCell * cell = nil;
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
    else if (indexPath.section == 3)
    {
        MyCommentFourCollectionViewCell * fourCell = [MyCommentFourCollectionViewCell collectionView:collectionView dequeueReusableCellWithReuseIdentifier:MyCommentFourCollectionViewCellId forIndexPath:indexPath];
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
#pragma mark - UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 3)
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
        [SVProgressHUD showErrorWithStatus:@"评论不能为空"];
    }
    else
    {
        /**
         *  先上传图片
         */
        [self updateCommentPhotos];
    }
    
}

#pragma mark - 评论图片上传方法
-(void)updateCommentPhotos
{
    __weak MyCommentViewController* weakSelf = self;
    [self.myCommentDataViewController runDispatchTestWithCallback:^(BOOL success, NSError *error, id result)
     {
         if (success)
         {
             for (NSString* guidStr in self.myCommentDataViewController.imageGuidArr)
             {
                 if ([self.photoGuidList isEqualToString:@""])
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
             
         }
    }];
    
//    if (self.myCommentDataViewController.imageArr.count == 0)
//    {
//        return;
//    }
//    else
//    {
//        for (NSInteger i=0; i<self.imageArr.count; i++)
//        {
//            [self.myCommentDataViewController postUploadPhotoFileWithPhoto:self.imageArr[i] withCallback:^(BOOL success, NSError *error, id result)
//             {
//                 if (success)
//                 {
//                     NSString* photoStr = (NSString*)result;
//                     if ([self.photoGuidList isEqualToString:@""])
//                     {
//                         self.photoGuidList = [self.photoGuidList stringByAppendingString:photoStr];
//                     }
//                     else
//                     {
//                         self.photoGuidList = [NSString stringWithFormat:@"%@|%@",self.photoGuidList,photoStr];
//                     }
//                     
//                 }
//                 else
//                 {
//                     [SVProgressHUD showErrorWithStatus:result];
//                 }
//             }];
//            
//        }
//    }
//    
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
        [SVProgressHUD showErrorWithStatus:@"评论不能为空"];
    }
    else
    {
        
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
             }
             else
             {
                 [SVProgressHUD showErrorWithStatus:result];
             }
         }];
    }
}
#pragma mark - MyCommentDataViewControllerDelegate

-(void)didClickShowCameraMethod:(MyCommentViewController *)personalDataViewController
{
    UIImagePickerController* imagePicker = [[UIImagePickerController alloc]init];
    [imagePicker setDelegate:self];
    [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
    [imagePicker setAllowsEditing:YES];
    [self presentViewController:imagePicker animated:YES completion:nil];
}

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
    [self.myCommentDataViewController.actionSheet showInView:self.view];
}
#pragma mark - 点击对应的照片放大
-(void)didClickImageViewWithMyCommentSecondCollectionViewCell:(MyCommentSecondCollectionViewCell *)myCommentSecondCollectionViewCell withImage:(UIImage *)image
{
    ImageAmplificationViewController* imageAmplificationViewController = [[ImageAmplificationViewController alloc]init];
    imageAmplificationViewController.image = image;
    [self.navigationController pushViewController:imageAmplificationViewController animated:YES];
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
