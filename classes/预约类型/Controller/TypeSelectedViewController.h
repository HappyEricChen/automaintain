//
//  TypeSelectedViewController.h
//  automaintain
//
//  Created by eric on 16/6/29.
//  Copyright © 2016年 eric. All rights reserved.
// 预约维修

#import "BaseViewController.h"
@class OrderTypeModel;
@interface TypeSelectedViewController : BaseViewController
/**
 *   选中项目模型
 */
@property (nonatomic, strong) OrderTypeModel* orderTypeModel;
@end
