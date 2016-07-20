//
//  TimeSelectedDataViewController.h
//  automaintain
//
//  Created by eric on 16/6/30.
//  Copyright © 2016年 eric. All rights reserved.
// 维修时间预约

#import <Foundation/Foundation.h>

@interface TimeSelectedDataViewController : NSObject

@property (nonatomic, strong) CustomNavigationView* customNavigationView;

@property (nonatomic, strong) UICollectionView* collectionView;

/**
 *  可预约维修的时间段
 */
@property (nonatomic, strong) NSMutableArray* canOrderMaintenanceArr;
/**
 *  他人已预约维修的时间段
 */
@property (nonatomic, strong) NSMutableArray* fullOrderMaintenanceArr;


/**
 *   获取车位指定日期的预订表/POST 请求
 *
 *  @param accessCode   唯一标识
 *  @param currentDate 当前日期
 *  @param subjectGuid 预约类型/洗车或者维修编号
 *  @param callback    回调
 */
-(void)postListofWashCarPlaceListWithAccessCode:(NSString*)accessCode
                                withCurrentDate:(NSString*)currentDate
                                withSubjectGuid:(NSString*)subjectGuid
                                   withCallback:(Callback )callback;


@end
