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
        _collectionView.showsVerticalScrollIndicator = NO;
        
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

-(NSMutableArray *)userCommentModelArr
{
    if (!_userCommentModelArr)
    {
        _userCommentModelArr = [NSMutableArray array];
    }
    return _userCommentModelArr;
}
#pragma mark - 获取预约的时间列表
-(void)postListofWashCarPlaceListWithAccessCode:(NSString*)accessCode
                                withCurrentDate:(NSString*)currentDate
                                withSubjectGuid:(NSString*)subjectGuid
                                   withCallback:(Callback )callback
{
    [AutomaintainAPI postListofWashCarPlaceListWithAccessCode:accessCode
                                              withCurrentDate:currentDate
                                              withSubjectGuid:subjectGuid
                                                 withCallback:^(BOOL success, NSError *error, id result)
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

#pragma mark - 获取预约的评论列表
/**
 *   获取预约的评论列表/POST 请求
 *
 *  @param accessCode   唯一标识
 *  @param pageIndex   页数
 *  @param callback    回调
 */
-(void)postCommentListWithAccessCode:(NSString*)accessCode
                       withPageIndex:(NSString*)pageIndex
                        withCallback:(Callback )callback
{
    
    [AutomaintainAPI postCommentListWithAccessCode:accessCode withPageIndex:pageIndex withCallback:^(BOOL success, NSError *error, id result)
     {
         [self.collectionView.mj_header endRefreshing];
         if (success)
         {
             dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                 
                 NSArray * tempModelArr = (NSArray*)result;
                 
                 if ([pageIndex isEqualToString:@"0"])
                 {
                     [self.userCommentModelArr removeAllObjects];
                     [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
                 }
                 [self.userCommentModelArr addObjectsFromArray:tempModelArr];
                 
                 dispatch_async(dispatch_get_main_queue(), ^{
                     /**
                      *  刷新index=4的那个section
                      */
//                     [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:4]];
                     [self.collectionView reloadData];
                     
                     if (tempModelArr.count<COMMENT_PAGE_SIZE.integerValue)
                     {
                         [self.collectionView.mj_footer endRefreshingWithNoMoreData];
                     }
                     else
                     {
                         [self.collectionView.mj_footer endRefreshing];
                     }
                     callback(YES,nil,result);
                 });
                 
             });
             
         }
         else
         {
             callback(NO,nil,result);
         }
     }];
}
@end
