//
//  BaseTableViewCell.h
//  automaintain
//
//  Created by eric on 16/6/30.
//  Copyright © 2016年 eric. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewCell : UITableViewCell


/**
 *  我的预约倒计时用的布尔值
 */
@property (nonatomic)       BOOL         m_isDisplayed;


/**
 *  cell数据传递时用
 */
-(void)layoutWithObject:(id)object;


/**
 *  cell数据传递时用
 */
-(void)layoutWithObject:(id)object indexPath:(NSIndexPath*)indexPath;
@end
