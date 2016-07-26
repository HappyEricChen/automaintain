//
//  MyCommentDataViewController.m
//  automaintain
//
//  Created by eric on 16/7/1.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "MyCommentDataViewController.h"
#import "MyCommentFirstCollectionViewCell.h"
#import "MyCommentSecondCollectionViewCell.h"
#import "MyCommentThirdCollectionViewCell.h"
#import "MyCommentFourCollectionViewCell.h"

@implementation MyCommentDataViewController

-(CustomNavigationView *)customNavigationView
{
    if (!_customNavigationView)
    {
        _customNavigationView = [CustomNavigationView customNavigationViewWithLeftBtnImage:ImageNamed(@"register_back") withRightBtnImage:nil withTitle:@"发布评论"];
    }
    return _customNavigationView;
}

-(UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor clearColor];
        
        [_collectionView registerClass:[MyCommentFirstCollectionViewCell class] forCellWithReuseIdentifier:MyCommentFirstCollectionViewCellId];
        [_collectionView registerClass:[MyCommentSecondCollectionViewCell class] forCellWithReuseIdentifier:MyCommentSecondCollectionViewCellId];
        [_collectionView registerClass:[MyCommentThirdCollectionViewCell class] forCellWithReuseIdentifier:MyCommentThirdCollectionViewCellId];
        [_collectionView registerClass:[MyCommentFourCollectionViewCell class] forCellWithReuseIdentifier:MyCommentFourCollectionViewCellId];
        
    }
    return _collectionView;
}

/**
 *  提交我的评论/POST 请求
 *
 *  @param accessCode          唯一标识符
 *  @param stars               评论星数
 *  @param ContentText         评论内容
 *  @param maintainSubjectGuid 预约项目guid
 *  @param appointmentGuid     该条预约guid
 *  @param photoGuidList       图片guid数组
 *  @param callback            回调
 */
-(void)postCommentToServiceWithAccessCode:(NSString*)accessCode
                                withStars:(NSString*)stars
                          withContentText:(NSString*)ContentText
                  withMaintainSubjectGuid:(NSString*)maintainSubjectGuid
                      withAppointmentGuid:(NSString*)appointmentGuid
                        withPhotoGuidList:(NSArray*)photoGuidList
                             withCallback:(Callback )callback
{
    [AutomaintainAPI postCommentToServiceWithAccessCode:accessCode
                                              withStars:stars
                                        withContentText:ContentText
                                withMaintainSubjectGuid:maintainSubjectGuid
                                    withAppointmentGuid:appointmentGuid
                                      withPhotoGuidList:photoGuidList
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

-(UIAlertController *)alertController
{
    __weak MyCommentDataViewController* weakSelf = self;
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

@end
