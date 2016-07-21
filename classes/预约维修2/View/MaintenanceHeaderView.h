//
//  MaintenanceHeaderView.h
//  automaintain
//
//  Created by eric on 16/6/29.
//  Copyright © 2016年 eric. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MaintenanceHeaderView,OrderTypeModel;

@protocol MaintenanceHeaderViewDelegate <NSObject>

@optional
/**
 *  预约类型点击事件
 */
-(void)didSelectedTypeChangeButtonWithMaintenanceHeaderView:(MaintenanceHeaderView*)maintenanceHeaderView;
/**
 *  预约时间点击事件
 */
-(void)didSelectedTimeChangeButtonWithMaintenanceHeaderView:(MaintenanceHeaderView*)maintenanceHeaderView;
/**
 *  提交选择的预约
 */
-(void)didSelectedSubmitOrderButtonWithMaintenanceHeaderView:(MaintenanceHeaderView*)maintenanceHeaderView;
@end
@interface MaintenanceHeaderView : UIView

@property (nonatomic, weak) id <MaintenanceHeaderViewDelegate> delegate;
/**
 *  预约类型模型+完整的日期时间，传递数据布局界面 2017-02-03 08:15-08:30
 */
-(void)layoutWithOrderTypeModel:(OrderTypeModel*)orderTypeModel withCompletedTime:(NSString*)completedTime;
@end
