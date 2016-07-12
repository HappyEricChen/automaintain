//
//  FeedbackSecondCollectionViewCell.h
//  automaintain
//
//  Created by eric on 16/7/4.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "BaseCollectionViewCell.h"

@interface FeedbackSecondCollectionViewCell : BaseCollectionViewCell

/**
 *  重用id
 */
extern NSString* const FeedbackSecondCollectionViewCellId;
/**
 *  cell创建方法
 */
+(FeedbackSecondCollectionViewCell*)collectionView:(UICollectionView*)collectionView dequeueReusableCellWithReuseIdentifier:(NSString*)reuseIdentifier forIndexPath:(NSIndexPath*)indexPath;


@end
