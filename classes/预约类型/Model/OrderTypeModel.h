//
//  OrderTypeModel.h
//  一号车库
//
//  Created by eric on 16/7/19.
//  Copyright © 2016年 eric. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderTypeModel : NSObject
/**
 *  Guid
 */
@property (nonatomic, strong) NSString* Guid;
/**
 *  项目需要的时间
 */
@property (nonatomic, strong) NSString* NeedTime;
/**
 *  项目的价格
 */
@property (nonatomic, strong) NSString* Price;
/**
 *  项目名称
 */
@property (nonatomic, strong) NSString* SubjectName;
@end
