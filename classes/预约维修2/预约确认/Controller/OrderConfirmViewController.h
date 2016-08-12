//
//  OrderConfirmViewController.h
//  一号车库
//
//  Created by eric on 16/8/11.
//  Copyright © 2016年 eric. All rights reserved.
// 预约确认界面，给用户增加预约留言项

#import "BaseViewController.h"

@interface OrderConfirmViewController : BaseViewController


/**
 *  选中的时间段8：30-9：00
 */
@property (nonatomic, strong) NSString* timeSegment;
/**
 *  预约时间 2016-08-11 12：00
 */
@property (nonatomic, strong) NSString* orderTime;
/**
 *  预约项目
 */
@property (nonatomic, strong) NSString* orderProject;

/**
 *  项目guid
 */
@property (nonatomic, strong) NSString* subjectGuid;
/**
 *  项目价格
 */
@property (nonatomic, strong) NSString* price;
@end
