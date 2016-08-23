//
//  MyOrderDataViewController.m
//  automaintain
//
//  Created by eric on 16/6/30.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "MyOrderDataViewController.h"
#import "MyOrderTableViewCell.h"

@implementation MyOrderDataViewController

-(CustomNavigationView *)customNavigationView
{
    if (!_customNavigationView)
    {
        _customNavigationView = [CustomNavigationView customNavigationViewWithLeftBtnImage:ImageNamed(@"register_back")  withRightBtnImage:nil withTitle:@"我的预约"];
    }
    return _customNavigationView;
}

-(UITableView *)customTableView
{
    if (!_customTableView)
    {
        _customTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _customTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _customTableView.allowsSelection = NO;
        [_customTableView registerClass:[MyOrderTableViewCell class] forCellReuseIdentifier:MyOrderTableViewCellId];
    }
    return _customTableView;
}

-(NSMutableArray *)myOrderModelArr
{
    if (!_myOrderModelArr)
    {
        _myOrderModelArr = [NSMutableArray array];
    }
    return _myOrderModelArr;
}
/**
 *    我的预约列表/POST 请求
 */
-(void)postMyOrderListWithAccessCode:(NSString *)accessCode
                       withPageIndex:(NSString*)pageIndex
                        withCallback:(Callback)callback
{
 
    [AutomaintainAPI postMyOrderListWithAccessCode:accessCode withPageIndex:pageIndex withCallback:^(BOOL success, NSError *error, id result)
     {
         [self.customTableView.mj_header endRefreshing];
         if (success)
         {
             callback(YES,nil,result);
             NSArray * tempModelArr = (NSArray*)result;
             if (tempModelArr.count<PAGE_SIZE.integerValue)
             {
                 [self.customTableView.mj_footer endRefreshingWithNoMoreData];
             }
             else
             {
                 [self.customTableView.mj_footer endRefreshing];
             }
             
             /**
              *  上拉刷新清除数组
              */
             if ([pageIndex isEqualToString:@"0"])
             {
                 [self.myOrderModelArr removeAllObjects];
             }
             
             [self.myOrderModelArr addObjectsFromArray:tempModelArr];
             [self.customTableView reloadData];
         }
         else
         {
             callback(NO,nil,result);
         }
     }];
}
/**
 *    取消预约
 */
-(void)postCancelOrderWithAccessCode:(NSString *)accessCode withAppointmentGuid:(NSString *)appointmentGuid withCallback:(Callback)callback
{
    [AutomaintainAPI postCancelOrderWithAccessCode:accessCode withAppointmentGuid:appointmentGuid withCallback:^(BOOL success, NSError *error, id result)
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
