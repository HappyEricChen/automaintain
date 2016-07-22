//
//  CommentHeaderView.h
//  一号车库
//
//  Created by eric on 16/6/28.
//  Copyright © 2016年 eric. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentHeaderView : UICollectionReusableView

extern NSString* const headerId;

/**
 *  headerView创建方法
 */
+(CommentHeaderView*)collectionView:(UICollectionView*)collectionView
dequeueReusableCellWithReuseIdentifier:(NSString*)reuseIdentifier
                       forIndexPath:(NSIndexPath*)indexPath;

-(void)layoutWithObject:(NSInteger)object;
@end
