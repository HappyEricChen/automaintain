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
@end

@implementation MyCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myCommentDataViewController = [[MyCommentDataViewController alloc]init];
    self.myCommentDataViewController.delegate = self;
    [self configureNavigationView];
    [self configureCollectionView];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveStarScore:) name:kNotify_comment_StarScore object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(receiveCommentContent:) name:kNotify_comment_Content object:nil];
    
    self.starScore = @"5";//初始化星星为5
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
        if (!self.commentContent || [self.commentContent isEqualToString:@""])
        {
            [SVProgressHUD showErrorWithStatus:@"评论的内容不能为空"];
        }
        else
        {
            
            [self.myCommentDataViewController postCommentToServiceWithAccessCode:AppManagerSingleton.accessCode
                                                                       withStars:self.starScore
                                                                 withContentText:self.commentContent
                                                         withMaintainSubjectGuid:SubjectGuidWashCar
                                                             withAppointmentGuid:self.myOrderModel.AppointmentGuid
                                                               withPhotoGuidList:@[]
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
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.myCommentDataViewController.collectionView reloadData];
}

#pragma mark - MyCommentThirdCollectionViewCellDelegate 点击选择照片按钮
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
@end
