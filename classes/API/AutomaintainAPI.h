//
//  AutomaintainAPI.h
//  一号车库
//
//  Created by eric on 16/7/11.
//  Copyright © 2016年 eric. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AutomaintainAPI : NSObject

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
@end
