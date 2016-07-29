//
//  LoginView.h
//  automaintain
//
//  Created by eric on 16/6/23.
//  Copyright © 2016年 eric. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LoginView;
@protocol LoginViewDelegate <NSObject>

@optional
/**
 *  注册
 */
-(void)didSelectedSiginUpButton;
/**
 *  忘记密码
 */
-(void)didSelectedForgetPasswordButton;
/**
 *  登录页，点击登录按钮调用
 */
-(void)didSelectedLoginButtonWithLoginView:(LoginView*)loginView withUsername:(NSString*)username withPassword:(NSString*)password;

@end
@interface LoginView : UIView

@property (nonatomic, weak) id <LoginViewDelegate> delegate;
/**
 *  登录成功后清除账号密码
 */
-(void)clearTextField;
@end
