//
//  ModifyPasswordDataViewController.m
//  automaintain
//
//  Created by eric on 16/7/5.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "ModifyPasswordDataViewController.h"

@implementation ModifyPasswordDataViewController

-(CustomNavigationView *)customNavigationView
{
    if (!_customNavigationView)
    {

        _customNavigationView = [CustomNavigationView customNavigationViewWithLeftBtnImage:ImageNamed(@"register_back") withRightBtnImage:nil withTitle:@"修改密码"];

    }
    return _customNavigationView;
}

-(ModifyPasswordView *)modifyPasswordView
{
    if (!_modifyPasswordView)
    {
        _modifyPasswordView = [[ModifyPasswordView alloc]init];
    }
    return _modifyPasswordView;
}
#pragma mark - 修改密码/POST 请求
/**
 *
 *  修改密码/POST请求
 *
 *  @param accessCode  唯一标识符
 *  @param OldPassword 旧密码
 *  @param NewPassword 新密码
 *  @param callback    回调
 */
-(void)postChangePasswordWithAccessCode:(NSString*)accessCode
                        withOldPassword:(NSString*)OldPassword
                        withNewPassword:(NSString*)NewPassword
                           withCallback:(Callback )callback
{
    [AutomaintainAPI postChangePasswordWithAccessCode:accessCode
                                      withOldPassword:OldPassword
                                      withNewPassword:NewPassword
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
