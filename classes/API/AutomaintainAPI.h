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

#pragma mark - 预约洗车
/**
 *   预约洗车/获取车位指定日期的预订表/POST 请求
 *
 *  @param accessCode   唯一标示
 *  @param currentDate 当前日期
 *  @param subjectGuid 预约类型/洗车或者维修编号
 *  @param callback    回调
 */
+(void)postListofWashCarPlaceListWithAccessCode:(NSString*)accessCode
                                withCurrentDate:(NSString*)currentDate
                                withSubjectGuid:(NSString*)subjectGuid
                                   withCallback:(Callback )callback;
/**
 *   提交预约/POST 请求
 *
 *  @param accessCode   唯一标示
 *  @param appointmentStartTime 预约开始时间
 *  @param subjectGuid 预约类型/洗车或者维修编号
 *  @param callback    回调
 */
+(void)postAppointmentServiceWithAccessCode:(NSString*)accessCode
                   withAppointmentStartTime:(NSString*)appointmentStartTime
                            withSubjectGuid:(NSString*)subjectGuid
                               withCallback:(Callback )callback;

/**
 *   获取预约的评论列表/POST 请求
 *
 *  @param accessCode   唯一标示
 *  @param appointmentGuid 预约类型/洗车或者维修编号
 *  @param callback    回调
 */
+(void)postCommentListWithAccessCode:(NSString*)accessCode
                 withMaintianSubjectGuid:(NSString*)maintianSubjectGuid
                        withCallback:(Callback )callback;

@end
