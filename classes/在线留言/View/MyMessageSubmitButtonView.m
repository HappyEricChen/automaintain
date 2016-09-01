//
//  MyMessageSubmitButtonView.m
//  一号车库
//
//  Created by eric on 16/8/8.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "MyMessageSubmitButtonView.h"

@implementation MyMessageSubmitButtonView

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        
        UIButton* submitButton = [[UIButton alloc]init];
        [submitButton setBackgroundImage:ImageNamed(@"register_commit") forState:UIControlStateNormal];
        [submitButton setTitle:@"我要留言" forState:UIControlStateNormal];
        submitButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [submitButton addTarget:self action:@selector(clickSubmitButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:submitButton];
        
        submitButton.sd_layout.spaceToSuperView(UIEdgeInsetsMake(ScreenHeight*0.015, 0, 0, 0));
        
        
    }
    return self;
}

-(void)clickSubmitButton:(UIButton*)sender
{
    if ([self.delegate respondsToSelector:@selector(didClickMyMessageSubmitButtonView:)])
    {
        [self.delegate didClickMyMessageSubmitButtonView:self];
    }
}
@end
