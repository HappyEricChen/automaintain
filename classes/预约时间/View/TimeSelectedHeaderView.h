//
//  TimeSelectedHeaderView.h
//  automaintain
//
//  Created by eric on 16/6/30.
//  Copyright © 2016年 eric. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeSelectedHeaderView : UICollectionReusableView

extern NSString* const TimeSelectedHeaderViewId;

/**
 *  headerView创建方法
 */
+(TimeSelectedHeaderView*)collectionView:(UICollectionView*)collectionView dequeueReusableCellWithReuseIdentifier:(NSString*)reuseIdentifier forIndexPath:(NSIndexPath*)indexPath;

-(void)layoutWithImage:(UIImage*)image withTitle:(NSString*)title withMyOrderHidden:(BOOL)hidden;
@end
