//
//  MyCommentThirdCollectionViewCell.h
//  automaintain
//
//  Created by eric on 16/7/4.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "BaseCollectionViewCell.h"

@interface MyCommentThirdCollectionViewCell : BaseCollectionViewCell

/**
 *  重用id
 */
extern NSString* const MyCommentThirdCollectionViewCellId;
/**
 *  cell创建方法
 */
+(MyCommentThirdCollectionViewCell*)collectionView:(UICollectionView*)collectionView dequeueReusableCellWithReuseIdentifier:(NSString*)reuseIdentifier forIndexPath:(NSIndexPath*)indexPath;


@end
