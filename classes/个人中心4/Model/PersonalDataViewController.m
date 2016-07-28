//
//  PersonalDataViewController.m
//  automaintain
//
//  Created by eric on 16/6/29.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "PersonalDataViewController.h"
#import "PersonalFirstCollectionViewCell.h"
#import "PersonalSecondCollectionViewCell.h"
#import "PersonalThirdCollectionViewCell.h"
#import "PersonalFourCollectionViewCell.h"
#import "PersonalModel.h"

@interface PersonalDataViewController()<UIActionSheetDelegate>

@end
@implementation PersonalDataViewController

-(CustomNavigationView *)customNavigationView
{
    if (!_customNavigationView)
    {
        _customNavigationView = [CustomNavigationView customNavigationViewWithLeftBtnImage:ImageNamed(@"register_back")  withRightBtnImage:ImageNamed(@"register_setting") withTitle:@"个人中心"];
    }
    return _customNavigationView;
}

-(UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.minimumLineSpacing = ScreenHeight*0.024;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = UIColorFromRGB(0xf4f4f4);
        
        [_collectionView registerClass:[PersonalFirstCollectionViewCell class] forCellWithReuseIdentifier:personalFirstId];
        [_collectionView registerClass:[PersonalSecondCollectionViewCell class] forCellWithReuseIdentifier:personalSecondId];
        [_collectionView registerClass:[PersonalThirdCollectionViewCell class] forCellWithReuseIdentifier:personalThirdId];
        [_collectionView registerClass:[PersonalFourCollectionViewCell class] forCellWithReuseIdentifier:personalFourId];      
        
    }
    return _collectionView;
}

//-(PersonalModel *)personalModel
//{
//    if (!_personalModel)
//    {
//        _personalModel = [[PersonalModel alloc]init];
//        _personalModel.headImage = ImageNamed(@"personal_img");
//    }
//    return _personalModel;
//}

-(UIAlertController *)alertController
{
    __weak PersonalDataViewController* weakSelf = self;
    if (!_alertController)
    {
        _alertController = [UIAlertController alertControllerWithTitle:nil
                                                               message:nil
                                                        preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"cancel"
                                                               style:UIAlertActionStyleCancel
                                                             handler:nil];
        UIAlertAction* cameraAction = [UIAlertAction actionWithTitle:@"cameral"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * _Nonnull action) {
                                                                 if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
                                                                 {
                                                                     [weakSelf performSelector:@selector(showcamera) withObject:weakSelf afterDelay:.3f];
                                                                 }
                                                                 else
                                                                 {
                                                                     NSLog(@"这设备没相机");
                                                                 }
                                                             }];
        UIAlertAction* localAlbumAction = [UIAlertAction actionWithTitle:@"Local Album"
                                                                   style:UIAlertActionStyleDefault
                                                                 handler:^(UIAlertAction * _Nonnull action)
                                           {
                                               [weakSelf performSelector:@selector(showLocalAlbum)];
                                           }];
        [_alertController addAction:cameraAction];
        [_alertController addAction:localAlbumAction];
        [_alertController addAction:cancelAction];
        
    }
    return _alertController;
}

-(UIActionSheet *)actionSheet
{
    if (!_actionSheet)
    {
        _actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相机",@"本地相册", nil];
        _actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    }
    return _actionSheet;
}
#pragma mark - UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            {
                [self performSelector:@selector(showcamera) withObject:nil afterDelay:.3];
            }
            else
            {
                NSLog(@"这设备没相机");
            }
            break;
        case 1:
            [self performSelector:@selector(showLocalAlbum)];
            break;
            
        default:
            break;
    }
}

-(void)showcamera
{
    if ([self.delegate respondsToSelector:@selector(didClickShowCameraMethod:)])
    {
        [self.delegate didClickShowCameraMethod:self];
    }
}

-(void)showLocalAlbum
{
    if ([self.delegate respondsToSelector:@selector(didClickShowLocalAlbumMethod:)])
    {
        [self.delegate didClickShowLocalAlbumMethod:self];
    }
}
#pragma mark - 上传照片
/**
 *  上传照片/POST 请求
 *
 *  @param image         图片
 *  @param callback      回调
 */
-(void)postUploadPhotoFileWithImage:(UIImage*)image
                       withCallback:(Callback )callback;
{
    [AutomaintainAPI postUploadPhotoFileWithBinaryPhoto:image
                                           withCallback:^(BOOL success, NSError *error, id result)
     {
         if (success)
         {
             callback(YES,nil,result);
         }
         else
         {
             callback(NO,nil,result);
         }
     }];
}

#pragma mark - 更新会员头像/POST 请求
/**
 *
 *  更新会员头像/POST请求
 *
 *  @param accessCode  唯一标识符
 *  @param photoGuid 照片返回的guid
 *  @param callback    回调
 */
-(void)postUpdateCustomerAvatarWithAccessCode:(NSString*)accessCode
                                withPhotoGuid:(NSString*)photoGuid
                                 withCallback:(Callback )callback
{
    [AutomaintainAPI postUpdateCustomerAvatarWithAccessCode:accessCode
                                              withPhotoGuid:photoGuid
                                               withCallback:^(BOOL success, NSError *error, id result)
     {
         if (success)
         {
             callback(YES,nil,result);
         }
         else
         {
             callback(NO,nil,result);
         }
     }];
}
@end
