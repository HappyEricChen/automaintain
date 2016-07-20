//
//  MyOrderTableViewCell.h
//  automaintain
//
//  Created by eric on 16/6/30.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "BaseTableViewCell.h"

@class MyOrderTableViewCell;
@protocol MyOrderTableViewCellDelegate <NSObject>

@optional
/**
 *  点击发表评论按钮
 */
-(void)didSelectedCommentButtonWithMyOrderTableViewCell:(MyOrderTableViewCell*)myOrderTableViewCell;
/**
 *  点击取消预约按钮
 */
-(void)didSelectedCancelOrderButtonWithMyOrderTableViewCell:(MyOrderTableViewCell*)myOrderTableViewCell;
@end
@interface MyOrderTableViewCell : BaseTableViewCell

/**
 *  重用id
 */
extern NSString* const MyOrderTableViewCellId;
/**
 *  cell创建方法
 */
+(MyOrderTableViewCell*)tableView:(UITableView*)tableView dequeueReusableCellWithReuseIdentifier:(NSString*)reuseIdentifier forIndexPath:(NSIndexPath*)indexPath;

@property (nonatomic, weak) id <MyOrderTableViewCellDelegate> delegate;

@end
