//
//  AppManager.h
//  一号车库
//
//  Created by eric on 16/7/14.
//  Copyright © 2016年 eric. All rights reserved.
//

#import <Foundation/Foundation.h>

#define AppManagerSingleton [AppManager sharedManager]
@interface AppManager : NSObject
/**
 *  app单例
 */
+(AppManager*)sharedManager;

/**
 *  用户唯一标示/登录后从服务器获取 
 */
- (NSString*)accessCode;

/**
 *  获取当前时间
 */
- (NSString*)currentDate;
@end
