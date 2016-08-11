//
//  SignUpDataViewController.h
//  automaintain
//
//  Created by eric on 16/6/24.
//  Copyright © 2016年 eric. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomNavigationView.h"
#import "SignUpView.h"

@interface SignUpDataViewController : NSObject

@property (nonatomic, strong) CustomNavigationView* customNavigationView;

@property (nonatomic, strong) SignUpView* signUpView;
/**
 *  “注册” 或者 “找回密码”
 */
@property (nonatomic, strong) NSString* type;

-(instancetype)initWithType:(NSString*)type;

/**
 * 立即注册网络请求
 */
-(void)signupWithUsername:(NSString*)username
             withPassword:(NSString*)password
        withCallback:(Callback)callback;

/**
 *  找回密码网络请求
 */
-(void)changePasswordWithUsername:(NSString*)username
             withNewPassword:(NSString*)newPassword
             withCallback:(Callback)callback;

/**
 *  用户名
 */
@property (nonatomic, strong) NSString* username;
/**
 *  密码
 */
@property (nonatomic, strong) NSString* password;
@end
