//
//  AppManager.m
//  一号车库
//
//  Created by eric on 16/7/14.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "AppManager.h"

@implementation AppManager

+(AppManager *)sharedManager
{
    static AppManager * sharedInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}
-(NSString *)userName
{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"userName"];
}
-(NSString *)accessCode
{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"accessCode"];
}

-(NSString *)SectionName
{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"SectionName"];
}
-(NSString *)AvatarUrl
{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"AvatarUrl"];
}
-(NSString *)CarBrand
{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"CarBrand"];
}
-(NSString *)CarModel
{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"CarModel"];
}
-(NSString *)CarNo
{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"CarNo"];
}
-(NSString *)CardNo
{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"CardNo"];
}

-(NSString *)currentDate
{
    NSDate * currentDate = [NSDate date];
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString* dateString = [dateFormatter stringFromDate:currentDate];
    
    return dateString;
}

-(NSString *)currentTime
{
    NSDate* date = [NSDate date];
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    NSString* dateStr = [dateFormatter stringFromDate:date];
    
    return dateStr;
}

#pragma mark - 欢迎进入凯旋小区一号车库社区汽车服务站
-(NSString *)welcomeStr
{
    /**
     *  去掉首尾空格方法
     */
    NSString* tempStr = [AppManagerSingleton.SectionName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString* welcomeStr;
    if (tempStr && ![tempStr isEqualToString:@""])
    {
        welcomeStr = [NSString stringWithFormat:@"欢迎进入%@一号车库社区汽车服务站",tempStr];
    }
    else
    {
        welcomeStr = @"欢迎进入一号车库社区汽车服务站";
    }
    return welcomeStr;
}

#pragma mark -  登出时，清除plist里面所有的数据
-(void)removeDataFromPlist
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"accessCode"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"AvatarUrl"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"CarBrand"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"CarModel"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"CarNo"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"CardNo"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Role"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SectionName"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ShopName"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userName"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"commentTotalCount"];//评论列表总数
    [[NSUserDefaults standardUserDefaults]synchronize];
}
@end
