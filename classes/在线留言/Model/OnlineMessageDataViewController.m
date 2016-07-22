//
//  OnlineMessageDataViewController.m
//  automaintain
//
//  Created by eric on 16/6/30.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "OnlineMessageDataViewController.h"
#import "OnlineMessageCollectionViewCell.h"
#import "OnlineMessageSecondCollectionViewCell.h"
#import "MyMessageView.h"

@implementation OnlineMessageDataViewController

-(CustomNavigationView *)customNavigationView
{
    if (!_customNavigationView)
    {
        _customNavigationView = [CustomNavigationView customNavigationViewWithLeftBtnImage:ImageNamed(@"register_back")  withRightBtnImage:nil withTitle:@"在线留言"];
    }
    return _customNavigationView;
}

-(UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = UIColorFromRGB(0xf4f4f4);
        
        [_collectionView registerClass:[OnlineMessageCollectionViewCell class] forCellWithReuseIdentifier:OnlineMessageCollectionViewCellId];
        [_collectionView registerClass:[OnlineMessageSecondCollectionViewCell class] forCellWithReuseIdentifier:OnlineMessageSecondCollectionViewCellId];
        
    }
    return _collectionView;
}

-(UIView *)myMessageView
{
    if (!_myMessageView)
    {
        _myMessageView = [[MyMessageView alloc]init];
    }
    return _myMessageView;
}
-(NSMutableArray *)onlineMessageModelArr
{
    if (!_onlineMessageModelArr)
    {
        _onlineMessageModelArr = [NSMutableArray array];
    }
    return _onlineMessageModelArr;
}

/**
 *  获取在线留言列表
 */
-(void)postOnlineMessageListWithAccessCode:(NSString *)accessCode
                             withPageIndex:(NSString *)pageIndex
                              withCallback:(Callback)callback
{
    if ([pageIndex isEqualToString:@"0"])
    {
        [self.onlineMessageModelArr removeAllObjects];
    }
    else
    {
        
    }
    
    
    [AutomaintainAPI postOnlineMessageListWithAccessCode:accessCode
                                           withPageIndex:pageIndex
                                            withCallback:^(BOOL success, NSError *error, id result)
     {
         if (success)
         {
             NSArray * tempModelArr = (NSArray*)result;
             if (tempModelArr.count<10)
             {
                 [self.collectionView.mj_footer endRefreshingWithNoMoreData];
             }
             
             
             [self.onlineMessageModelArr addObjectsFromArray:tempModelArr];
             [self.collectionView reloadData];
             callback(YES,nil,result);
         }
         else
         {
             callback(NO,nil,result);
         }
     }];
    
}
#pragma mark - 提交我的留言

-(void)postMessageToServiceWithAccessCode:(NSString*)accessCode
                       withCommentContent:(NSString*)commentContent
                             withCallback:(Callback )callback
{
    [AutomaintainAPI postMessageToServiceWithAccessCode:accessCode
                                     withCommentContent:commentContent
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
