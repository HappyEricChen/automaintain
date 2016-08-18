//
//  AutomaintainAPI.h
//  一号车库
//
//  Created by eric on 16/7/11.
//  Copyright © 2016年 eric. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AutomaintainAPI : NSObject

//extern const NSString* urlPath;

#pragma mark - 注册/登录/找回密码
/**
 *  获取短信验证码/ post请求
 */
+(void)SMSVerificationCodeWithPhoneNum:(NSString*)phoneNum
                         withIsExisted:(NSString*)IsExisted
                          withCallback:(Callback )callback;


/**
 用户注册/POST 请求
 */
+(void)signupWithUsername:(NSString*)username
             withPassword:(NSString*)password
             withCallback:(Callback )callback;

/**
 找回密码/POST 请求
 */
+(void)changePasswordWithUsername:(NSString*)username
                  withNewPassword:(NSString*)newPassword
                     withCallback:(Callback )callback;

/**
 用户登录/POST 请求
 */
+(void)loginWithUsername:(NSString*)username
         withpassword:(NSString*)password
            withCallback:(Callback )callback;
/**
 会员登出/POST 请求
 */
+(void)logoutWithAccessCode:(NSString*)accessCode
               withCallback:(Callback )callback;

#pragma mark - 首页

/**
 首页轮播广告图/POST 请求
 */
+(void)postListofAdsCarouselWithAccessCode:(NSString*)accessCode
                              withCallback:(Callback )callback;

/**
 便民服务列表/POST 请求
 */
+(void)postListofConvenienceServiceWithAccessCode:(NSString*)accessCode
                                     withCallback:(Callback )callback;

/**
 首页最下面的广告图/POST 请求
 */
+(void)postListofBottomAdsWithAccessCode:(NSString*)accessCode
                            withCallback:(Callback )callback;

#pragma mark - 预约洗车/获取指定日期的时间表
/**
 *   预约洗车/获取车位指定日期的预订表/POST 请求
 *
 *  @param accessCode   唯一标识
 *  @param currentDate 当前日期
 *  @param subjectGuid 预约类型/洗车或者维修编号
 *  @param callback    回调
 */
+(void)postListofWashCarPlaceListWithAccessCode:(NSString*)accessCode
                                withCurrentDate:(NSString*)currentDate
                                withSubjectGuid:(NSString*)subjectGuid
                                   withCallback:(Callback )callback;
#pragma mark - 提交预约
/**
 *  提交预约/POST 请求
 *
 *  @param accessCode           唯一标识
 *  @param appointmentStartTime 预约开始时间
 *  @param subjectGuid          预约类型/洗车或者维修编号
 *  @param note                 预约留言内容
 *  @param callback             回调
 */
+(void)postAppointmentServiceWithAccessCode:(NSString*)accessCode
                   withAppointmentStartTime:(NSString*)appointmentStartTime
                            withSubjectGuid:(NSString*)subjectGuid
                                   withNote:(NSString*)note
                               withCallback:(Callback )callback;

#pragma mark - 获取评论列表
/**
 *   获取预约的评论列表/POST 请求
 *
 *  @param accessCode   唯一标识
 *  @param pageIndex   页数
 *  @param callback    回调
 */
+(void)postCommentListWithAccessCode:(NSString*)accessCode
                       withPageIndex:(NSString*)pageIndex
                        withCallback:(Callback )callback;

#pragma mark - 预约维修
/**
 *   预约类型/POST 请求
 *
 *  @param accessCode   唯一标识符
 *  @param callback    回调
 */
+(void)postOrderTypeListWithAccessCode:(NSString*)accessCode
                          withCallback:(Callback )callback;
#pragma mark - 获取我的预约列表
/**
 *  我的预约列表/POST 请求
 *
 *  @param accessCode 唯一标识符
 *  @param pageIndex  当前请求页数
 *  @param callback    回调
 */
+(void)postMyOrderListWithAccessCode:(NSString*)accessCode
                       withPageIndex:(NSString*)pageIndex
                        withCallback:(Callback )callback;
#pragma mark - 取消预约
/**
 *  取消预约/POST 请求
 *
 *  @param accessCode 唯一标识符
 *  @param appointmentGuid  预约时间段的唯一id
 *  @param callback    回调
 */
+(void)postCancelOrderWithAccessCode:(NSString*)accessCode
                 withAppointmentGuid:(NSString*)appointmentGuid
                        withCallback:(Callback )callback;
#pragma mark - 意见反馈
/**
 *  意见反馈/POST 请求
 *
 *  @param accessCode     唯一标识符
 *  @param type           反馈的类型
 *  @param commentContent 反馈的内容
 *  @param callback       回调
 */
+(void)postFeedbackWithAccessCode:(NSString*)accessCode
                            withType:(NSString*)type
                  withCommentContent:(NSString*)commentContent
                        withCallback:(Callback )callback;

#pragma mark - 获取在线留言列表
/**
 *  获取在线留言列表/POST 请求
 *
 *  @param accessCode 唯一标识符
 *  @param pageIndex  当前请求页数
 *  @param callback    回调
 */
+(void)postOnlineMessageListWithAccessCode:(NSString*)accessCode
                             withPageIndex:(NSString*)pageIndex
                              withCallback:(Callback )callback;

#pragma mark - 提交我的留言
/**
 *   提交我的留言/POST 请求
 *
 *  @param accessCode 唯一标识符
 *  @param commentContent  在线留言内容
 *  @param callback    回调
 */
+(void)postMessageToServiceWithAccessCode:(NSString*)accessCode
                       withCommentContent:(NSString*)commentContent
                             withCallback:(Callback )callback;

#pragma mark - 提交我的评论
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
+(void)postCommentToServiceWithAccessCode:(NSString*)accessCode
                                withStars:(NSString*)stars
                          withContentText:(NSString*)ContentText
                  withMaintainSubjectGuid:(NSString*)maintainSubjectGuid
                      withAppointmentGuid:(NSString*)appointmentGuid
                        withPhotoGuidList:(NSString*)photoGuidList
                             withCallback:(Callback )callback;
#pragma mark - 上传照片
/**
 *  上传照片/POST 请求
 *
 *  @param binaryPhoto         图片的二进制文件
 *  @param callback            回调
 */
+(void)postUploadPhotoFileWithBinaryPhoto:(UIImage*)binaryPhoto
                             withCallback:(Callback )callback;

#pragma mark - 修改密码/POST 请求
/**
 *
 *  修改密码/POST请求
 *
 *  @param accessCode  唯一标识符
 *  @param OldPassword 旧密码
 *  @param NewPassword 新密码
 *  @param callback    回调
 */
+(void)postChangePasswordWithAccessCode:(NSString*)accessCode
                        withOldPassword:(NSString*)OldPassword
                        withNewPassword:(NSString*)NewPassword
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
+(void)postUpdateCustomerAvatarWithAccessCode:(NSString*)accessCode
                                withPhotoGuid:(NSString*)photoGuid
                                 withCallback:(Callback )callback;


#pragma mark - 上传多张评论照片****和其他的请求方式不同
/**
 *  上传多张评论照片/post请求
 *
 *  @param image           上传的图片
 *  @param completionBlock 回调
 *
 */
+ (NSURLSessionUploadTask*)uploadTaskWithImage:(UIImage*)image
                                    completion:(void (^)(NSURLResponse *response, id responseObject, NSError *error))completionBlock;
@end
