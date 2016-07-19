//
//  MyOrderDataViewController.h
//  automaintain
//
//  Created by eric on 16/6/30.
//  Copyright © 2016年 eric. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyOrderDataViewController : NSObject

@property (nonatomic, strong) CustomNavigationView* customNavigationView;

@property (nonatomic, strong) UITableView* customTableView;

/**
 *   我的预约列表/POST 请求
 *
 *  @param accessCode   唯一标识符
 *  @param callback    回调
 */
-(void)postMyOrderListWithAccessCode:(NSString*)accessCode
                       withPageIndex:(NSString*)pageIndex
                        withCallback:(Callback )callback;
@end
