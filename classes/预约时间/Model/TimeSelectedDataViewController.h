//
//  TimeSelectedDataViewController.h
//  automaintain
//
//  Created by eric on 16/6/30.
//  Copyright © 2016年 eric. All rights reserved.
// 维修时间预约

#import <Foundation/Foundation.h>

@interface TimeSelectedDataViewController : NSObject

@property (nonatomic, strong) CustomNavigationView* customNavigationView;

@property (nonatomic, strong) UICollectionView* collectionView;

/**
 *  可预约维修的时间段
 */
@property (nonatomic, strong) NSArray* canOrderMaintenanceArr;
/**
 *  他人已预约维修的时间段
 */
@property (nonatomic, strong) NSArray* otherOrderMaintenanceArr;


/**
 *  预约维修数据加载
 */
-(void)loadMaintenanceOrderTimeArr;
@end
