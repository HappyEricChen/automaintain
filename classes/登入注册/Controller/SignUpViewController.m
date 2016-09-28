//
//  SiginUpViewController.m
//  automaintain
//
//  Created by eric on 16/6/24.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "SignUpViewController.h"
#import "SignUpView.h"
#import "SignUpDataViewController.h"

@interface SignUpViewController ()<CustomNavigationViewDelegate,SignUpViewDelegate>
@property (nonatomic, strong) SignUpDataViewController* signUpDataViewController;
/**
 *  区分是注册还是找回密码
 */
@property (nonatomic, strong) NSString* IsExisted;
@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.signUpDataViewController = [[SignUpDataViewController alloc]initWithType:self.type];
    self.view.backgroundColor = [UIColor colorWithPatternImage:ImageNamed(@"register_bg")];
    [self configureNavigationView];
    [self configureSignUpView];
    
}

-(void)configureNavigationView
{
    [self.view addSubview:self.signUpDataViewController.customNavigationView];
    self.signUpDataViewController.customNavigationView.delegate = self;
    self.signUpDataViewController.customNavigationView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topEqualToView(self.view).heightIs(ScreenHeight*0.1);
    
    
}

-(void)configureSignUpView
{
    [self.view addSubview:self.signUpDataViewController.signUpView];
    self.signUpDataViewController.signUpView.delegate = self;
    self.signUpDataViewController.signUpView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topSpaceToView(self.signUpDataViewController.customNavigationView,0).bottomEqualToView(self.view);
    
    
}

-(void)didSelectedLeftButtonAtCustomNavigationView:(CustomNavigationView *)customNavigationView
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - SignUpViewDelegate

-(void)signUpView:(SignUpView *)signUpView
     withUsername:(NSString *)username
     withPassword:(NSString *)password
withconfirmPassword:(NSString *)confirmPassword
withverificationCode:(NSString *)verificationCode
{
    if ([username isEqualToString:@""])
    {
        [SVProgressHUD showInfoWithStatus:@"请输入手机号"];
        return;
    }
    else if ([verificationCode isEqualToString:@""])
    {
        [SVProgressHUD showInfoWithStatus:@"请输入验证码"];
        return;
    }
    else if ([password isEqualToString:@""])
    {
        [SVProgressHUD showInfoWithStatus:@"请输入密码"];
        return;
    }
    else if ([confirmPassword isEqualToString:@""])
    {
        [SVProgressHUD showInfoWithStatus:@"请再次输入密码"];
        return;
    }
    else if (password.length<6 || password.length>12)
    {
        [SVProgressHUD showInfoWithStatus:@"密码控制在6-12位"];
        return;
    }
    
    if (![self.IsExisted isEqualToString:TRUE_VALIDATION])
    {
        /**
         *  注册时，验证码的确认
         */
        if ([AppManagerSingleton.verificationCode isEqualToString:verificationCode] && ![AppManagerSingleton.phoneNumber isEqualToString:username])
        {
            [SVProgressHUD showInfoWithStatus:@"验证码不匹配"];
            return;
        }
        else if (![AppManagerSingleton.verificationCode isEqualToString:verificationCode])
        {
            [SVProgressHUD showInfoWithStatus:@"验证码不匹配"];
            return;
        }
        
    }
    else
    {
        /**
         *  找回密码，验证码的确认
         */
        if ([AppManagerSingleton.verificationCode1 isEqualToString:verificationCode] && ![AppManagerSingleton.phoneNumber1 isEqualToString:username])
        {
            [SVProgressHUD showInfoWithStatus:@"验证码不匹配"];
            return;
        }
        else if (![AppManagerSingleton.verificationCode1 isEqualToString:verificationCode])
        {
            [SVProgressHUD showInfoWithStatus:@"验证码不匹配"];
            return;
        }
        
    }
    
    if (![password isEqualToString:confirmPassword])
    {
        NSLog(@"两个密码不相等");
        /**
         *  显示错误
         */
        [SVProgressHUD showInfoWithStatus:@"两次密码不相同"];
    }
    else
    {
     
            if ([self.type isEqualToString:@"立即注册"])
            {
                [SVProgressHUD show];
                [self.signUpDataViewController signupWithUsername:username withPassword:password withCallback:^(BOOL success, NSError *error, id result)
                 {
                     [SVProgressHUD dismiss];
                     if (success)
                     {
                         //注册成功
                         [SVProgressHUD showSuccessWithStatus:@"注册成功"];
                         [self.navigationController pushViewController:SharedAppDelegateHelper.homeViewController animated:YES];
                         /**
                          *  清空验证码和注册手机号
                          */
                         AppManagerSingleton.verificationCode = @"";
                         AppManagerSingleton.phoneNumber = @"";
                     }
                     else
                     {
                         //注册失败
                         [SVProgressHUD showInfoWithStatus:result];
                     }
                 }];
                
            }
            else if ([self.type isEqualToString:@"提交"])
            {
                [SVProgressHUD show];
                [self.signUpDataViewController changePasswordWithUsername:username withNewPassword:password withCallback:^(BOOL success, NSError *error, id result)
                 {
                     if (success)
                     {
                         //找回密码请求成功
                         [SVProgressHUD showSuccessWithStatus:@"密码修改成功"];
                         [self.navigationController popViewControllerAnimated:YES] ;
                         /**
                          *  清空验证码和手机号
                          */
                         AppManagerSingleton.verificationCode1 = @"";
                         AppManagerSingleton.phoneNumber1 = @"";
                         
                     }
                     else
                     {
                         //找回密码请求失败
                         [SVProgressHUD showInfoWithStatus:result];
                     }
                     
                 }];
            }
        
    }
}
#pragma mark - 点击获取验证码
-(void)didClickVerificationButtonWithSignUpView:(SignUpView *)signUpView
                                   withUsername:(NSString *)username
                                  withIsExisted:(NSString*)IsExisted
                                   withCallback:(Callback)callback
{
    [SVProgressHUD show];
    [AutomaintainAPI SMSVerificationCodeWithPhoneNum:username withIsExisted:IsExisted withCallback:^(BOOL success, NSError *error, id result)
     {
         if (success)
         {
             
             self.IsExisted = IsExisted;
             /**
              *  ture为找回密码，accessCode存在才可以找回密码
              */
             if ([IsExisted isEqualToString:TRUE_VALIDATION])
             {
                 AppManagerSingleton.verificationCode1 = (NSString*)result;
                 AppManagerSingleton.phoneNumber1 = username;
             }
             else
             {
                 AppManagerSingleton.verificationCode = (NSString*)result;
                 AppManagerSingleton.phoneNumber = username;
             }
             
             [SVProgressHUD showSuccessWithStatus:@"验证码已发送"];
             callback(YES,nil,nil);
         }
         else
         {
             [SVProgressHUD dismiss];
             callback(NO,nil,result);
         }
     }];
    
}

@end
