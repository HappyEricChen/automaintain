//
//  BaseTextField.m
//  一号车库
//
//  Created by eric on 16/8/12.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "BaseTextField.h"

@implementation BaseTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
/**
 *  禁用UITextField的双击/长按出现复制粘贴剪切等操作
 */
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    if (menuController) {
        [UIMenuController sharedMenuController].menuVisible = NO;
    }
    return NO;
}

@end
