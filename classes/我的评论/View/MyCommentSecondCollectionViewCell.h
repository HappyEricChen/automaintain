//
//  MyCommentSecondCollectionViewCell.h
//  automaintain
//
//  Created by eric on 16/7/4.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "BaseCollectionViewCell.h"

@class MyCommentSecondCollectionViewCell;
@protocol MyCommentSecondCollectionViewCellDelegate <NSObject>

@optional
/**
 *  点击选择照片按钮，从相机或者相册选择照片
 */
-(void)didSelectedCameraWithMyCommentSecondCollectionViewCell:(MyCommentSecondCollectionViewCell*)myCommentSecondCollectionViewCell;
/**
 *  点击相片跳转到放大的控制器，可以删除照片
 */
-(void)didClickImageViewWithMyCommentSecondCollectionViewCell:(MyCommentSecondCollectionViewCell*)myCommentSecondCollectionViewCell withImage:(UIImage*)image;
@end
@interface MyCommentSecondCollectionViewCell : BaseCollectionViewCell

/**
 *  重用id
 */
extern NSString* const MyCommentSecondCollectionViewCellId;
/**
 *  cell创建方法
 */
+(MyCommentSecondCollectionViewCell*)collectionView:(UICollectionView*)collectionView dequeueReusableCellWithReuseIdentifier:(NSString*)reuseIdentifier forIndexPath:(NSIndexPath*)indexPath;

@property (nonatomic, weak) id <MyCommentSecondCollectionViewCellDelegate> delegate;
@end
