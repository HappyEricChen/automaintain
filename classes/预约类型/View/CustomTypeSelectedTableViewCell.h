//
//  CustomTypeSelectedTableViewCell.h
//  automaintain
//
//  Created by eric on 16/6/30.
//  Copyright © 2016年 eric. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomTypeSelectedTableViewCell;
@protocol CustomTypeSelectedTableViewCellDelegate <NSObject>

@optional
-(void)didSelectedCustomTypeSelectedTableViewCell:(CustomTypeSelectedTableViewCell*)customTypeSelectedTableViewCell;

@end
@interface CustomTypeSelectedTableViewCell : UITableViewCell

/**
 *  重用id
 */
extern NSString* const CustomTypeSelectedTableViewCellId;
/**
 *  cell创建方法
 */
+(CustomTypeSelectedTableViewCell*)tableView:(UITableView*)tableView dequeueReusableCellWithReuseIdentifier:(NSString*)reuseIdentifier forIndexPath:(NSIndexPath*)indexPath;

@property (nonatomic, weak) id <CustomTypeSelectedTableViewCellDelegate> delegate;


-(void)layoutWithObject:(id)object;

@end
