//
//  OrderConfirmView.h
//  一号车库
//
//  Created by eric on 16/8/11.
//  Copyright © 2016年 eric. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OrderConfirmView;
@protocol OrderConfirmViewDelegate <NSObject>

@optional
/**
 *  点击预约提交按钮调用
 */
-(void)didClickSubmitButtonWithOrderConfirmView:(OrderConfirmView*)orderConfirmView withMessageContent:(NSString*)messageContent;
/**
 *  点击取消预约按钮调用
 */
-(void)didClickCancelButtonWithOrderConfirmView:(OrderConfirmView*)orderConfirmView;
@end
@interface OrderConfirmView : UIView

/**
 *  界面布局，
 *
 *  @param totalTime    所需时间30分钟
 *  @param orderTime    预约时间2016-08-11  12:00
 *  @param orderProject 预约项目：普通洗车
 */
-(void)layoutWithTotalTime:(NSString*)totalTime withOrderTime:(NSString*)orderTime withOrderProject:(NSString*)orderProject withPrice:(NSString*)price;

@property (nonatomic, weak) id <OrderConfirmViewDelegate> delegate;
@end
