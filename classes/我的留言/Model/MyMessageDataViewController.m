//
//  MyMessageDataViewController.m
//  一号车库
//
//  Created by eric on 16/8/8.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "MyMessageDataViewController.h"
#import "MyMessageView.h"

@implementation MyMessageDataViewController

-(CustomNavigationView *)customNavigationView
{
    if (!_customNavigationView)
    {
        _customNavigationView = [CustomNavigationView customNavigationViewWithLeftBtnImage:ImageNamed(@"register_back")  withRightBtnImage:nil withTitle:@"在线留言"];
    }
    return _customNavigationView;
}

-(UIView *)myMessageView
{
    if (!_myMessageView)
    {
        _myMessageView = [[MyMessageView alloc]init];
    }
    return _myMessageView;
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
