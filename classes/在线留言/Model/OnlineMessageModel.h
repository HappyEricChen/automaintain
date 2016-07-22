//
//  OnlineMessageModel.h
//  一号车库
//
//  Created by eric on 16/7/22.
//  Copyright © 2016年 eric. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OnlineMessageModel : NSObject
/**
 *  创建时间
 */
@property (nonatomic, strong) NSString* CreateTime;
/**
 *  服务器回复的内容
 */
@property (nonatomic, strong) NSString* ReplyContent;
/**
 *  服务器回复时间
 */
@property (nonatomic, strong) NSString* ReplyTime;
/**
 *  回复状态，未回复=New/已回复=Replied
 */
@property (nonatomic, strong) NSString* Status;
/**
 *  留言内容
 */
@property (nonatomic, strong) NSString* Text;

@end
