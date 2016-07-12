//
//  LoginDataViewController.h
//  automaintain
//
//  Created by eric on 16/6/23.
//  Copyright © 2016年 eric. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginView.h"
@interface LoginDataViewController : NSObject

/**
 *  用户登录网络请求
 */
-(void)loginWithUsername:(NSString*)username
         withpassword:(NSString*)password
            withCallback:(Callback)callback;

/**
 *  登录界面
 */
@property (nonatomic, strong) LoginView* loginView;
@end
