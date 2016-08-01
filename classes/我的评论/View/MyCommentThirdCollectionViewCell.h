//
//  MyCommentThirdCollectionViewCell.h
//  automaintain
//
//  Created by eric on 16/7/4.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "BaseCollectionViewCell.h"

@class MyCommentThirdCollectionViewCell;
@protocol MyCommentThirdCollectionViewCellDelegate <NSObject>

@optional
/**
 *  点击选择照片按钮，从相机或者相册选择照片
 */
-(void)didSelectedCameraWithMyCommentThirdCollectionViewCell:(MyCommentThirdCollectionViewCell*)myCommentThirdCollectionViewCell;
/**
 *  点击删除照片按钮，在照片数组删除当前的照片
 */
-(void)didClickDeleteImageButtonWithMyCommentThirdCollectionViewCell:(MyCommentThirdCollectionViewCell*)myCommentThirdCollectionViewCell withImage:(UIImage*)image;
@end

@interface MyCommentThirdCollectionViewCell : BaseCollectionViewCell

/**
 *  重用id
 */
extern NSString* const MyCommentThirdCollectionViewCellId;
/**
 *  cell创建方法
 */
+(MyCommentThirdCollectionViewCell*)collectionView:(UICollectionView*)collectionView dequeueReusableCellWithReuseIdentifier:(NSString*)reuseIdentifier forIndexPath:(NSIndexPath*)indexPath;

@property (nonatomic, weak) id <MyCommentThirdCollectionViewCellDelegate> delegate;
@end
