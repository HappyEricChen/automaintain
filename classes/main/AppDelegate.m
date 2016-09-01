//
//  AppDelegate.m
//  automaintain
//
//  Created by eric on 16/6/22.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "AppDelegateHelper.h"
#import <Bugly/Bugly.h>

#define APPID @"900050415"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    /**
     *  设置弹出的HUD时间，单例
     */
    [SVProgressHUD setMinimumDismissTimeInterval:1];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setBackgroundColor:[UIColor colorWithPatternImage:ImageNamed(@"tip_bg")]];
    
    
#pragma mark - 初始化腾讯Bugly
    [Bugly startWithAppId:APPID];
    
#pragma mark - AccessCode过期后退出到登录界面
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(accessCodeOverdue) name:kNotify_AccessCode_Overdue object:nil];
    
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = SharedAppDelegateHelper.navigationController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

-(void)accessCodeOverdue
{
    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"登录已过期，请重新登录！" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* action = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                             {
                                 /**
                                  *  返回登录界面
                                  */
                                 [SharedAppDelegateHelper.navigationController popToViewController:SharedAppDelegateHelper.loginViewController animated:YES];
                             }];
    
    [alertController addAction:action];
    
    
    [self.window.rootViewController presentViewController:alertController animated:YES completion:nil];
    
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:kNotify_AccessCode_Overdue object:nil];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
