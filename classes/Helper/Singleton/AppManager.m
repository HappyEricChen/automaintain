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

#pragma mark - 手机号码验证
/**
 *  手机号码验证
 *
 *  @param mobileNumbel 传入的手机号码
 *
 *  @return 格式正确返回true  错误 返回fals
 */
- (BOOL) isMobile:(NSString *)mobileNumbel
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189,181(增加)
     */
    NSString * MOBIL = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[2378])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189,181(增加),17(0-9)号码
     22         */
    NSString * CT = @"^1((33|53|8[019]|7[0-9])[0-9]|349)\\d{7}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBIL];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNumbel]
         || [regextestcm evaluateWithObject:mobileNumbel]
         || [regextestct evaluateWithObject:mobileNumbel]
         || [regextestcu evaluateWithObject:mobileNumbel]))
    {
        return YES;
    }
    
    return NO;
}
@end
