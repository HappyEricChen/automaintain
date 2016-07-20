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
 *  项目的guid
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
/**
 *  项目内容详细描述
 */
@property (nonatomic, strong) NSString* Note;
/**
 *  项目类型，美容洗护服务/维修服务
 */
@property (nonatomic, strong) NSString* Type;
/**
 *  显示选择或者已选择/本地数据
 */
@property (nonatomic, assign) BOOL IsSelected;
@end
