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
@end
@interface MaintenanceHeaderView : UIView

@property (nonatomic, weak) id <MaintenanceHeaderViewDelegate> delegate;

-(void)layoutWithOrderTypeModel:(OrderTypeModel*)orderTypeModel;
@end
