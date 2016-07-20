//
//  WashCarDateListModel.h
//  一号车库
//
//  Created by eric on 16/7/14.
//  Copyright © 2016年 eric. All rights reserved.
// 预约洗车/维修模型

#import <Foundation/Foundation.h>


@interface WashCarDateListModel : NSObject
/**
 *  同一个时间最多能接受的预约次数
 */
@property (nonatomic, strong) NSString* MaxPlaceNum;

/**
 *  每个时间段的模型数组
 */
@property (nonatomic, strong) NSMutableArray* Schedule;


@end
