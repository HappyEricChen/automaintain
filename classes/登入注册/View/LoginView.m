//
//  LoginView.m
//  automaintain
//
//  Created by eric on 16/6/23.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "LoginView.h"
#import "LoginTextField.h"
@interface LoginView()<LoginTextFieldDelegate>
@property (nonatomic, weak) UIView* baseView;

@property (nonatomic, weak) LoginTextField* accountField;//用户名

@property (nonatomic, weak) LoginTextField* passwordField;//密码
@end
@implementation LoginView

static CGFloat baseViewY = 0;

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        /**
         欢迎来到一号车库文字
         */
        UIImageView* imageView1 = [[UIImageView alloc]initWithImage:ImageNamed(@"welcome_chinese")];
        imageView1.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:imageView1];
        
        /**
         welcome-to-No.1-garage
         */
        UIImageView* imageView2 = [[UIImageView alloc]initWithImage:ImageNamed(@"welcome-to-No.1-garage")];
        imageView2.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:imageView2];
        
        /**
             baseview 包含帐号密码框和登入按钮
         */
        UIView * baseView = [[UIView alloc]init];
        baseViewY = ScreenHeight*0.55;
        baseView.frame = CGRectMake(ScreenWidth*0.117, baseViewY, ScreenWidth*0.765, ScreenHeight*0.449);
        [self addSubview:baseView];
        self.baseView = baseView;
        /**
         账号输入框
         */
        LoginTextField *accountField = [[LoginTextField alloc]initWithImage:ImageNamed(@"login_phone")
                                                            withPlaceHolder:@"请输入手机号码"
                                                                   withType:@"account"];
    
        accountField.delegate = self;
        accountField.translatesAutoresizingMaskIntoConstraints = NO;
        [baseView addSubview:accountField];
        self.accountField = accountField;
        
        
        /**
         密码输入框
         */
        LoginTextField *passwordField = [[LoginTextField alloc]initWithImage:ImageNamed(@"login_psw")
                                                            withPlaceHolder:@"请输入密码"
                                                                   withType:@"password"];
        passwordField.delegate = self;
        passwordField.translatesAutoresizingMaskIntoConstraints = NO;
        [baseView addSubview:passwordField];
        self.passwordField = passwordField;
        /**
         登入按钮
         */
        UIButton * loginButton = [[UIButton alloc]init];
        [loginButton setBackgroundImage:ImageNamed(@"login_k2") forState:UIControlStateNormal];
        [loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [loginButton addTarget:self action:@selector(clickLoginButton) forControlEvents:UIControlEventTouchUpInside];
        loginButton.translatesAutoresizingMaskIntoConstraints = NO;
        [baseView addSubview:loginButton];
        /**
         注册按钮
         */
        UIButton * signupButton = [[UIButton alloc]init];
        signupButton.backgroundColor = [UIColor clearColor];
        [signupButton setTitle:@"还没有账号？  立即注册" forState:UIControlStateNormal];
        signupButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [signupButton setTitleColor:UIColorFromRGB(0xcec8fb) forState:UIControlStateNormal];
        signupButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [signupButton addTarget:self action:@selector(clickSignupButton) forControlEvents:UIControlEventTouchUpInside];
        signupButton.translatesAutoresizingMaskIntoConstraints = NO;
        [baseView addSubview:signupButton];
        /**
         忘记密码按钮
         */
        UIButton * forgetPasswordButton = [[UIButton alloc]init];
        forgetPasswordButton.backgroundColor = [UIColor clearColor];
        [forgetPasswordButton setTitle:@"忘记密码" forState:UIControlStateNormal];
        [forgetPasswordButton setTitleColor:UIColorFromRGB(0xcec8fb) forState:UIControlStateNormal];
        forgetPasswordButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        forgetPasswordButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [forgetPasswordButton addTarget:self action:@selector(clickForgetPasswordButton) forControlEvents:UIControlEventTouchUpInside];
        forgetPasswordButton.translatesAutoresizingMaskIntoConstraints = NO;
        [baseView addSubview:forgetPasswordButton];
        
        imageView1.sd_layout.centerXEqualToView(self).topSpaceToView(self,ScreenHeight*0.115).widthIs(ScreenWidth*0.65).heightIs(ScreenHeight*0.045);
        imageView2.sd_layout.centerXEqualToView(self).topSpaceToView(imageView1,ScreenHeight*0.037).widthIs(ScreenWidth*0.544).heightIs(ScreenHeight*0.025);
        accountField.sd_layout.leftEqualToView(baseView).topEqualToView(baseView).rightEqualToView(baseView).heightIs(ScreenHeight*0.0697);
        passwordField.sd_layout.leftEqualToView(baseView).topSpaceToView(accountField,ScreenHeight*0.018).rightEqualToView(baseView).heightIs(ScreenHeight*0.0697);
        loginButton.sd_layout.leftEqualToView(baseView).topSpaceToView(passwordField,ScreenHeight*0.024).rightEqualToView(baseView).heightIs(ScreenHeight*0.0697);
        signupButton.sd_layout.leftEqualToView(baseView).bottomSpaceToView(baseView,ScreenHeight*0.45*0.1).widthIs(ScreenWidth*0.4).heightIs(ScreenHeight*0.0697);
        forgetPasswordButton.sd_layout.rightEqualToView(baseView).bottomSpaceToView(baseView,ScreenHeight*0.45*0.1).widthIs(ScreenWidth*0.267).heightIs(ScreenHeight*0.0697);
        
    }
    return self;
}

