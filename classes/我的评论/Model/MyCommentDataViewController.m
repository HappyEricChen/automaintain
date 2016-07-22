//
//  MyCommentDataViewController.m
//  automaintain
//
//  Created by eric on 16/7/1.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "MyCommentDataViewController.h"
#import "MyCommentFirstCollectionViewCell.h"
#import "MyCommentSecondCollectionViewCell.h"
#import "MyCommentThirdCollectionViewCell.h"

@implementation MyCommentDataViewController

-(CustomNavigationView *)customNavigationView
{
    if (!_customNavigationView)
    {
        _customNavigationView = [CustomNavigationView customNavigationViewWithLeftBtnImage:ImageNamed(@"register_back") withRightBtnImage:nil withTitle:@"发布评论"];
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
        
        [_collectionView registerClass:[MyCommentFirstCollectionViewCell class] forCellWithReuseIdentifier:MyCommentFirstCollectionViewCellId];
        [_collectionView registerClass:[MyCommentSecondCollectionViewCell class] forCellWithReuseIdentifier:MyCommentSecondCollectionViewCellId];
        [_collectionView registerClass:[MyCommentThirdCollectionViewCell class] forCellWithReuseIdentifier:MyCommentThirdCollectionViewCellId];        
        
    }
    return _collectionView;
}

/**
 *  提交我的评论/POST 请求
 *
 *  @param accessCode          唯一标识符
 *  @param stars               评论星数
 *  @param ContentText         评论内容
 *  @param maintainSubjectGuid 预约项目guid
 *  @param appointmentGuid     该条预约guid
 *  @param photoGuidList       图片guid数组
 *  @param callback            回调
 */
-(void)postCommentToServiceWithAccessCode:(NSString*)accessCode
                                withStars:(NSString*)stars
                          withContentText:(NSString*)ContentText
                  withMaintainSubjectGuid:(NSString*)maintainSubjectGuid
                      withAppointmentGuid:(NSString*)appointmentGuid
                        withPhotoGuidList:(NSArray*)photoGuidList
                             withCallback:(Callback )callback
{
    [AutomaintainAPI postCommentToServiceWithAccessCode:accessCode
                                              withStars:stars
                                        withContentText:ContentText
                                withMaintainSubjectGuid:maintainSubjectGuid
                                    withAppointmentGuid:appointmentGuid
                                      withPhotoGuidList:photoGuidList
                                           withCallback:^(BOOL success, NSError *error, id result)
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
