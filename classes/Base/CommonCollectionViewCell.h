//
//  CommonCollectionViewCell.h
//  automaintain
//
//  Created by eric on 16/6/27.
//  Copyright © 2016年 eric. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonCollectionViewCell : BaseCollectionViewCell

/**
 *  重用id
 */
extern NSString* const commonCellId;
/**
 *  cell创建方法
 */
+(CommonCollectionViewCell*)collectionView:(UICollectionView*)collectionView dequeueReusableCellWithReuseIdentifier:(NSString*)reuseIdentifier forIndexPath:(NSIndexPath*)indexPath;

-(void)layoutTextColorWithColor:(UIColor*)textColor;

-(void)layoutBackgroundColorWithColor:(UIColor*)Color;
@end
