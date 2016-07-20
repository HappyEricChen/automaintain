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

/**
 *  模型数组，上拉刷新时数据增加，下拉刷新数据保持10条最新
 */
@property (nonatomic, strong) NSMutableArray* myOrderModelArr;

/**
 *  取消预约/POST 请求
 *
 *  @param accessCode 唯一标识符
 *  @param appointmentGuid  预约时间段的唯一id
 *  @param callback    回调
 */
-(void)postCancelOrderWithAccessCode:(NSString*)accessCode
                 withAppointmentGuid:(NSString*)appointmentGuid
                        withCallback:(Callback )callback;
@end
