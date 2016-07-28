//
//  ModifyPasswordView.h
//  automaintain
//
//  Created by eric on 16/7/5.
//  Copyright © 2016年 eric. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ModifyPasswordView;
@protocol ModifyPasswordViewDelegate <NSObject>

@optional
/**
 *  点击提交修改密码按钮
 *
 *  @param oldPassword        旧密码
 *  @param newPassword        新密码
 *  @param confirmPassword    确认密码
 *  @param modifyPasswordView modifyPasswordView
 */
-(void)didClickSubmitButtonWithOldPassword:(NSString*)oldPassword
                           withNewPassword:(NSString*)newPassword
                       withConfirmPassword:(NSString*)confirmPassword
                    withModifyPasswordView:(ModifyPasswordView*)modifyPasswordView;

@end
@interface ModifyPasswordView : UIView

@property (nonatomic, weak) id <ModifyPasswordViewDelegate> delegate;
@end
