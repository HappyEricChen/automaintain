//
//  SecondTimeCollectionViewCell.h
//  automaintain
//
//  Created by eric on 16/6/30.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "BaseCollectionViewCell.h"

@interface SecondTimeCollectionViewCell : BaseCollectionViewCell

/**
 *  重用id
 */
extern NSString* const secondTimeCellId;
/**
 *  cell创建方法
 */
+(SecondTimeCollectionViewCell*)collectionView:(UICollectionView*)collectionView dequeueReusableCellWithReuseIdentifier:(NSString*)reuseIdentifier forIndexPath:(NSIndexPath*)indexPath;


@end
