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
/**
 *  评论星星数量，界面改动传送到控制器
 */
extern NSString* const kNotify_comment_StarScore;
/**
 *  发布评论，评论的内容传送到控制器
 */
extern NSString* const kNotify_comment_Content;
/**
 *  发布评论，点击空白处取消第一响应者，键盘回收
 */
extern NSString* const kNotify_cancel_Keyboard;
/**
 *  点击单例的验证码按钮，发送通知到注册页面
 */
extern NSString* const kNotify_verification_Button;

/**
 *  我的预约服务中的倒计时/
 */
extern NSString* const kNotify_CountDown_Time;
@end
