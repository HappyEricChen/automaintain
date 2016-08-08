//
//  OnlineMessageDataViewController.h
//  automaintain
//
//  Created by eric on 16/6/30.
//  Copyright © 2016年 eric. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MyMessageSubmitButtonView;
@interface OnlineMessageDataViewController : NSObject

@property (nonatomic, strong) CustomNavigationView* customNavigationView;

@property (nonatomic, strong) UICollectionView* collectionView;
/**
 *  我要留言按钮
 */
@property (nonatomic, strong) MyMessageSubmitButtonView* myMessageSubmitButtonView;

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


/**
 *  模型数组，上拉刷新时数据增加，下拉刷新数据保持10条最新
 */
@property (nonatomic, strong) NSMutableArray* onlineMessageModelArr;
@end
