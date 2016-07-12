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
@property (nonatomic, strong) NSNumber          *defaultDay;
@property (nonatomic, copy  ) DaysSelectedBlock complete;
@property (nonatomic, strong) UIButton* selectedButton;//选中的按钮

- (id)initWithFrame:(CGRect)frame;
- (void)clickForIndex:(NSInteger)index;
- (void)show;
- (void)hide;
@end
