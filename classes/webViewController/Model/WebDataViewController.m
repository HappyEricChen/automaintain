//
//  WebDataViewController.m
//  一号车库
//
//  Created by eric on 16/7/29.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "WebDataViewController.h"

@interface WebDataViewController()

@property (nonatomic, strong) NSString* navTitle;
@end
@implementation WebDataViewController

-(instancetype)initWithTitle:(NSString *)title
{
    self = [super init];
    if (self)
    {
        self.navTitle = title;
    }
    return self;
}


-(CustomNavigationView *)customNavigationView
{
    if (!_customNavigationView)
    {
        _customNavigationView = [CustomNavigationView customNavigationViewWithLeftBtnImage:ImageNamed(@"register_back")  withRightBtnImage:nil withTitle:self.navTitle];
    }
    return _customNavigationView;
}

@end
