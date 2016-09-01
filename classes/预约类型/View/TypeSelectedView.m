//
//  TypeSelectedView.m
//  automaintain
//
//  Created by eric on 16/6/29.
//  Copyright © 2016年 eric. All rights reserved.
// 123r

#import "TypeSelectedView.h"

@implementation TypeSelectedView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        
        UIView* baseView = [[UIView alloc]init];
        [self addSubview:baseView];
        
        UISegmentedControl* segmentedControl = [[UISegmentedControl alloc]initWithItems:@[@"美容洗护服务",@"维修服务"]];
        [segmentedControl setTintColor:UIColorFromRGB(0x40add8)];
        segmentedControl.selectedSegmentIndex = 0;//初始指定第0个
        
        [segmentedControl addTarget:self action:@selector(controlPressed:)
                   forControlEvents:UIControlEventValueChanged];
        NSDictionary* attributeDic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:10],NSFontAttributeName, nil];
        [segmentedControl setTitleTextAttributes:attributeDic forState:UIControlStateNormal];
        
        [baseView addSubview:segmentedControl];
        
        baseView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
        segmentedControl.sd_layout.leftSpaceToView(baseView,ScreenWidth*0.2).rightSpaceToView(baseView,ScreenWidth*0.2).topSpaceToView(baseView,6).bottomSpaceToView(baseView,6);
    }
    return self;
}

-(void)controlPressed:(id)sender
{
    UISegmentedControl* control = (UISegmentedControl*)sender;
    
    NSInteger index = control.selectedSegmentIndex;
    switch (index)
    {
        case 0:
            
            if ([self.delegate respondsToSelector:@selector(didClickWashCarButtonWithTypeSelectedView:)])
            {
                [self.delegate didClickWashCarButtonWithTypeSelectedView:self];
            }

            break;
        case 1:
            
            if ([self.delegate respondsToSelector:@selector(didClickMaintenanceButtonWithTypeSelectedView:)])
            {
                [self.delegate didClickMaintenanceButtonWithTypeSelectedView:self];
            }

            break;
            
        default:
            break;
    }
}

@end
