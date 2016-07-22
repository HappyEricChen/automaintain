//
//  MyCommentDataViewController.h
//  automaintain
//
//  Created by eric on 16/7/1.
//  Copyright © 2016年 eric. All rights reserved.
//

#import <Foundation/Foundation.h>

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
@end
