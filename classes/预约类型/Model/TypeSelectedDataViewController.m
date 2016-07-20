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
#import "OrderTypeModel.h"

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
    }
    return _typeSelectedArr;
}

-(NSMutableArray *)beautyServiceArr
{
    if (!_beautyServiceArr)
    {
        _beautyServiceArr = [NSMutableArray array];
    }
    return _beautyServiceArr;
}
-(NSMutableArray *)maintenanceArr
{
    if (!_maintenanceArr)
    {
        _maintenanceArr = [NSMutableArray array];
    }
    return _maintenanceArr;
}
-(void)postOrderTypeListWithAccessCode:(NSString *)accessCode withCallback:(Callback)callback
{
    [AutomaintainAPI postOrderTypeListWithAccessCode:accessCode withCallback:^(BOOL success, NSError *error, id result)
     {
         if (success)
         {
             NSArray* tempModelArr = (NSArray*)result;
             
             for (OrderTypeModel* orderTypeModel in tempModelArr)
             {
                 if ([orderTypeModel.Type isEqualToString:@"美容洗护"])
                 {
                     [self.beautyServiceArr addObject:orderTypeModel];
                 }
                 else if ([orderTypeModel.Type isEqualToString:@"维修保养"])
                 {
                     [self.maintenanceArr addObject:orderTypeModel];
                 }
             }
             [self.typeSelectedArr removeAllObjects];
             [self.typeSelectedArr addObjectsFromArray:self.beautyServiceArr];
             callback(YES,nil,result);
             
         }
         else
         {
             callback(NO,nil,result);
         }
     }];
}
@end
