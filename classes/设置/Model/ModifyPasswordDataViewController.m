//
//  ModifyPasswordDataViewController.m
//  automaintain
//
//  Created by eric on 16/7/5.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "ModifyPasswordDataViewController.h"

@implementation ModifyPasswordDataViewController

-(CustomNavigationView *)customNavigationView
{
    if (!_customNavigationView)
    {

        _customNavigationView = [CustomNavigationView customNavigationViewWithLeftBtnImage:ImageNamed(@"register_back") withRightBtnImage:nil withTitle:@"修改密码"];

    }
    return _customNavigationView;
}

-(ModifyPasswordView *)modifyPasswordView
{
    if (!_modifyPasswordView)
    {
        _modifyPasswordView = [[ModifyPasswordView alloc]init];
        _modifyPasswordView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _modifyPasswordView;
}
@end
