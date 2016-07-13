//
//  SecondCollectionViewCell.h
//  一号车库
//
//  Created by eric on 16/6/27.
//  Copyright © 2016年 eric. All rights reserved.
// 预约维修／洗车

#import <UIKit/UIKit.h>
@class SecondCollectionViewCell;
@protocol SecondCollectionViewCellDelegate <NSObject>

@optional
/**
 *  预约洗车点击事件
 */
-(void)didSelectedOrderCarButtonWithSecondCollectionViewCell:(SecondCollectionViewCell*)secondCollectionViewCell;
/**
 *  个人中心点击事件
 */
-(void)didSelectedPersonalButtonWithSecondCollectionViewCell:(SecondCollectionViewCell*)secondCollectionViewCell;
/**
 *  我的预约点击事件
 */
-(void)didSelectedMyOrderButtonWithSecondCollectionViewCell:(SecondCollectionViewCell*)secondCollectionViewCell;
/**
 *  预约维修点击事件
 */
-(void)didSelectedMaintenanceButtonWithSecondCollectionViewCell:(SecondCollectionViewCell*)secondCollectionViewCell;

@end
@interface SecondCollectionViewCell : BaseCollectionViewCell

/**
 *  重用id
 */
extern NSString* const secondCellId;
/**
 *  cell创建方法
 */
+(SecondCollectionViewCell*)collectionView:(UICollectionView*)collectionView dequeueReusableCellWithReuseIdentifier:(NSString*)reuseIdentifier forIndexPath:(NSIndexPath*)indexPath;

@property (nonatomic, weak) id <SecondCollectionViewCellDelegate> delegate;
@end
