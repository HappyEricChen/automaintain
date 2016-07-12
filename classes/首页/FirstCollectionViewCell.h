//
//  FirstCollectionViewCell.h
//  一号车库
//
//  Created by eric on 16/6/27.
//  Copyright © 2016年 eric. All rights reserved.
// 图片轮播banner

#import <UIKit/UIKit.h>

@interface FirstCollectionViewCell : BaseCollectionViewCell
/**
 *  重用id
 */
extern NSString* const firstCellId;
/**
 *  cell创建方法
 */
+(FirstCollectionViewCell*)collectionView:(UICollectionView*)collectionView dequeueReusableCellWithReuseIdentifier:(NSString*)reuseIdentifier forIndexPath:(NSIndexPath*)indexPath;
@end
