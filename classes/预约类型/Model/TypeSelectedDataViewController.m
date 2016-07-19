//
//  TypeSelectedDataViewController.m
//  automaintain
//
//  Created by eric on 16/6/29.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "TypeSelectedDataViewController.h"
#import "TypeSelectedView.h"
#import "CustomTypeSelectedTableViewCell.h"

@implementation TypeSelectedDataViewController

-(CustomNavigationView *)customNavigationView
{
    if (!_customNavigationView)
    {
        _customNavigationView = [CustomNavigationView customNavigationViewWithLeftBtnImage:ImageNamed(@"register_back")  withRightBtnImage:nil withTitle:@"预约类型"];
    }
    return _customNavigationView;
}

-(TypeSelectedView *)typeSelectedView
{
    if (!_typeSelectedView)
    {
        _typeSelectedView = [[TypeSelectedView alloc]init];
    }
    return _typeSelectedView;
}

-(UITableView *)customTableView
{
    if (!_customTableView)
    {
        _customTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _customTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _customTableView.allowsSelection = NO;
        [_customTableView registerClass:[CustomTypeSelectedTableViewCell class] forCellReuseIdentifier:CustomTypeSelectedTableViewCellId];
    }
    return _customTableView;
}

-(NSMutableArray *)typeSelectedArr
{
    if (!_typeSelectedArr)
    {
        _typeSelectedArr = [NSMutableArray array];
        [_typeSelectedArr addObjectsFromArray: @[@{@"name":@"全车打蜡",@"content":@"SONAX蜡; 施工约60分钟; 洗车+机器打蜡",@"price":@"￥588"}]];
    }
    return _typeSelectedArr;
}

-(void)postOrderTypeListWithAccessCode:(NSString *)accessCode withCallback:(Callback)callback
{
    [AutomaintainAPI postOrderTypeListWithAccessCode:accessCode withCallback:^(BOOL success, NSError *error, id result)
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
