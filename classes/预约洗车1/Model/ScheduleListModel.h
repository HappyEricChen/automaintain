//
//  ScheduleListModel.h
//  一号车库
//
//  Created by eric on 16/7/15.
//  Copyright © 2016年 eric. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScheduleListModel : NSObject

/**
 *  起始时间 ShopTime = "20:45:00";
 */
@property (nonatomic, strong) NSString* ShopTime;
/**
 *  时间段显示 TimeSegment = "20:45-21:00";
 */
@property (nonatomic, strong) NSString* TimeSegment;
/**
 *  该时间段被预约的次数
 */
@property (nonatomic, strong) NSString* AppointmentCount;

@end
