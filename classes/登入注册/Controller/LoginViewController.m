
//
//  LoginViewController.m
//  automaintain
//
//  Created by eric on 16/6/22.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginDataViewController.h"
#import "SignUpViewController.h"
#import "HomeViewController.h"
#import "LoginModel.h"

@interface LoginViewController ()<LoginViewDelegate,UITextFieldDelegate>

@property (nonatomic, strong) LoginDataViewController* loginDataViewController;
@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    [self checkInUsernamePasswordFromKeyChain];
    self.loginDataViewController = [[LoginDataViewController alloc]init];
    [self configureLoginView];
    self.navigationController.navigationBarHidden = YES;
    
}

-(void)checkInUsernamePasswordFromKeyChain
{
    // B、从keychain中读取用户名和密码
    if (AppManagerSingleton.accessCode)
    {
        [self.navigationController pushViewController:SharedAppDelegateHelper.homeViewController animated:NO];
    }
}


-(void)configureLoginView
{

    LoginView * loginView = self.loginDataViewController.loginView;
    loginView.delegate = self;
    UIImageView * imageView = [[UIImageView alloc]initWithImage:ImageNamed(@"login_logo")];
    imageView.frame = [[UIScreen mainScreen] bounds];
    [loginView insertSubview:imageView atIndex:0];
    [self.view addSubview:loginView];
    loginView.sd_layout.leftEqualToView(self.view).topEqualToView(self.view).rightEqualToView(self.view).bottomEqualToView(self.view);
}

#pragma mark - LoginViewDelegate代理方法
-(void)didSelectedSiginUpButton
{
    SignUpViewController* signUpViewController = [[SignUpViewController alloc]init];
    signUpViewController.type = @"立即注册";
    [self.navigationController pushViewController:signUpViewController animated:YES];
}

-(void)didSelectedForgetPasswordButton
{
    SignUpViewController* signUpViewController = [[SignUpViewController alloc]init];
    signUpViewController.type = @"提交";
    [self.navigationController pushViewController:signUpViewController animated:YES];
}

-(void)pressesBegan:(NSSet<UIPress *> *)presses withEvent:(UIPressesEvent *)event
{
    [self.loginDataViewController.loginView resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    __weak LoginViewController* weakSelf = self;
    /**
     ios7 后动画效果
     */
    [UIView animateWithDuration:1.0//动画时长
                          delay:0.0//动画延迟
         usingSpringWithDamping:0.5//弹簧效果0~1
          initialSpringVelocity:5.0//初始速度
                        options:UIViewAnimationOptionCurveEaseInOut//动画过渡效果
                     animations:^{
                         CGRect temp = self.loginDataViewController.loginView.frame;
                         temp.origin.y = 0;
                         weakSelf.loginDataViewController.loginView.frame = temp;
                         
                     } completion:^(BOOL finished) {
                         
                     }];
}


#pragma mark - 点击登入按钮调用方法
-(void)didSelectedLoginButtonWithLoginView:(LoginView *)loginView withUsername:(NSString *)username withPassword:(NSString *)password
{
    if ([username isEqualToString:@""])
    {
        [SVProgressHUD showInfoWithStatus:@"请输入正确的手机号"];
        return;
    }
    else if ([password isEqualToString:@""])
    {
        [SVProgressHUD showInfoWithStatus:@"请输入密码"];
        return;
    }
    else if (![AppManagerSingleton isMobile:username])
    {
        [SVProgressHUD showInfoWithStatus:@"请输入正确的手机号"];
        return;
    }
    else if (password.length<6 || password.length>12)
    {
        [SVProgressHUD showInfoWithStatus:@"密码控制在6-12位"];
        return;
    }
    
    
    [SVProgressHUD show];
    [self.loginDataViewController loginWithUsername:username withpassword:password withCallback:^(BOOL success, NSError *error, id result)
     {
         if (success)
         {
             [SVProgressHUD dismiss];
             //登录成功
             [self.navigationController pushViewController:SharedAppDelegateHelper.homeViewController animated:YES];
             /**
              *  清除账号密码
              */
             [loginView clearTextField];
         }
         else
         {
             //登录请求失败
             [SVProgressHUD showInfoWithStatus:result];
             
         }
         
     }];
    
}
@end
