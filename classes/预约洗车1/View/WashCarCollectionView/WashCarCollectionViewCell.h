//
//  WashCarCollectionViewCell.h
//  一号车库
//
//  Created by eric on 16/7/14.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "BaseCollectionViewCell.h"

@class WashCarCollectionViewCell,UIButton;

@protocol WashCarCollectionViewCellDelegate <NSObject>

@optional
-(void)didSelectedButtonWithWashCarCollectionViewCell:(WashCarCollectionViewCell*)washCarCollectionViewCell withCurrentBtn:(UIButton*)sender;
@end
@interface WashCarCollectionViewCell : BaseCollectionViewCell

/**
 *  重用id
 */
extern NSString* const WashCarCollectionViewCell1Id;
/**
 *  cell创建方法
 */
+(WashCarCollectionViewCell*)collectionView:(UICollectionView*)collectionView dequeueReusableCellWithReuseIdentifier:(NSString*)reuseIdentifier forIndexPath:(NSIndexPath*)indexPath;

/**
 *   我已预约的数组
 */
@property (nonatomic, strong) NSArray* myOrderArr;
/**
 *  已预约满的时间数组
 */
@property (nonatomic, strong) NSArray* fullOrderArr;

@property (nonatomic, weak) id <WashCarCollectionViewCellDelegate> delegate;


@end
