//
//  OnlineMessageDataViewController.h
//  automaintain
//
//  Created by eric on 16/6/30.
//  Copyright © 2016年 eric. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OnlineMessageDataViewController : NSObject

@property (nonatomic, strong) CustomNavigationView* customNavigationView;

@property (nonatomic, strong) UICollectionView* collectionView;

@property (nonatomic, strong) UIView* myMessageView;

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
@end
