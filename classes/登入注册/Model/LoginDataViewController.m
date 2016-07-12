//
//  LoginDataViewController.m
//  automaintain
//
//  Created by eric on 16/6/23.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "LoginDataViewController.h"

@implementation LoginDataViewController


-(LoginView *)loginView
{
    if (!_loginView)
    {
        _loginView = [[LoginView alloc]init];
        _loginView.translatesAutoresizingMaskIntoConstraints = NO;
        
    }
    return _loginView;
}

-(void)loginWithUsername:(NSString *)username withpassword:(NSString *)password withCallback:(Callback)callback
{
    [AutomaintainAPI loginWithUsername:username withpassword:password withCallback:^(BOOL success, NSError *error, id result)
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
