//
//  FourCollectionViewCell.h
//  一号车库
//
//  Created by eric on 16/6/27.
//  Copyright © 2016年 eric. All rights reserved.
//  广告区

#import "BaseCollectionViewCell.h"

@interface FourCollectionViewCell : BaseCollectionViewCell

/**
 *  重用id
 */
extern NSString* const fourCellId;
/**
 *  cell创建方法
 */
+(FourCollectionViewCell*)collectionView:(UICollectionView*)collectionView dequeueReusableCellWithReuseIdentifier:(NSString*)reuseIdentifier forIndexPath:(NSIndexPath*)indexPath;

@end
