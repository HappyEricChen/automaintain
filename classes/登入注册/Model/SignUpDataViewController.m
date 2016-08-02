//
//  SignUpDataViewController.m
//  automaintain
//
//  Created by eric on 16/6/24.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "SignUpDataViewController.h"
#import "LoginModel.h"

@implementation SignUpDataViewController

-(instancetype)initWithType:(NSString *)type
{
    self = [super init];
    if (self)
    {
        _type = type;
    }
    return self;
}

-(CustomNavigationView *)customNavigationView
{
    if (!_customNavigationView)
    {
        if ([_type isEqualToString:@"立即注册"])
        {
            _customNavigationView = [CustomNavigationView customNavigationViewWithLeftBtnImage:ImageNamed(@"register_back") withRightBtnImage:nil withTitle:@"会员注册"];
        }
        else
        {
            _customNavigationView = [CustomNavigationView customNavigationViewWithLeftBtnImage:ImageNamed(@"register_back") withRightBtnImage:nil withTitle:@"找回密码"];
        }
        
    }
    return _customNavigationView;
}

-(SignUpView *)signUpView
{
    if (!_signUpView)
    {
        _signUpView = [[SignUpView alloc]initWithType:self.type];
    }
    return _signUpView;
}

#pragma mark - 注册网络请求
-(void)signupWithUsername:(NSString *)username withPassword:(NSString *)password withCallback:(Callback)callback
{
    [AutomaintainAPI signupWithUsername:username withPassword:password withCallback:^(BOOL success, NSError *error, id result)
     {
         if (success)
         {
             LoginModel* loginModel = (LoginModel*)result;
             /**
              *  存到plist里面
              */
             [[NSUserDefaults standardUserDefaults]setObject:loginModel.AccessCode forKey:@"accessCode"];
             [[NSUserDefaults standardUserDefaults]setObject:loginModel.AvatarUrl forKey:@"AvatarUrl"];
             [[NSUserDefaults standardUserDefaults]setObject:loginModel.CarBrand forKey:@"CarBrand"];
             [[NSUserDefaults standardUserDefaults]setObject:loginModel.CarModel forKey:@"CarModel"];
             [[NSUserDefaults standardUserDefaults]setObject:loginModel.CarNo forKey:@"CarNo"];
             [[NSUserDefaults standardUserDefaults]setObject:loginModel.CardNo forKey:@"CardNo"];
             [[NSUserDefaults standardUserDefaults]setObject:loginModel.Role forKey:@"Role"];
             [[NSUserDefaults standardUserDefaults]setObject:loginModel.SectionName forKey:@"SectionName"];
             [[NSUserDefaults standardUserDefaults]setObject:loginModel.ShopName forKey:@"ShopName"];
             [[NSUserDefaults standardUserDefaults]setObject:username forKey:@"userName"];
             [[NSUserDefaults standardUserDefaults]synchronize];
             
             callback(YES,nil,result);
         }
         else
         {
             callback(NO,nil,result);
         }
    }];
}

#pragma mark - 找回密码
-(void)changePasswordWithUsername:(NSString *)username withNewPassword:(NSString *)newPassword withCallback:(Callback)callback
{
    [AutomaintainAPI changePasswordWithUsername:username withNewPassword:newPassword withCallback:^(BOOL success, NSError *error, id result)
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

@end
