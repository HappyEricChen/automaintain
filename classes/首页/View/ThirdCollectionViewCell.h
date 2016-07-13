//
//  ThirdCollectionViewCell.h
//  一号车库
//
//  Created by eric on 16/6/27.
//  Copyright © 2016年 eric. All rights reserved.
// 便民服务区

#import <UIKit/UIKit.h>

@interface ThirdCollectionViewCell : BaseCollectionViewCell

/**
 *  重用id
 */
extern NSString* const thirdCellId;
/**
 *  cell创建方法
 */
+(ThirdCollectionViewCell*)collectionView:(UICollectionView*)collectionView dequeueReusableCellWithReuseIdentifier:(NSString*)reuseIdentifier forIndexPath:(NSIndexPath*)indexPath;

@end
