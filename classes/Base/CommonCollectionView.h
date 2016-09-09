//
//  CommonCollectionView.h
//  automaintain
//
//  Created by eric on 16/6/27.
//  Copyright © 2016年 eric. All rights reserved.
//  首页和我的预约类的公用collectionView，里面只包含一个label

#import <UIKit/UIKit.h>

@interface CommonCollectionView : UIView

/**
 *  label上文字的内容，在数组中遍历
 */
@property (nonatomic, strong) NSMutableArray* totalArr;


@property (nonatomic, weak) UICollectionView* collectionView;

@end
