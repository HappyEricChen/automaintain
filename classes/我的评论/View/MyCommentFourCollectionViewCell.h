//
//  MyCommentFourCollectionViewCell.h
//  一号车库
//
//  Created by eric on 16/7/26.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "BaseCollectionViewCell.h"

@interface MyCommentFourCollectionViewCell : BaseCollectionViewCell

/**
 *  重用id
 */
extern NSString* const MyCommentFourCollectionViewCellId;
/**
 *  cell创建方法
 */
+(MyCommentFourCollectionViewCell*)collectionView:(UICollectionView*)collectionView dequeueReusableCellWithReuseIdentifier:(NSString*)reuseIdentifier forIndexPath:(NSIndexPath*)indexPath;

@end
