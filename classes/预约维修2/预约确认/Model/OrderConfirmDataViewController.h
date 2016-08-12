//
//  OrderConfirmDataViewController.h
//  一号车库
//
//  Created by eric on 16/8/11.
//  Copyright © 2016年 eric. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OrderConfirmView;
@interface OrderConfirmDataViewController : NSObject

@property (nonatomic, strong) OrderConfirmView* orderConfirmView;

@property (nonatomic, strong) CustomNavigationView* customNavigationView;


/**
 *  提交预约/POST 请求
 *
 *  @param accessCode           唯一标识
 *  @param appointmentStartTime 预约开始时间
 *  @param subjectGuid          预约类型/洗车或者维修编号
 *  @param note                 预约留言内容
 *  @param callback             回调
 */
-(void)postAppointmentServiceWithAccessCode:(NSString*)accessCode
                   withAppointmentStartTime:(NSString*)appointmentStartTime
                            withSubjectGuid:(NSString*)subjectGuid
                                   withNote:(NSString*)note
                               withCallback:(Callback )callback;
@end
