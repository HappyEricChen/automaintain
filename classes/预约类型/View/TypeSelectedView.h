//
//  TypeSelectedView.h
//  automaintain
//
//  Created by eric on 16/6/29.
//  Copyright © 2016年 eric. All rights reserved.
// 预约维修详情界面

#import <UIKit/UIKit.h>

@class TypeSelectedView;

@protocol TypeSelectedViewDelegate <NSObject>

@optional
/**
 *  点击了美容洗护服务按钮
 */
-(void)didClickWashCarButtonWithTypeSelectedView:(TypeSelectedView*)typeSelectedView;
/**
 *  点击了维修服务
 */
-(void)didClickMaintenanceButtonWithTypeSelectedView:(TypeSelectedView*)typeSelectedView;

@end
@interface TypeSelectedView : UIView

@property (nonatomic, weak) id <TypeSelectedViewDelegate> delegate;
@end
