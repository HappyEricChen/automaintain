//
//  ModifyPasswordDataViewController.h
//  automaintain
//
//  Created by eric on 16/7/5.
//  Copyright © 2016年 eric. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModifyPasswordView.h"

@interface ModifyPasswordDataViewController : NSObject

@property (nonatomic, strong) CustomNavigationView* customNavigationView;

@property (nonatomic, strong) ModifyPasswordView* modifyPasswordView;

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
                           withCallback:(Callback )callback;
@end
