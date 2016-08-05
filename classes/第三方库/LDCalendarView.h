//
//  LDCalendarView.h
//
//  Created by lidi on 15/9/1.
//  Copyright (c) 2015年 lidi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDCalendarConst.h"

typedef void(^DaysSelectedBlock)(NSNumber *result);

@interface LDCalendarView : UIView
/**
 *  默认的天
 */
@property (nonatomic, strong) NSNumber          *defaultDay;
/**
 *  回调
 */
@property (nonatomic, copy  ) DaysSelectedBlock complete;
/**
 *  选中的按钮
 */
@property (nonatomic, strong) UIButton* selectedButton;

- (id)initWithFrame:(CGRect)frame;
- (void)clickForIndex:(NSInteger)index;
- (void)show;
- (void)hide;
@end
