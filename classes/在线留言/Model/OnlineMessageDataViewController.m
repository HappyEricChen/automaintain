//
//  OnlineMessageDataViewController.m
//  automaintain
//
//  Created by eric on 16/6/30.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "OnlineMessageDataViewController.h"
#import "OnlineMessageCollectionViewCell.h"
#import "MyMessageSubmitButtonView.h"

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
        
    }
    return _collectionView;
}

-(MyMessageSubmitButtonView *)myMessageSubmitButtonView
{
    if (!_myMessageSubmitButtonView)
    {
        _myMessageSubmitButtonView = [[MyMessageSubmitButtonView alloc]init];
    }
    return _myMessageSubmitButtonView;
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
    
    [AutomaintainAPI postOnlineMessageListWithAccessCode:accessCode
                                           withPageIndex:pageIndex
                                            withCallback:^(BOOL success, NSError *error, id result)
     {
         [self.collectionView.mj_header endRefreshing];
         
         if (success)
         {
             NSArray * tempModelArr = (NSArray*)result;
             if (tempModelArr.count<MESSAGE_PAGE_SIZE.integerValue)
             {
                 [self.collectionView.mj_footer endRefreshingWithNoMoreData];
             }
             else
             {
                 [self.collectionView.mj_footer endRefreshing];
             }
             
             if ([pageIndex isEqualToString:@"0"])
             {
                 [self.onlineMessageModelArr removeAllObjects];
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

@end
