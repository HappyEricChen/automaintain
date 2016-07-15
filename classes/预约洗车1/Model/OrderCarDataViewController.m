//
//  OrderCarDataViewController.m
//  一号车库
//
//  Created by eric on 16/6/28.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "OrderCarDataViewController.h"
#import "WashCarFirstCollectionViewCell.h"
#import "WashCarSecondCollectionViewCell.h"
#import "WashCarThirdCollectionViewCell.h"
#import "WashCarFourCollectionViewCell.h"
#import "WashCarFiveCollectionViewCell.h"
#import "CommentHeaderView.h"
#import "MyCommentModel.h"

@implementation OrderCarDataViewController

-(CustomNavigationView *)customNavigationView
{
    if (!_customNavigationView)
    {
        _customNavigationView = [CustomNavigationView customNavigationViewWithLeftBtnImage:ImageNamed(@"register_back") withRightBtnImage:nil withTitle:@"预约洗车"];
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
        [_collectionView registerClass:[WashCarSecondCollectionViewCell class] forCellWithReuseIdentifier:WashCarSecondId];
        [_collectionView registerClass:[WashCarThirdCollectionViewCell class] forCellWithReuseIdentifier:WashCarThirdCollectionViewCellId];
        [_collectionView registerClass:[WashCarFourCollectionViewCell class] forCellWithReuseIdentifier:WashCarFourCollectionViewCellId];
        [_collectionView registerClass:[WashCarFiveCollectionViewCell class] forCellWithReuseIdentifier:WashCarFiveCollectionViewCellId];
        
        [_collectionView registerClass:[CommentHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerId];
        
        
    }
    return _collectionView;
}

-(NSMutableArray *)otherOrderArr
{
    if (!_otherOrderArr)
    {
        _otherOrderArr = [NSMutableArray array];
        
    }
    return _otherOrderArr;
}
-(void)postListofWashCarPlaceListWithAccessCode:(NSString*)accessCode
                                withCurrentDate:(NSString*)currentDate
                                withSubjectGuid:(NSString*)subjectGuid
                                   withCallback:(Callback )callback
{
    [AutomaintainAPI postListofWashCarPlaceListWithAccessCode:accessCode withCurrentDate:currentDate withSubjectGuid:subjectGuid withCallback:^(BOOL success, NSError *error, id result)
     {
         if (success)
         {
             
             self.washCarDateListModel = (WashCarDateListModel*)result;

             callback(YES,nil,result);
         }
         else
         {
             callback(NO,nil,result);
         }
     }];
}

#pragma mark - 提交预约
-(void)postAppointmentServiceWithAccessCode:(NSString *)accessCode withAppointmentStartTime:(NSString *)appointmentStartTime withSubjectGuid:(NSString *)subjectGuid withCallback:(Callback)callback
{
    [AutomaintainAPI postAppointmentServiceWithAccessCode:accessCode withAppointmentStartTime:appointmentStartTime withSubjectGuid:subjectGuid withCallback:^(BOOL success, NSError *error, id result)
     {
         if (success)
         {
             
//             self.washCarDateListModel = (WashCarDateListModel*)result;
             
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
