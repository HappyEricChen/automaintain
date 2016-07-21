//
//  TimeSelectedDataViewController.m
//  automaintain
//
//  Created by eric on 16/6/30.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "TimeSelectedDataViewController.h"
#import "WashCarFirstCollectionViewCell.h"
#import "TimeSelectedHeaderView.h"
#import "FirstTimeSelecetdCollectionViewCell.h"
#import "SecondTimeCollectionViewCell.h"
#import "WashCarDateListModel.h"
#import "ScheduleListModel.h"

@implementation TimeSelectedDataViewController

-(CustomNavigationView *)customNavigationView
{
    if (!_customNavigationView)
    {
        _customNavigationView = [CustomNavigationView customNavigationViewWithLeftBtnImage:ImageNamed(@"register_back")  withRightBtnImage:nil withTitle:@"预约时间"];
    }
    return _customNavigationView;
}

-(UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor clearColor];
        
        [_collectionView registerClass:[WashCarFirstCollectionViewCell class] forCellWithReuseIdentifier:washCarFirstId];
        [_collectionView registerClass:[FirstTimeSelecetdCollectionViewCell class] forCellWithReuseIdentifier:firstTimeCellId];
        [_collectionView registerClass:[SecondTimeCollectionViewCell class] forCellWithReuseIdentifier:secondTimeCellId];
        
        [_collectionView registerClass:[TimeSelectedHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:TimeSelectedHeaderViewId];
        
        
    }
    return _collectionView;
}

-(NSMutableArray *)fullOrderMaintenanceArr
{
    if (!_fullOrderMaintenanceArr)
    {
        _fullOrderMaintenanceArr = [NSMutableArray array];
    }
    return _fullOrderMaintenanceArr;
}

-(NSMutableArray *)canOrderMaintenanceArr
{
    if (!_canOrderMaintenanceArr)
    {
        _canOrderMaintenanceArr = [NSMutableArray array];
    }
    return _canOrderMaintenanceArr;
}

-(void)postListofWashCarPlaceListWithAccessCode:(NSString *)accessCode
                                withCurrentDate:(NSString *)currentDate
                                withSubjectGuid:(NSString *)subjectGuid
                                   withCallback:(Callback)callback
{
    [AutomaintainAPI postListofWashCarPlaceListWithAccessCode:accessCode
                                              withCurrentDate:currentDate
                                              withSubjectGuid:subjectGuid
                                                 withCallback:^(BOOL success, NSError *error, id result)
     {
         [self.canOrderMaintenanceArr removeAllObjects];
         [self.fullOrderMaintenanceArr removeAllObjects];
         
         if (success)
         {
             WashCarDateListModel* washCarDateListModel = (WashCarDateListModel*)result;
             
             for (ScheduleListModel* scheduleListModel in washCarDateListModel.Schedule)
             {
                 if ([washCarDateListModel.MaxPlaceNum isEqualToString:scheduleListModel.AppointmentCount])
                 {
                     [self.fullOrderMaintenanceArr addObject:scheduleListModel];
                 }
                 else
                 {
                     [self.canOrderMaintenanceArr addObject:scheduleListModel];
                 }
             }
             callback(YES,nil,result);
         }
         else
         {
             callback(NO,nil,result);
         }
     }];
}

@end
