//
//  OrderConfirmDataViewController.m
//  一号车库
//
//  Created by eric on 16/8/11.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "OrderConfirmDataViewController.h"
#import "OrderConfirmView.h"
@implementation OrderConfirmDataViewController

-(CustomNavigationView *)customNavigationView
{
    if (!_customNavigationView)
    {
        _customNavigationView = [CustomNavigationView customNavigationViewWithLeftBtnImage:ImageNamed(@"register_back")  withRightBtnImage:nil withTitle:@"预约确认"];
    }
    return _customNavigationView;
}

-(OrderConfirmView *)orderConfirmView
{
    if (!_orderConfirmView)
    {
        _orderConfirmView = [[OrderConfirmView alloc]init];
    }
    return _orderConfirmView;
}
@end
