//
//  MyCommentDataViewController.h
//  automaintain
//
//  Created by eric on 16/7/1.
//  Copyright © 2016年 eric. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MyCommentDataViewController;
@protocol MyCommentDataViewControllerDelegate <NSObject>

@optional
/**
 *  点击选择相机
 */
-(void)didClickShowCameraMethod:(MyCommentDataViewController*)myCommentDataViewController;
/**
 *  点击选择本地相册
 */
-(void)didClickShowLocalAlbumMethod:(MyCommentDataViewController *)myCommentDataViewController;

@end

@interface MyCommentDataViewController : NSObject


@property (nonatomic, strong) CustomNavigationView* customNavigationView;

@property (nonatomic, strong) UICollectionView* collectionView;

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
                             withCallback:(Callback )callback;

#pragma mark - 上传评论照片
/**
 *  上传评论照片/POST 请求
 *
 *  @param Photo         图片文件
 *  @param callback            回调
 */
-(void)postUploadPhotoFileWithPhoto:(UIImage*)image
                       withCallback:(Callback )callback;

/**
 *   图片数组
 */
@property (nonatomic, strong) NSMutableArray* imageArr;


/**
 *  弹出的控制器选择相册和相机/ios8之后支持
 */
@property (nonatomic, strong) UIAlertController* alertController;
/**
 *  弹出的控制器选择相册和相机/ios7之前
 */
@property (nonatomic, strong) UIActionSheet* actionSheet;

@property (nonatomic, weak) id<MyCommentDataViewControllerDelegate> delegate;
#pragma mark -上传图片测试
- (void)runDispatchTestWithCallback:(Callback )callback;;
/**
 *  图片上传成功后，返回的guid数组
 */
@property (nonatomic, strong) NSMutableArray* imageGuidArr;
@end
