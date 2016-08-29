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

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    /**
     *  //设置弹出的HUD时间，单例
     */
    [SVProgressHUD setMinimumDismissTimeInterval:1];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setBackgroundColor:[UIColor colorWithPatternImage:ImageNamed(@"tip_bg")]];
    
    
#pragma mark - SDWebImage内存性能优化
//    YYImageCache* cache = [YYImageCache sharedCache];
//    cache.allowAnimatedImage = NO;
//    cache.decodeForDisplay = NO;
//    // 清除已过期图片
//    [[SDImageCache sharedImageCache] cleanDisk];
//    // 设置最多缓存7天时间
//    [[SDImageCache sharedImageCache] setMaxCacheAge:7 * 24 * 60 * 60];
//    // 设置磁盘最多缓存20M
//    [[SDImageCache sharedImageCache] setMaxCacheSize:20 * 1024 * 1024];
    // 内存最多缓存10张100x100像素的图片（可根据情况自己调整）
//    [[SDImageCache sharedImageCache] setMaxMemoryCost:5 * 100 * 100];
//    [[SDImageCache sharedImageCache] setShouldDecompressImages:NO];
//    [[SDWebImageDownloader sharedDownloader] setShouldDecompressImages:NO];
//    [[SDImageCache sharedImageCache] setShouldCacheImagesInMemory:NO];
    
    
    
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = SharedAppDelegateHelper.navigationController;
    [self.window makeKeyAndVisible];
    
    return YES;
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
