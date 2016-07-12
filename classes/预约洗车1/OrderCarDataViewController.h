//
//  OrderCarDataViewController.h
//  一号车库
//
//  Created by eric on 16/6/28.
//  Copyright © 2016年 eric. All rights reserved.
//  洗车预约模型

#import <Foundation/Foundation.h>

@interface OrderCarDataViewController : NSObject

@property (nonatomic, strong) CustomNavigationView* customNavigationView;

@property (nonatomic, strong) UICollectionView* collectionView;

/**
 *  我已预约的时间段
 */
@property (nonatomic, strong) NSArray* myOrderArr;
/**
 *  他人已预约的时间段
 */
@property (nonatomic, strong) NSArray* otherOrderArr;

/**
 *  总的时间段
 */
@property (nonatomic, strong) NSArray* totalTimeOrderArr;

/**
 * 总的用户评论数组，包含MyCommentModel模型数据
 */
@property (nonatomic, strong) NSArray* myCommentModelArr;
/**
 *  加载洗车预约时间的数组：我的预约/他人预约时间
 */
-(void)loadWashCarOrderTimeArr;
@end
