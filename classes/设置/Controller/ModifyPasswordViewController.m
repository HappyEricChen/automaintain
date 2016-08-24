//
//  ModifyPasswordViewController.m
//  automaintain
//
//  Created by eric on 16/7/5.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "ModifyPasswordViewController.h"
#import "ModifyPasswordDataViewController.h"

@interface ModifyPasswordViewController ()<CustomNavigationViewDelegate,ModifyPasswordViewDelegate>

@property (nonatomic, strong) ModifyPasswordDataViewController* modifyPasswordDataViewController;
@end

@implementation ModifyPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.modifyPasswordDataViewController = [[ModifyPasswordDataViewController alloc]init];
    //    self.view.backgroundColor = [UIColor colorWithPatternImage:ImageNamed(@"register_bg")];
    [self configureNavigationView];
        [self configureModifyPasswordView];
}

-(void)configureNavigationView
{
    [self.view addSubview:self.modifyPasswordDataViewController.customNavigationView];
    self.modifyPasswordDataViewController.customNavigationView.delegate = self;
    self.modifyPasswordDataViewController.customNavigationView.translatesAutoresizingMaskIntoConstraints = NO;
    self.modifyPasswordDataViewController.customNavigationView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topEqualToView(self.view).heightIs(ScreenHeight*0.1);
    
}


-(void)configureModifyPasswordView
{
    [self.view addSubview:self.modifyPasswordDataViewController.modifyPasswordView];
    self.modifyPasswordDataViewController.modifyPasswordView.delegate = self;
    self.modifyPasswordDataViewController.modifyPasswordView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topSpaceToView(self.modifyPasswordDataViewController.customNavigationView,0).bottomEqualToView(self.view);
}


-(void)didSelectedLeftButtonAtCustomNavigationView:(CustomNavigationView *)customNavigationView
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 点击提交修改密码按钮调用
-(void)didClickSubmitButtonWithOldPassword:(NSString *)oldPassword
                           withNewPassword:(NSString *)newPassword
                       withConfirmPassword:(NSString *)confirmPassword
                    withModifyPasswordView:(ModifyPasswordView *)modifyPasswordView
{
    if ([oldPassword isEqualToString:@""])
    {
        [SVProgressHUD showInfoWithStatus:@"请输入原密码"];
        return;
    }
    else if ([newPassword isEqualToString:@""])
    {
        [SVProgressHUD showInfoWithStatus:@"请输入新密码"];
        return;
    }
    else if ([confirmPassword isEqualToString:@""])
    {
        [SVProgressHUD showInfoWithStatus:@"请再次输入新密码"];
        return;
    }
    else if ([newPassword isEqualToString:oldPassword])
    {
        [SVProgressHUD showInfoWithStatus:@"新旧密码不能一样"];
        return;
    }
    else if (oldPassword.length<6 || oldPassword.length>12)
    {
        [SVProgressHUD showInfoWithStatus:@"原密码控制在6-12位"];
        return;
    }
    else if (newPassword.length<6 || newPassword.length>12)
    {
        [SVProgressHUD showInfoWithStatus:@"新密码控制在6-12位"];
        return;
    }
    
    
    if (![newPassword isEqualToString:confirmPassword])
    {
        NSLog(@"两个密码不相等");
        /**
         *  显示错误
         */
        [SVProgressHUD showInfoWithStatus:@"两次密码不相同"];
    }
    else
    {
        [self.modifyPasswordDataViewController postChangePasswordWithAccessCode:AppManagerSingleton.accessCode
                                                                withOldPassword:oldPassword
                                                                withNewPassword:newPassword
                                                                   withCallback:^(BOOL success, NSError *error, id result)
         {
             if (success)
             {
                 [SVProgressHUD showSuccessWithStatus:@"密码修改成功"];
                 /**
                  *  移除plist里面的数据
                  */
                 [AppManagerSingleton removeDataFromPlist];
                 [self.navigationController popToViewController:SharedAppDelegateHelper.loginViewController animated:YES];
                 
             }
             else
             {
                 [SVProgressHUD showInfoWithStatus:result];
             }
         }];
    }
    
    
}
@end
