//
//  BaseCollectionViewCell.h
//  automaintain
//
//  Created by eric on 16/6/27.
//  Copyright © 2016年 eric. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseCollectionViewCell : UICollectionViewCell
/**
 *  cell数据传递时用
 */
-(void)layoutWithObject:(id)object;

@end
