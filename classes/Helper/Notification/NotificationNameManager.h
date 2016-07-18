//
//  NotificationNameManager.h
//  一号车库
//
//  Created by eric on 16/7/18.
//  Copyright © 2016年 eric. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NotificationNameManager : NSObject
/**
 *  预约洗车选中的当前日期
 */
extern NSString* const kNotify_selected_date;
/**
 *  提交预约选中的起始时间
 */
extern NSString* const kNotify_myOrder_StartTime;

@end
