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
 *  预约洗车选中的当前日期 2017-02-03
 */
extern NSString* const kNotify_selected_date;
/**
 *  提交预约选中的起始时间 08:15:00
 */
extern NSString* const kNotify_myOrder_StartTime;
/**
 *  预约维修/选中的日期+起始时间 2017-02-03 08:15-08:30
 */
extern NSString* const kNotify_myOrder_CompletedTime;
/**
 *  意见反馈，编辑的内容传送到控制器
 */
extern NSString* const kNotify_feedback_Content;
@end
