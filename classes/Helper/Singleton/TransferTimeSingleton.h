//
//  TransferTimeSingleton.h
//  一号车库
//
//  Created by eric on 16/7/19.
//  Copyright © 2016年 eric. All rights reserved.
// 时间相关的单例类

#import <Foundation/Foundation.h>
#define AppTransferTimeSingleton [TransferTimeSingleton shareTransfer]

@interface TransferTimeSingleton : NSObject
+ (TransferTimeSingleton *)shareTransfer;

/**
 *  正在服务中的项目倒计时时间计算，通过传人项目结束时间和当前时间比较
 *
 *  @param timeString 项目结束时间
 *
 *  @return 倒计时的秒数
 */
- (NSInteger)transferTimeStringToIntervalWith:(NSString *)timeString;

/**
 *  将起始时间和结束时间的字符串传进来，转换为一个预计所需时间，用结束时间减去起始时间
 *
 *  @param timeString 18：00-19：00 时间段
 *
 *  @return 返回 1小时30分钟20秒
 */
- (NSString*)transferCountDownWithTimeString:(NSString *)timeString;
@end
