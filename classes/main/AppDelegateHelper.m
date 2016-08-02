//
//  AppDelegateHelper.m
//  automaintain
//
//  Created by eric on 16/6/22.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "AppDelegateHelper.h"
#import "LoginViewController.h"
#import "HomeViewController.h"
#import "MaintenanceViewController.h"

@implementation AppDelegateHelper

+(AppDelegateHelper *)sharedManager
{
    static AppDelegateHelper * sharedAppDelegateHelperInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedAppDelegateHelperInstance = [[self alloc]init];
    });
    return sharedAppDelegateHelperInstance;
}
-(UIViewController *)loginViewController
{
    if (!_loginViewController)
    {
        _loginViewController = [[LoginViewController alloc]init];
    }
    return _loginViewController;
}

-(UINavigationController *)navigationController
{
    if (!_navigationController)
    {
        _navigationController = [[UINavigationController alloc]initWithRootViewController:self.loginViewController];
        
    }
    return _navigationController;
}

-(UIViewController *)homeViewController
{
    if (!_homeViewController)
    {
        _homeViewController = [[HomeViewController alloc]init];
    }
    return _homeViewController;
}
-(MaintenanceViewController *)maintenanceViewController
{
    if (!_maintenanceViewController)
    {
        _maintenanceViewController = [[MaintenanceViewController alloc]init];
    }
    return _maintenanceViewController;
}
@end
