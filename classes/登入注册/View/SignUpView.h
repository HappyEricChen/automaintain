//
//  SignUpView.h
//  automaintain
//
//  Created by eric on 16/6/24.
//  Copyright © 2016年 eric. All rights reserved.
//  会员注册／找回密码

#import <UIKit/UIKit.h>

@class SignUpView;

@protocol SignUpViewDelegate <NSObject>

@optional
/**
 *  点击立即注册按钮，传值
 */
-(void)signUpView:(SignUpView*)signUpView
     withUsername:(NSString*)username
     withPassword:(NSString*)password
withconfirmPassword:(NSString*)confirmPassword
withverificationCode:(NSString*)verificationCode;

/**
 *  点击获取验证码按钮调用, 注册页IsExisted=@"0"/找回密码IsExisted = @"1"
 */
-(void)didClickVerificationButtonWithSignUpView:(SignUpView*)signUpView
                                   withUsername:(NSString*)username
                                  withIsExisted:(NSString*)IsExisted
                                   withCallback:(Callback )callback;
@end
@interface SignUpView : UIView
/**
 *  传类型，会员注册或者找回密码
 */
-(instancetype)initWithType:(NSString*)type;

/**
 *  点击获取验证码按钮
 */
-(void)clickVerificationButtonwithIsExisted:(NSString*)IsExisted;

@property (nonatomic, weak) id <SignUpViewDelegate> delegate;
@end
