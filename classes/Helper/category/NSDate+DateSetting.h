//
//  NSDate+DateSetting.h
//  一号车库
//
//  Created by eric on 16/8/1.
//  Copyright © 2016年 eric. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (DateSetting)

/**
 *  检查手机是12小时制还是24小时制
 */
+ (BOOL)isDaySetting24Hours;
@end
