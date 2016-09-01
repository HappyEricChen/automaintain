//
//  LoginDataViewController.m
//  automaintain
//
//  Created by eric on 16/6/23.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "LoginDataViewController.h"
#import "LoginModel.h"

@implementation LoginDataViewController


-(LoginView *)loginView
{
    if (!_loginView)
    {
        _loginView = [[LoginView alloc]init];
        
    }
    return _loginView;
}

-(void)loginWithUsername:(NSString *)username withpassword:(NSString *)password withCallback:(Callback)callback
{
    [AutomaintainAPI loginWithUsername:username withpassword:password withCallback:^(BOOL success, NSError *error, id result)
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
@end
