//
//  FeedbackFirstCollectionViewCell.h
//  automaintain
//
//  Created by eric on 16/7/4.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "BaseCollectionViewCell.h"

@class FeedbackFirstCollectionViewCell;
@protocol FeedbackFirstCollectionViewCellDelegate <NSObject>

@optional
/**
 *  点击下拉菜单选择反馈类型
 */
-(void)didClickListButtonWithFeedbackFirstCollectionViewCell:(FeedbackFirstCollectionViewCell*)feedbackFirstCollectionViewCell;

@end
@interface FeedbackFirstCollectionViewCell : BaseCollectionViewCell

/**
 *  重用id
 */
extern NSString* const FeedbackFirstCollectionViewCellId;
/**
 *  cell创建方法
 */
+(FeedbackFirstCollectionViewCell*)collectionView:(UICollectionView*)collectionView dequeueReusableCellWithReuseIdentifier:(NSString*)reuseIdentifier forIndexPath:(NSIndexPath*)indexPath;


@property (nonatomic, weak) id <FeedbackFirstCollectionViewCellDelegate> delegate;
@end
