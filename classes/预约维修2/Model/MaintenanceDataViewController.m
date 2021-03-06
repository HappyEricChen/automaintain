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
        _customNavigationView = [CustomNavigationView customNavigationViewWithLeftBtnImage:ImageNamed(@"register_back")  withRightBtnImage:nil withTitle:@"美容维修"];
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

-(NSMutableArray *)userCommentModelArr
{
    if (!_userCommentModelArr)
    {
        _userCommentModelArr = [NSMutableArray array];
    }
    return _userCommentModelArr;
}

-(UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.showsVerticalScrollIndicator = NO;
        
        [_collectionView registerClass:[WashCarFiveCollectionViewCell class] forCellWithReuseIdentifier:WashCarFiveCollectionViewCellId];
        
        [_collectionView registerClass:[CommentHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerId];
    }
    return _collectionView;
}

#pragma mark - 获取预约的评论列表
/**
 *   获取预约的评论列表/POST 请求
 *
 *  @param accessCode   唯一标识
 *  @param pageIndex   页数
 *  @param appointmentGuid 预约类型/洗车或者维修编号
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
                 
                 if ([pageIndex isEqualToString:@"0"])
                 {
                     [self.userCommentModelArr removeAllObjects];
                 }
                 
                 NSArray * tempModelArr = (NSArray*)result;
                 [self.userCommentModelArr addObjectsFromArray:tempModelArr];
                 
                 if (tempModelArr.count<COMMENT_PAGE_SIZE.integerValue)
                 {
                     [self.collectionView.mj_footer endRefreshingWithNoMoreData];
                 }
                 else
                 {
                     [self.collectionView.mj_footer endRefreshing];
                 }
                 
                 
                 dispatch_async(dispatch_get_main_queue(), ^{
                     
                     [self.collectionView reloadData];
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
