//
//  WashCarSecondCollectionViewCell.h
//  一号车库
//
//  Created by eric on 16/6/28.
//  Copyright © 2016年 eric. All rights reserved.
//  预约时间详情

#import "BaseCollectionViewCell.h"

@interface WashCarSecondCollectionViewCell : BaseCollectionViewCell

/**
 *  重用id
 */
extern NSString* const WashCarSecondId;
/**
 *  cell创建方法
 */
+(WashCarSecondCollectionViewCell*)collectionView:(UICollectionView*)collectionView dequeueReusableCellWithReuseIdentifier:(NSString*)reuseIdentifier forIndexPath:(NSIndexPath*)indexPath;

@end
