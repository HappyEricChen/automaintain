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
@property (nonatomic, strong) NSArray* totalArr;

/**
 *  label上文字的字体大小
 */
@property (nonatomic, assign) NSInteger fontSize;

/**
 *  判断是洗车界面还是首页
 */
@property (nonatomic, strong) NSString* pageName;

/**
 *  文字的颜色
 */
@property (nonatomic, strong) UIColor* textColor;

/**
 *  框框的颜色
 */
@property (nonatomic, strong) UIColor* backgroundColor;

@end
