//
//  UserCommentModel.h
//  一号车库
//
//  Created by eric on 16/7/15.
//  Copyright © 2016年 eric. All rights reserved.
// 用户评价模型

#import <Foundation/Foundation.h>

@interface UserCommentModel : NSObject
/**
 *  评论内容
 */
@property (nonatomic, strong) NSString* CommentContent;
/**
 *  评论发表时间 CreateTime = "2016-06-28T15:23:25.16";
 */
@property (nonatomic, strong) NSString* CreateTime;
/**
 *  评论图片url
 */
@property (nonatomic, strong) NSString* PhotoUrls;
/**
 *  评论星星数量
 */
@property (nonatomic, strong) NSString* Stars;
@end
