//
//  OrderCarDataViewController.h
//  一号车库
//
//  Created by eric on 16/6/28.
//  Copyright © 2016年 eric. All rights reserved.
//  洗车预约模型

#import <Foundation/Foundation.h>
#import "WashCarDateListModel.h"

@interface OrderCarDataViewController : NSObject

@property (nonatomic, strong) CustomNavigationView* customNavigationView;

@property (nonatomic, strong) UICollectionView* collectionView;

/**
 *  我已预约的时间段
 */
@property (nonatomic, strong) NSArray* myOrderArr;
/**
 *  他人已预约的时间段
 */
@property (nonatomic, strong) NSMutableArray* otherOrderArr;

/**
 *  总的时间段
 */
@property (nonatomic, strong) NSArray* totalTimeOrderArr;


/**
 *  预约洗车/获取车位指定日期的预订表/POST 请求
 */
-(void)postListofWashCarPlaceListWithAccessCode:(NSString*)accessCode
                                withCurrentDate:(NSString*)currentDate
                                withSubjectGuid:(NSString*)subjectGuid
                                   withCallback:(Callback )callback;
/**
 *  洗车时间预约列表模型
 */
@property (nonatomic, strong) WashCarDateListModel* washCarDateListModel;

/**
 *  提交预约
 */
-(void)postAppointmentServiceWithAccessCode:(NSString*)accessCode
                   withAppointmentStartTime:(NSString*)appointmentStartTime
                            withSubjectGuid:(NSString*)subjectGuid
                               withCallback:(Callback )callback;

/**
 *   获取预约的评论列表/POST 请求
 */
-(void)postCommentListWithAccessCode:(NSString*)accessCode
                 withMaintianSubjectGuid:(NSString*)maintianSubjectGuid
                        withCallback:(Callback )callback;
@end
