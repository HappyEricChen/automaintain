//
//  CommentImageCollectionViewCell.h
//  一号车库
//
//  Created by eric on 16/8/25.
//  Copyright © 2016年 eric. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentImageCollectionViewCell : BaseCollectionViewCell

/**
 *  重用id
 */
extern NSString* const CommentImageCollectionViewCellId;
/**
 *  cell创建方法
 */
+(CommentImageCollectionViewCell*)collectionView:(UICollectionView*)collectionView dequeueReusableCellWithReuseIdentifier:(NSString*)reuseIdentifier forIndexPath:(NSIndexPath*)indexPath;


@end
