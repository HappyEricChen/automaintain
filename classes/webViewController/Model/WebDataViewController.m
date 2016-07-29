//
//  WebDataViewController.m
//  一号车库
//
//  Created by eric on 16/7/29.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "WebDataViewController.h"

@implementation WebDataViewController

-(CustomNavigationView *)customNavigationView
{
    if (!_customNavigationView)
    {
        _customNavigationView = [CustomNavigationView customNavigationViewWithLeftBtnImage:ImageNamed(@"register_back")  withRightBtnImage:nil withTitle:nil];
    }
    return _customNavigationView;
}

@end
