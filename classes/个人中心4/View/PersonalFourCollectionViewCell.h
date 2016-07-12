//
//  PersonalFourCollectionViewCell.h
//  automaintain
//
//  Created by eric on 16/6/29.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "BaseCollectionViewCell.h"

@interface PersonalFourCollectionViewCell : BaseCollectionViewCell

/**
 *  重用id
 */
extern NSString* const personalFourId;
/**
 *  cell创建方法
 */
+(PersonalFourCollectionViewCell*)collectionView:(UICollectionView*)collectionView dequeueReusableCellWithReuseIdentifier:(NSString*)reuseIdentifier forIndexPath:(NSIndexPath*)indexPath;

@end