#pragma mark - 登录按钮点击
-(void)clickLoginButton
{
    if ([self.delegate respondsToSelector:@selector(didSelectedLoginButtonWithLoginView:withUsername:withPassword:)])
    {
        [self.delegate didSelectedLoginButtonWithLoginView:self withUsername:self.accountField.textField.text withPassword:self.passwordField.textField.text];
    }
}

-(void)clickSignupButton
{
    if ([self.delegate respondsToSelector:@selector(didSelectedSiginUpButton)])
    {
        [self.delegate didSelectedSiginUpButton];
    }
}

-(void)clickForgetPasswordButton
{
    if ([self.delegate respondsToSelector:@selector(didSelectedForgetPasswordButton)])
    {
        [self.delegate didSelectedForgetPasswordButton];
    }
}
#pragma mark - LoginTextFieldDelegate
-(void)didClickTextFieldWithLoginTextField:(LoginTextField *)loginTextField
{
    /**
     ios7 后动画效果
     */
    __weak LoginView* weakSelf = self;
    [UIView animateWithDuration:1.0//动画时长
                          delay:0.0//动画延迟
         usingSpringWithDamping:1.0//弹簧效果0~1
          initialSpringVelocity:5.0//初始速度
                        options:UIViewAnimationOptionCurveEaseInOut//动画过渡效果
                     animations:^{
                         baseViewY = -ScreenHeight*0.165;
                         CGRect temp = self.frame;
                         temp.origin.y = baseViewY;
                         weakSelf.frame = temp;
                         
                     } completion:^(BOOL finished) {
                         
                     }];
    
}

-(void)didClickReturnBurronWithLoginTextField:(LoginTextField *)loginTextField
{
    /**
     ios7 后动画效果
     */
    __weak LoginView* weakSelf = self;
    [UIView animateWithDuration:1.0//动画时长
                          delay:0.0//动画延迟
         usingSpringWithDamping:1.0//弹簧效果0~1
          initialSpringVelocity:5.0//初始速度
                        options:UIViewAnimationOptionCurveEaseInOut//动画过渡效果
                     animations:^{
                         baseViewY = 0;
                         CGRect temp = self.frame;
                         temp.origin.y = baseViewY;
                         weakSelf.frame = temp;
                         
                     } completion:^(BOOL finished) {
                         
                     }];
}

@end
