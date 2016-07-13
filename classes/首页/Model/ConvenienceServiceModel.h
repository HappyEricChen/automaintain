//
//  ConvenienceServiceModel.h
//  一号车库
//
//  Created by eric on 16/7/13.
//  Copyright © 2016年 eric. All rights reserved.
// 便民服务列表模型

#import <Foundation/Foundation.h>

@interface ConvenienceServiceModel : NSObject
/**
 *
 */
@property (nonatomic, strong) NSString* Guid;
/**
 *
 */
@property (nonatomic, strong) NSString* Id;
/**
 *
 */
@property (nonatomic, strong) NSString* ServiceName;
/**
 *
 */
@property (nonatomic, strong) NSString* Sort;
@end
