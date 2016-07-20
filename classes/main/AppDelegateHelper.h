//
//  AppDelegateHelper.h
//  automaintain
//
//  Created by eric on 16/6/22.
//  Copyright © 2016年 eric. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class MaintenanceViewController;
/**
 *  单例对象宏定义
 */
#define SharedAppDelegateHelper [AppDelegateHelper sharedManager]

@interface AppDelegateHelper : NSObject
/**
 *  注册登入页面
 */
@property (nonatomic, strong) UIViewController* loginViewController;

@property (nonatomic, strong) UINavigationController* navigationController;
/**
 *  首页
 */
@property (nonatomic, strong) UIViewController* homeViewController;
/**
 *  维修保养
 */
@property (nonatomic, strong) MaintenanceViewController* maintenanceViewController;
+(AppDelegateHelper *)sharedManager;
@end
