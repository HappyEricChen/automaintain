//
//  MaintenanceDataViewController.h
//  automaintain
//
//  Created by eric on 16/6/29.
//  Copyright © 2016年 eric. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MaintenanceHeaderView;
@interface MaintenanceDataViewController : NSObject

@property (nonatomic, strong) CustomNavigationView* customNavigationView;

@property (nonatomic, strong) MaintenanceHeaderView* maintenanceHeaderView;

@property (nonatomic, strong) UICollectionView* collectionView;
@end
