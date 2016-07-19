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

-(void)postMyOrderListWithAccessCode:(NSString *)accessCode
                       withPageIndex:(NSString*)pageIndex
                        withCallback:(Callback)callback
{
    [AutomaintainAPI postMyOrderListWithAccessCode:accessCode withPageIndex:pageIndex withCallback:^(BOOL success, NSError *error, id result)
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
