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
 *  获取当前日期,返回YYYY-MM-dd格式的String
 */
- (NSString*)currentDate;
/**
 *  获取当前时间,返回HH-mm格式的String
 */
- (NSString*)currentTime;
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
 * 会员卡号: 123456
 */
- (NSString*)CardNo;
/**
 *   欢迎进入凯旋小区一号车库社区汽车服务站
 */
- (NSString*)welcomeStr;
/**
 *  登出时，清除plist里面所有的数据
 */
-(void)removeDataFromPlist;

#pragma mark - 保存一个日期值，用来过滤时间，与当前时间比较，用在预约洗车和维修列表展示
@property (nonatomic, strong) NSString* selectedDate;

#pragma mark - 维修保养/保存一个选中的预约时间，用来改变颜色
/**
 *  选中的时间
 */
@property (nonatomic, strong) NSString* selectedTime;
/**
 *  维修选中的日期保存
 */
@property (nonatomic, strong) NSString* selectedOrderDate;

#pragma mark - 手机号码验证
- (BOOL) isMobile:(NSString *)mobileNumbel;

#pragma mark -对请求参数进行拼接和加密
-(NSString*)generateMD5SignWithparameterDic:(NSMutableDictionary*)parameterDic;
/**
 *  返回一个初始化的字典，带着时间戳，用于网络请求
 */
@property (nonatomic, strong) NSMutableDictionary* parameterDic;
/**
 *  倒计时按钮
 */
@property (nonatomic, strong) UIButton* countDownButton;
@end
