//
//  CommentImageCollectionView.h
//  一号车库
//
//  Created by eric on 16/8/25.
//  Copyright © 2016年 eric. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UserCommentModel,CommentImageCollectionView;

@protocol CommentImageCollectionViewDelegate <NSObject>

@optional
/**
 *   点击评论图片调用
 */
-(void)didClickCommentImageWithCommentImageCollectionView:(CommentImageCollectionView*)commentImageCollectionView withImageUrl:(NSString*)imageUrl;
@end

@interface CommentImageCollectionView : UIView

/**
 *  collectionView
 */
@property (nonatomic, weak) UICollectionView* collectionView;


@property (nonatomic, strong) UserCommentModel* userCommentModel;

@property (nonatomic, weak) id <CommentImageCollectionViewDelegate> delegate;
@end
