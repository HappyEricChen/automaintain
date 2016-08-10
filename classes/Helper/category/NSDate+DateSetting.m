//
//  NSDate+DateSetting.m
//  一号车库
//
//  Created by eric on 16/8/1.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "NSDate+DateSetting.h"
#import <UIKit/UIKit.h>

NSString * const ZZDateSettingChangedNotification = @"ZZDateSettingChangedNotification";

@interface ZZDateSetting : NSObject
@property (nonatomic,getter= isSetted24Hour) BOOL setted24Hour;
@end

@implementation NSDate (DateSetting)

static ZZDateSetting  *s_DateSetting;
+ (BOOL)isDaySetting24Hours{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_DateSetting = [[ZZDateSetting alloc] init];
    });
    return s_DateSetting.isSetted24Hour;
}

//计算稍微耗时间，用JWDateSetting，减少次方法调用
+ (BOOL)checkDateSetting24Hours{
    BOOL is24Hours = YES;
    NSString *dateStr = [[NSDate date] descriptionWithLocale:[NSLocale currentLocale]];
    NSArray  *sysbols = @[[[NSCalendar currentCalendar] AMSymbol],[[NSCalendar currentCalendar] PMSymbol]];
    for (NSString *symbol in sysbols) {
        if ([dateStr rangeOfString:symbol].location != NSNotFound) {//find
            is24Hours = NO;
            break;
        }
    }
    return is24Hours;
}
@end

@implementation ZZDateSetting{
    BOOL _enterFromBackGround;
}


-(instancetype)init{
    if (self = [super init]) {
        self.setted24Hour = [NSDate checkDateSetting24Hours];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillEnterForeground:) name:UIApplicationWillEnterForegroundNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
    }
    return self;
}

- (BOOL)isDaySettingChanged{
    BOOL is24HoursNew = [NSDate checkDateSetting24Hours];
    if (is24HoursNew != self.setted24Hour) {//时间设置发生改变
        self.setted24Hour = is24HoursNew;
        return YES;
    }
    return NO;
}

- (void)appDidBecomeActive:(NSNotification *)notification{
    if (_enterFromBackGround) {
        if ([self isDaySettingChanged]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:ZZDateSettingChangedNotification object:nil];
        }
    }
    _enterFromBackGround = NO;
}
//如果在appWillEnterForeground 之后取 nsdate 的descriptionWithLocale：有时候返回的字符串不能区分是 12小时制 还是24小时制。在appDidBecomeActive 里面取descriptionWithLocale：字符串 能区分 是12小时制还是24小时制
- (void)appWillEnterForeground:(NSNotification *)notification{
    _enterFromBackGround = YES;
    //        if ([self isDaySettingChanged]) {
    //            [[NSNotificationCenter defaultCenter] postNotificationName:JWDateSettingChangedNotification object:nil];
    //        }
    
}
@end
