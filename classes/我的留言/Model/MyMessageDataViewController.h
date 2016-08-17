//
//  MyMessageDataViewController.h
//  一号车库
//
//  Created by eric on 16/8/8.
//  Copyright © 2016年 eric. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MyMessageView;
@interface MyMessageDataViewController : NSObject

@property (nonatomic, strong) MyMessageView* myMessageView;

@property (nonatomic, strong) CustomNavigationView* customNavigationView;

#pragma mark - 提交我的留言
/**
 *   提交我的留言/POST 请求
 *
 *  @param accessCode 唯一标识符
 *  @param commentContent  在线留言内容
 *  @param callback    回调
 */
-(void)postMessageToServiceWithAccessCode:(NSString*)accessCode
                       withCommentContent:(NSString*)commentContent
                             withCallback:(Callback )callback;
@end
