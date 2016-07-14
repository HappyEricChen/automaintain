//
//  WashCarCollectionView.h
//  一号车库
//
//  Created by eric on 16/7/14.
//  Copyright © 2016年 eric. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WashCarDateListModel;

@interface WashCarCollectionView : UIView
/**
 *  总的时间数组
 */
@property (nonatomic, strong) NSArray* totalArr;
/**
 *  我已预约的时间数组
 */
@property (nonatomic, strong) NSArray* myOrderArr;
/**
 *  已被预约满的时间数组
 */
@property (nonatomic, strong) NSMutableArray* fullOrderArr;

/**
 *  collectionView
 */
@property (nonatomic, weak) UICollectionView* collectionView;
/**
 *  模型
 */
@property (nonatomic, strong) WashCarDateListModel* washCarDateListModel;

/**
 *  解析模型数据
 */
-(void)parseWashCarDateListModel;
@end
