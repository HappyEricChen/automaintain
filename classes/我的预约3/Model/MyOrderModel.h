//
//  MyOrderModel.h
//  一号车库
//
//  Created by eric on 16/7/19.
//  Copyright © 2016年 eric. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyOrderModel : NSObject
/**
 *  项目对应的唯一guid
 */
@property (nonatomic, strong) NSString* AppointmentGuid;

/**
 *  预约类型/洗车/维修
 */
@property (nonatomic, strong) NSString* AppointmentName;
/**
 *  审核状态/已审核，已取消，已完成，服务中
 */
@property (nonatomic, strong) NSString* AppointmentStatus;
/**
 *  项目结束时间
 */
@property (nonatomic, strong) NSString* EndTime;
/**
 *  项目起始时间
 */
@property (nonatomic, strong) NSString* StartTime;
/**
 *  是否已评论过/评论过=1，未评论=0
 */
@property (nonatomic, strong) NSString* HasComment;

@end
