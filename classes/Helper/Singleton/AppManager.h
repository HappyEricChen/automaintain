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
 *   登录的账号
 */
- (NSString*)userName;
/**
 *  用户唯一标示/登录后从服务器获取 
 */
- (NSString*)accessCode;

/**
 *  获取当前时间,返回YYYY-MM-dd格式的String
 */
- (NSString*)currentDate;
/**
 *   小区名称：凯旋花苑
 */
- (NSString*)SectionName;
/**
 *   用户头像url
 */
- (NSString*)AvatarUrl;
/**
 *  汽车品牌: 奥迪
 */
- (NSString*)CarBrand;
/**
 *  汽车型号: A6L
 */
- (NSString*)CarModel;
/**
 * 车牌号: 沪A888888
 */
- (NSString*)CarNo;

/**
 *   欢迎进入凯旋小区一号车库社区汽车服务站
 */
- (NSString*)welcomeStr;
/**
 *  登出时，清除plist里面所有的数据
 */
-(void)removeDataFromPlist;
@end
