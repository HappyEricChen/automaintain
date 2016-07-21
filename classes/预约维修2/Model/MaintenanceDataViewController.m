//
//  MaintenanceDataViewController.m
//  automaintain
//
//  Created by eric on 16/6/29.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "MaintenanceDataViewController.h"
#import "MaintenanceHeaderView.h"
#import "WashCarFiveCollectionViewCell.h"
#import "CommentHeaderView.h"

@implementation MaintenanceDataViewController

-(CustomNavigationView *)customNavigationView
{
    if (!_customNavigationView)
    {
        _customNavigationView = [CustomNavigationView customNavigationViewWithLeftBtnImage:ImageNamed(@"register_back")  withRightBtnImage:nil withTitle:@"维修保养"];
    }
    return _customNavigationView;
}

-(UIView *)maintenanceHeaderView
{
    if (!_maintenanceHeaderView)
    {
        _maintenanceHeaderView = [[MaintenanceHeaderView alloc]init];
    }
    return _maintenanceHeaderView;
}

-(UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor clearColor];
        
        [_collectionView registerClass:[WashCarFiveCollectionViewCell class] forCellWithReuseIdentifier:WashCarFiveCollectionViewCellId];
        
        [_collectionView registerClass:[CommentHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerId];
    }
    return _collectionView;
}
#pragma mark - 提交预约
-(void)postAppointmentServiceWithAccessCode:(NSString *)accessCode withAppointmentStartTime:(NSString *)appointmentStartTime withSubjectGuid:(NSString *)subjectGuid withCallback:(Callback)callback
{
    [AutomaintainAPI postAppointmentServiceWithAccessCode:accessCode withAppointmentStartTime:appointmentStartTime withSubjectGuid:subjectGuid withCallback:^(BOOL success, NSError *error, id result)
     {
         if (success)
         {
             callback(YES,nil,result);
         }
         else
         {
             callback(NO,nil,result);
         }
     }];
    
}
#pragma mark - 获取预约的评论列表
-(void)postCommentListWithAccessCode:(NSString *)accessCode withMaintianSubjectGuid:(NSString *)maintianSubjectGuid withCallback:(Callback)callback
{
    [AutomaintainAPI postCommentListWithAccessCode:accessCode withMaintianSubjectGuid:maintianSubjectGuid withCallback:^(BOOL success, NSError *error, id result)
     {
         if (success)
         {
             
             callback(YES,nil,result);
         }
         else
         {
             callback(NO,nil,result);
         }
     }];
}
@end
