//
//  TransferTimeSingleton.m
//  一号车库
//
//  Created by eric on 16/7/19.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "TransferTimeSingleton.h"

@implementation TransferTimeSingleton

+(TransferTimeSingleton *)shareTransfer
{
    static TransferTimeSingleton *transfer = nil;
    static dispatch_once_t once;
    dispatch_once(&once,^{
        transfer = [[self alloc] init];
    });
    return transfer;
}

- (NSInteger)transferTimeStringToIntervalWith:(NSString *)timeString
{
    if(!timeString||timeString.length==0){
        return 0;
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *tZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:tZone];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //字符串转换为时间
    NSDate *postDate = [formatter dateFromString:timeString];
    NSDate *currentDate = [NSDate date];
    NSTimeInterval countDown = [postDate timeIntervalSinceDate:currentDate];
    NSInteger countDownTime = round(countDown);
    
    if (countDownTime>0)
    {
        return countDownTime;
    }
    else
    {
        return 1;
    }
}
#pragma mark - 转换时间为一个倒计时 eg: 8:30-9:00 -》30分钟
- (NSString*)transferCountDownWithTimeString:(NSString *)timeString
{
    return @"";
}
@end
