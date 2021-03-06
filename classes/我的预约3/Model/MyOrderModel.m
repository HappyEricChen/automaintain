//
//  MyOrderModel.m
//  一号车库
//
//  Created by eric on 16/7/19.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "MyOrderModel.h"

@implementation MyOrderModel

- (void)countDown {
    
    _m_countNum -= 1;
}

- (NSString*)currentTimeString {
    
    if (_m_countNum <= 0) {
        
        return @"00:00:00";
        
    }
    else
    {
        
        return [NSString stringWithFormat:@"%02ld:%02ld:%02ld",(long)_m_countNum/3600,(long)_m_countNum%3600/60,(long)_m_countNum%60];
    }
}

@end
