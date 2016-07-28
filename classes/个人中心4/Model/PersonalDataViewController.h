//
//  PersonalDataViewController.h
//  automaintain
//
//  Created by eric on 16/6/29.
//  Copyright © 2016年 eric. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class PersonalDataViewController,PersonalModel;
@protocol PersonalDataViewControllerDelegate <NSObject>

@optional
/**
 *  点击选择相机
 */
-(void)didClickShowCameraMethod:(PersonalDataViewController*)personalDataViewController;
/**
 *  点击选择本地相册
 */
-(void)didClickShowLocalAlbumMethod:(PersonalDataViewController *)personalDataViewController;

@end
@interface PersonalDataViewController : NSObject

@property (nonatomic, strong) CustomNavigationView* customNavigationView;

@property (nonatomic, strong) UICollectionView* collectionView;
/**
 *  个人信息模型
 */
@property (nonatomic, strong) PersonalModel* personalModel;

/**
 *  弹出的控制器选择相册和相机/ios8之后支持
 */
@property (nonatomic, strong) UIAlertController* alertController;
/**
 *  弹出的控制器选择相册和相机/ios7之前
 */
@property (nonatomic, strong) UIActionSheet* actionSheet;

@property (nonatomic, weak) id<PersonalDataViewControllerDelegate> delegate;

#pragma mark - 上传照片
/**
 *  上传照片/POST 请求
 *
 *  @param image         图片
 *  @param callback      回调
 */
-(void)postUploadPhotoFileWithImage:(UIImage*)image
                       withCallback:(Callback )callback;
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
                                 withCallback:(Callback )callback;
@end
