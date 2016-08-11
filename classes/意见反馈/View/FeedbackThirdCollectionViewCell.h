//
//  FeedbackThirdCollectionViewCell.h
//  automaintain
//
//  Created by eric on 16/7/4.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "BaseCollectionViewCell.h"

@class FeedbackThirdCollectionViewCell;
@protocol FeedbackThirdCollectionViewCellDelegate <NSObject>

@optional
-(void)didClickSubmitButtonWithFeedbackThirdCollectionViewCell:(FeedbackThirdCollectionViewCell*)feedbackThirdCollectionViewCell;

@end

@interface FeedbackThirdCollectionViewCell : BaseCollectionViewCell

/**
 *  重用id
 */
extern NSString* const FeedbackThirdCollectionViewCellId;
/**
 *  cell创建方法
 */
+(FeedbackThirdCollectionViewCell*)collectionView:(UICollectionView*)collectionView dequeueReusableCellWithReuseIdentifier:(NSString*)reuseIdentifier forIndexPath:(NSIndexPath*)indexPath;

@property (nonatomic, weak) id <FeedbackThirdCollectionViewCellDelegate> delegate;
@end
