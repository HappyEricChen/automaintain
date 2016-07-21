//
//  MaintenanceDataViewController.h
//  automaintain
//
//  Created by eric on 16/6/29.
//  Copyright © 2016年 eric. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MaintenanceHeaderView;
@interface MaintenanceDataViewController : NSObject

@property (nonatomic, strong) CustomNavigationView* customNavigationView;

@property (nonatomic, strong) MaintenanceHeaderView* maintenanceHeaderView;

@property (nonatomic, strong) UICollectionView* collectionView;

/**
 *   提交预约/POST 请求
 *
 *  @param accessCode   唯一标识
 *  @param appointmentStartTime 预约开始时间
 *  @param subjectGuid 预约类型/洗车或者维修编号
 *  @param callback    回调
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
