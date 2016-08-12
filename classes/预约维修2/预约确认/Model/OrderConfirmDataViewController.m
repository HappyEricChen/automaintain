//
//  OrderConfirmDataViewController.m
//  一号车库
//
//  Created by eric on 16/8/11.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "OrderConfirmDataViewController.h"
#import "OrderConfirmView.h"
@implementation OrderConfirmDataViewController

-(CustomNavigationView *)customNavigationView
{
    if (!_customNavigationView)
    {
        _customNavigationView = [CustomNavigationView customNavigationViewWithLeftBtnImage:ImageNamed(@"register_back")  withRightBtnImage:nil withTitle:@"预约确认"];
    }
    return _customNavigationView;
}

-(OrderConfirmView *)orderConfirmView
{
    if (!_orderConfirmView)
    {
        _orderConfirmView = [[OrderConfirmView alloc]init];
    }
    return _orderConfirmView;
}

#pragma mark - 提交预约
-(void)postAppointmentServiceWithAccessCode:(NSString *)accessCode
                   withAppointmentStartTime:(NSString *)appointmentStartTime
                            withSubjectGuid:(NSString *)subjectGuid
                                   withNote:(NSString *)note
                               withCallback:(Callback)callback
{
    [AutomaintainAPI postAppointmentServiceWithAccessCode:accessCode
                                 withAppointmentStartTime:appointmentStartTime
                                          withSubjectGuid:subjectGuid
                                                 withNote:note
                                             withCallback:^(BOOL success, NSError *error, id result)
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
@end
