//
//  LoginViewController.m
//  automaintain
//
//  Created by eric on 16/6/22.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginDataViewController.h"
#import "LoginView.h"
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
   
    self.loginDataViewController = [[LoginDataViewController alloc]init];
    [self configureLoginView];
    self.navigationController.navigationBarHidden = YES;
    
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
    signUpViewController.type = @"找回密码";
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
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号"];
        return;
    }
    else if ([password isEqualToString:@""])
    {
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        return;
    }
    
    [SVProgressHUD show];
    [self.loginDataViewController loginWithUsername:username withpassword:password withCallback:^(BOOL success, NSError *error, id result)
     {
         if (success)
         {
             [SVProgressHUD dismiss];
             //登录成功
             LoginModel* loginModel = (LoginModel*)result;
             
             HomeViewController * homeViewController = [[HomeViewController alloc]init];
             
             homeViewController.accessCode = loginModel.AccessCode;
             [[NSUserDefaults standardUserDefaults]setObject:loginModel.AccessCode forKey:@"accessCode"];//存到plist里面
             [self.navigationController pushViewController:homeViewController animated:YES];
             
         }
         else
         {
             //登录请求失败
             [SVProgressHUD showErrorWithStatus:result];
             
         }
         
     }];
    
}
@end
