//
//  OnlineMessageDataViewController.h
//  automaintain
//
//  Created by eric on 16/6/30.
//  Copyright © 2016年 eric. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MyMessageView;
@interface OnlineMessageDataViewController : NSObject

@property (nonatomic, strong) CustomNavigationView* customNavigationView;

@property (nonatomic, strong) UICollectionView* collectionView;

@property (nonatomic, strong) MyMessageView* myMessageView;

/**
 *  获取在线留言列表/POST 请求
 *
 *  @param accessCode 唯一标识符
 *  @param pageIndex  当前请求页数
 *  @param callback    回调
 */
-(void)postOnlineMessageListWithAccessCode:(NSString*)accessCode
                             withPageIndex:(NSString*)pageIndex
                              withCallback:(Callback )callback;
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

/**
 *  模型数组，上拉刷新时数据增加，下拉刷新数据保持10条最新
 */
@property (nonatomic, strong) NSMutableArray* onlineMessageModelArr;
@end
