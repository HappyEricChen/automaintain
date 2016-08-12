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
    if(!timeString||timeString.length==0)
    {
        return 0;
    }
    /**
     *  取到起始时间和结束时间
     */
    NSString* startTimeStr = [timeString substringToIndex:5];
    NSString* endTimeStr = [timeString substringFromIndex:6];
    /**
     转化为完整的时间字符串 @"yyyy-MM-dd HH:mm:ss"
     */
    NSString* completedStartTime = [NSString stringWithFormat:@"2016-08-12 %@:00",startTimeStr];
    NSString* completedEndTime = [NSString stringWithFormat:@"2016-08-12 %@:00",endTimeStr];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *tZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:tZone];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //将字符串转换为时间
    NSDate *startDate = [formatter dateFromString:completedStartTime];
    NSDate *endDate = [formatter dateFromString:completedEndTime];
    /**
     *  取到时间差，单位是秒
     */
    NSTimeInterval countDown = [endDate timeIntervalSinceDate:startDate];
    NSInteger countDownTime = round(countDown);
    /**
     *   将时间差转化为标准格式
     */
    NSInteger hours = countDownTime/3600;
    NSInteger minutes = (countDownTime-hours*3600)/60;
    
    NSString *countDownStr;
    if (hours>0 && minutes>0)
    {
        countDownStr = [NSString stringWithFormat:@"%ld小时%ld分钟",hours,minutes];
    }
    else if (hours>0)
    {
        countDownStr = [NSString stringWithFormat:@"%ld小时",hours];
    }
    else if (minutes>0)
    {
        countDownStr = [NSString stringWithFormat:@"%ld分钟",minutes];
    }
    
    
    if (countDownTime>0)
    {
        return countDownStr;
    }
    else
    {
        return @"";
    }
    
}
@end
