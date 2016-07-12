//
//  MyCommentFirstCollectionViewCell.h
//  automaintain
//
//  Created by eric on 16/7/1.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "BaseCollectionViewCell.h"

@interface MyCommentFirstCollectionViewCell : BaseCollectionViewCell

/**
 *  重用id
 */
extern NSString* const MyCommentFirstCollectionViewCellId;
/**
 *  cell创建方法
 */
+(MyCommentFirstCollectionViewCell*)collectionView:(UICollectionView*)collectionView dequeueReusableCellWithReuseIdentifier:(NSString*)reuseIdentifier forIndexPath:(NSIndexPath*)indexPath;

@end
