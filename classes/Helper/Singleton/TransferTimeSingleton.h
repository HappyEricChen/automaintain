//
//  TransferTimeSingleton.h
//  一号车库
//
//  Created by eric on 16/7/19.
//  Copyright © 2016年 eric. All rights reserved.
// 时间相关的单例类

#import <Foundation/Foundation.h>

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
@end
