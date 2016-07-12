//
//  PersonalFirstCollectionViewCell.h
//  automaintain
//
//  Created by eric on 16/6/29.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "BaseCollectionViewCell.h"

@interface PersonalFirstCollectionViewCell : BaseCollectionViewCell

/**
 *  重用id
 */
extern NSString* const personalFirstId;
/**
 *  cell创建方法
 */
+(PersonalFirstCollectionViewCell*)collectionView:(UICollectionView*)collectionView dequeueReusableCellWithReuseIdentifier:(NSString*)reuseIdentifier forIndexPath:(NSIndexPath*)indexPath;

@end
