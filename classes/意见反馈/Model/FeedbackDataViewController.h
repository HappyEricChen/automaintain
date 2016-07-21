//
//  FeedbackDataViewController.h
//  automaintain
//
//  Created by eric on 16/7/4.
//  Copyright © 2016年 eric. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FeedbackDataViewController : NSObject

@property (nonatomic, strong) CustomNavigationView* customNavigationView;

@property (nonatomic, strong) UICollectionView* collectionView;

/**
 *  功能建议的下拉菜单
 */
@property (nonatomic, strong) UITableView* listTableView;
/**
 *  意见反馈/POST 请求
 *
 *  @param accessCode     唯一标识符
 *  @param type           反馈的类型
 *  @param commentContent 反馈的内容
 *  @param callback       回调
 */
-(void)postFeedbackWithAccessCode:(NSString*)accessCode
                         withType:(NSString*)type
               withCommentContent:(NSString*)commentContent
                     withCallback:(Callback )callback;
@end
