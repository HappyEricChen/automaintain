//
//  FreeHeadView.h
//  一号车库
//
//  Created by eric on 16/9/7.
//  Copyright © 2016年 eric. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FreeHeadView : UICollectionReusableView

extern NSString* const freeHeaderId;

/**
 *  headerView创建方法
 */
+(FreeHeadView*)collectionView:(UICollectionView*)collectionView
dequeueReusableCellWithReuseIdentifier:(NSString*)reuseIdentifier
                  forIndexPath:(NSIndexPath*)indexPath;


@end
