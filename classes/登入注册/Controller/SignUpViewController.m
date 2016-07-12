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
    self.signUpDataViewController.customNavigationView.translatesAutoresizingMaskIntoConstraints = NO;
    self.signUpDataViewController.customNavigationView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topEqualToView(self.view).heightIs(ScreenHeight*0.1);
    
    
}

-(void)configureSignUpView
{
    [self.view addSubview:self.signUpDataViewController.signUpView];
    self.signUpDataViewController.signUpView.delegate = self;
    self.signUpDataViewController.signUpView.translatesAutoresizingMaskIntoConstraints = NO;
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

-(void)signUpView:(SignUpView *)signUpView withUsername:(NSString *)username withPassword:(NSString *)password withconfirmPassword:(NSString *)confirmPassword withverificationCode:(NSString *)verificationCode
{
    if ([username isEqualToString:@""])
    {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号"];
        return;
    }
    else if ([verificationCode isEqualToString:@""])
    {
        [SVProgressHUD showErrorWithStatus:@"请输入验证码"];
        return;
    }
    else if ([password isEqualToString:@""])
    {
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        return;
    }
    
    
    if (![password isEqualToString:confirmPassword])
    {
        NSLog(@"两个密码不相等");
        /**
         *  显示错误
         */
        [SVProgressHUD showErrorWithStatus:@"两次密码不相同"];
    }
    else
    {
        if ([self.signUpDataViewController.verificationCode isEqualToString:verificationCode])
        {
            if ([self.type isEqualToString:@"立即注册"])
            {
                [self.signUpDataViewController signupWithUsername:username withPassword:password withCallback:^(BOOL success, NSError *error, id result)
                 {
                     if (success)
                     {
                         //注册成功
                         [SVProgressHUD showSuccessWithStatus:@"注册成功"];
                         [self.navigationController popViewControllerAnimated:YES] ;
                         
                     }
                     else
                     {
                         //注册失败
                         [SVProgressHUD showErrorWithStatus:@"注册失败"];
                     }
                 }];
                
            }
            else if ([self.type isEqualToString:@"找回密码"])
            {
                [self.signUpDataViewController changePasswordWithUsername:username withNewPassword:password withCallback:^(BOOL success, NSError *error, id result)
                 {
                     if (success)
                     {
                         //找回密码请求成功
                         [SVProgressHUD showSuccessWithStatus:@"密码修改成功"];
                         [self.navigationController popViewControllerAnimated:YES] ;
                         
                     }
                     else
                     {
                         //找回密码请求失败
                         [SVProgressHUD showErrorWithStatus:@"密码修改失败"];
                     }
                     
                 }];
            }
            
        }
        else
        {
            /**
             *  显示验证码错误
             */
            [SVProgressHUD showErrorWithStatus:@"验证码输入错误"];
        }
    }
}
#pragma mark - 点击获取验证码
-(void)didClickVerificationButtonWithSignUpView:(SignUpView *)signUpView withUsername:(NSString *)username withCallback:(Callback)callback
{
    /**
     *  正则表达式判断是否为正确的手机号
     */
    if ([SignUpViewController isMobile:username])
    {
        __weak SignUpViewController* weakSelf = self;
        [AutomaintainAPI SMSVerificationCodeWithPhoneNum:username withCallback:^(BOOL success, NSError *error, id result)
         {
             if (success)
             {
                 weakSelf.signUpDataViewController.verificationCode = (NSString*)result;
                 [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"验证码是%@",(NSString*)result]];
                 callback(YES,nil,nil);
             }
             else
             {
                 [SVProgressHUD showErrorWithStatus:result];
             }
         }];
        
    }
    else
    {
        /**
         *  请输入正确的手机号
         */
        [SVProgressHUD showInfoWithStatus:@"请输入正确的手机号"];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    }
    
}
#pragma mark - 手机号码验证
/**
 *  手机号码验证
 *
 *  @param mobileNumbel 传入的手机号码
 *
 *  @return 格式正确返回true  错误 返回fals
 */
+ (BOOL) isMobile:(NSString *)mobileNumbel{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189,181(增加)
     */
    NSString * MOBIL = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[2378])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189,181(增加)
     22         */
    NSString * CT = @"^1((33|53|8[019])[0-9]|349)\\d{7}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBIL];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNumbel]
         || [regextestcm evaluateWithObject:mobileNumbel]
         || [regextestct evaluateWithObject:mobileNumbel]
         || [regextestcu evaluateWithObject:mobileNumbel]))
    {
        return YES;
    }
    
    return NO;
}
@end
