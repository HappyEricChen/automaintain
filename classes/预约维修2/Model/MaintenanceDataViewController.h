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

/**
 *   获取预约的评论列表/POST 请求
 *
 *  @param accessCode   唯一标识
 *  @param pageIndex   页数
 *  @param callback    回调
 */
-(void)postCommentListWithAccessCode:(NSString*)accessCode
                       withPageIndex:(NSString*)pageIndex
                        withCallback:(Callback )callback;
/**
 *  模型数组，上拉刷新时数据增加，下拉刷新数据保持10条最新
 */
@property (nonatomic, strong) NSMutableArray* userCommentModelArr;

@end
