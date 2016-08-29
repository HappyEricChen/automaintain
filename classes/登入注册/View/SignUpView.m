//
//  SignUpView.m
//  automaintain
//
//  Created by eric on 16/6/24.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "SignUpView.h"
#import "BaseTextField.h"

@interface SignUpView()<UITextFieldDelegate>

@property (nonatomic, weak) UITextField* textField;//账号
@property (nonatomic, weak) UITextField* textField1;//验证码
@property (nonatomic, weak) UITextField* textField2;//密码
@property (nonatomic, weak) UITextField* textField3;//密码验证

/**
 *  注册账号/找回密码，两种类型中的一种
 */
@property (nonatomic, weak) NSString* type;

/**
 *  定时器，用来防止按钮多次点击
 */
@property (nonatomic, strong) NSTimer* timer;

@property (nonatomic, assign) BOOL lockButton;

@end
@implementation SignUpView

-(instancetype)initWithType:(NSString *)type
{
    self = [super init];
    if (self)
    {
        self.lockButton = NO;
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didClickVerificationButton) name:kNotify_verification_Button object:nil];
        
        
        self.type = type;
        /**
         账号
         */
        UIView* baseView = [[UIView alloc]init];
        baseView.translatesAutoresizingMaskIntoConstraints = NO;
        baseView.backgroundColor = [UIColor colorWithPatternImage:ImageNamed(@"register_textarea")];
        [self addSubview:baseView];
        
        UILabel* accountLabel = [[UILabel alloc]init];
        accountLabel.text = @"账   号";
        accountLabel.font = [UIFont systemFontOfSize:14];
        accountLabel.textColor = [UIColor blackColor];
        accountLabel.textAlignment = NSTextAlignmentCenter;
        accountLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [baseView addSubview:accountLabel];
        
        UITextField* textField = [[UITextField alloc]init];
        textField.placeholder = @"请输入手机号";
        textField.keyboardType = UIKeyboardTypePhonePad;
        textField.textAlignment = NSTextAlignmentLeft;
        textField.textColor = UIColorFromRGB(0x000000);
        textField.font = [UIFont systemFontOfSize:14];
        textField.translatesAutoresizingMaskIntoConstraints = NO;
        [baseView addSubview:textField];
        textField.delegate = self;
        self.textField = textField;
        
        
        /**
         验证码
         */
        UIView* baseView1 = [[UIView alloc]init];
        baseView1.translatesAutoresizingMaskIntoConstraints = NO;
        baseView1.backgroundColor = [UIColor colorWithPatternImage:ImageNamed(@"register_textarea")];
        [self addSubview:baseView1];
        
        UILabel* verificationLabel = [[UILabel alloc]init];
        verificationLabel.text = @"验证码";
        verificationLabel.font = [UIFont systemFontOfSize:14];
        verificationLabel.textAlignment = NSTextAlignmentCenter;
        verificationLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [baseView1 addSubview:verificationLabel];
        
        UITextField* textField1 = [[UITextField alloc]init];
        textField1.placeholder = @"请输入短信验证码";
        textField1.textAlignment = NSTextAlignmentLeft;
        textField1.keyboardType = UIKeyboardTypeNumberPad;
        textField1.textColor = UIColorFromRGB(0x000000);
        textField1.font = [UIFont systemFontOfSize:14];
        textField1.translatesAutoresizingMaskIntoConstraints = NO;
        [baseView1 addSubview:textField1];
        textField1.delegate = self;
        self.textField1 = textField1;
        

        [baseView1 addSubview: AppManagerSingleton.countDownButton];

        
        
        UIView* lineView = [[UIView alloc]init];
        lineView.backgroundColor = [UIColor colorWithPatternImage:ImageNamed(@"register_verline")];
        lineView.translatesAutoresizingMaskIntoConstraints = NO;
        [baseView1 addSubview:lineView];
        
        /**
         密码
         */
        UIView* baseView2 = [[UIView alloc]init];
        baseView2.translatesAutoresizingMaskIntoConstraints = NO;
        baseView2.backgroundColor = [UIColor colorWithPatternImage:ImageNamed(@"register_textarea")];
        [self addSubview:baseView2];
        
        UILabel* passwordLabel = [[UILabel alloc]init];
        passwordLabel.font = [UIFont systemFontOfSize:14];
        passwordLabel.textAlignment = NSTextAlignmentCenter;
        passwordLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [baseView2 addSubview:passwordLabel];
        
        BaseTextField* textField2 = [[BaseTextField alloc]init];
        textField2.textAlignment = NSTextAlignmentLeft;
        textField2.textColor = UIColorFromRGB(0x000000);
        textField2.font = [UIFont systemFontOfSize:14];
        textField2.keyboardType = UIKeyboardTypeASCIICapable;
        textField2.translatesAutoresizingMaskIntoConstraints = NO;
        [baseView2 addSubview:textField2];
        textField2.secureTextEntry = YES;
        textField2.delegate = self;
        self.textField2 = textField2;
        
        /**
         密码确认
         */
        UIView* baseView3 = [[UIView alloc]init];
        baseView3.translatesAutoresizingMaskIntoConstraints = NO;
        baseView3.backgroundColor = [UIColor colorWithPatternImage:ImageNamed(@"register_textarea")];
        [self addSubview:baseView3];
        
        UILabel* passwordLabel1 = [[UILabel alloc]init];
        passwordLabel1.text = @"确   认";
        passwordLabel1.font = [UIFont systemFontOfSize:14];
        passwordLabel1.textAlignment = NSTextAlignmentCenter;
        passwordLabel1.translatesAutoresizingMaskIntoConstraints = NO;
        [baseView3 addSubview:passwordLabel1];
        
        BaseTextField* textField3 = [[BaseTextField alloc]init];
        textField3.textAlignment = NSTextAlignmentLeft;
        textField3.font = [UIFont systemFontOfSize:14];
        textField3.textColor = UIColorFromRGB(0x000000);
        textField3.keyboardType = UIKeyboardTypeASCIICapable;
        textField3.translatesAutoresizingMaskIntoConstraints = NO;
        [baseView3 addSubview:textField3];
        textField3.secureTextEntry = YES;
        textField3.delegate = self;
        self.textField3 = textField3;
        
        
        UIButton* signupButton = [[UIButton alloc]init];
        [signupButton setBackgroundImage:ImageNamed(@"register_commit") forState:UIControlStateNormal];
        [signupButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [signupButton setTitle:type forState:UIControlStateNormal];
        signupButton.titleLabel.font = [UIFont systemFontOfSize:14];
        signupButton.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:signupButton];
        
        if ([type isEqualToString:@"立即注册"])
        {
            passwordLabel.text = @"密   码";
            textField2.placeholder = @"请设置密码";
            textField3.placeholder = @"请确认密码";
            [signupButton addTarget:self action:@selector(signupAction) forControlEvents:UIControlEventTouchUpInside];
        }
        else
        {
            passwordLabel.text = @"新密码";
            textField2.placeholder = @"请设置新密码";
            textField3.placeholder = @"请确认新密码";
            [signupButton addTarget:self action:@selector(findPasswordAction) forControlEvents:UIControlEventTouchUpInside];

        }
        
        
        /**
         *  账号
         */
        baseView.sd_layout.leftEqualToView(self).rightEqualToView(self).topSpaceToView(self,9).heightIs(ScreenHeight*0.05);
        accountLabel.sd_layout.leftSpaceToView(baseView,ScreenWidth*0.037).topEqualToView(baseView).bottomEqualToView(baseView).widthIs(ScreenWidth*0.15);
        textField.sd_layout.leftSpaceToView(accountLabel,12).topEqualToView(baseView).bottomEqualToView(baseView).rightEqualToView(baseView);
        /**
         *  验证码
         */
        baseView1.sd_layout.leftEqualToView(self).rightEqualToView(self).topSpaceToView(baseView,12).heightIs(ScreenHeight*0.05);
        verificationLabel.sd_layout.leftSpaceToView(baseView1,ScreenWidth*0.037).topEqualToView(baseView1).bottomEqualToView(baseView1).widthIs(ScreenWidth*0.15);
        textField1.sd_layout.leftSpaceToView(verificationLabel,12).topEqualToView(baseView1).bottomEqualToView(baseView1).widthIs(ScreenWidth*0.4);
        
        lineView.sd_layout.leftSpaceToView(textField1,0).topSpaceToView(baseView1,5).bottomSpaceToView(baseView1,5).widthIs(1.5);
        AppManagerSingleton.countDownButton.sd_layout.leftSpaceToView(lineView,0).topSpaceToView(baseView1,1).bottomEqualToView(baseView1).rightEqualToView(baseView1);
        /**
         *  密码
         */
        baseView2.sd_layout.leftEqualToView(self).rightEqualToView(self).topSpaceToView(baseView1,9).heightIs(ScreenHeight*0.05);
        passwordLabel.sd_layout.leftSpaceToView(baseView2,ScreenWidth*0.037).topEqualToView(baseView2).bottomEqualToView(baseView2).widthIs(ScreenWidth*0.15);
        textField2.sd_layout.leftSpaceToView(passwordLabel,12).topEqualToView(baseView2).bottomEqualToView(baseView2).rightEqualToView(baseView2);
        /**
         *  密码确认
         */
        baseView3.sd_layout.leftEqualToView(self).rightEqualToView(self).topSpaceToView(baseView2,9).heightIs(ScreenHeight*0.05);
        passwordLabel1.sd_layout.leftSpaceToView(baseView3,ScreenWidth*0.037).topEqualToView(baseView3).bottomEqualToView(baseView3).widthIs(ScreenWidth*0.15);
        textField3.sd_layout.leftSpaceToView(passwordLabel1,12).topEqualToView(baseView3).bottomEqualToView(baseView3).rightEqualToView(baseView3);
        
        signupButton.sd_layout.leftSpaceToView(self,ScreenWidth*0.05).rightSpaceToView(self,ScreenWidth*0.05).topSpaceToView(baseView3,ScreenHeight*0.04).heightIs(ScreenHeight*0.05);
    }
    return self;
}

#pragma mark - signupAction

-(void)signupAction
{
    /**
     *  保证短时间内点击按钮，只有最后一次有效
     */
    [self.timer invalidate];
    self.timer = nil;
    self.timer =[NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(updateTimerSignup) userInfo:nil repeats:NO];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
  }
-(void)updateTimerSignup
{
    if ([self.delegate respondsToSelector:@selector(signUpView:withUsername:withPassword:withconfirmPassword:withverificationCode:)])
    {
        [self.delegate signUpView:self
                     withUsername:self.textField.text
                     withPassword:self.textField2.text
              withconfirmPassword:self.textField3.text
             withverificationCode:self.textField1.text];
    }
}

-(void)findPasswordAction
{
    /**
     *  保证短时间内点击按钮，只有最后一次有效
     */
    [self.timer invalidate];
    self.timer = nil;
    self.timer =[NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(updateTimerFindPassword) userInfo:nil repeats:NO];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}
-(void)updateTimerFindPassword
{
    if ([self.delegate respondsToSelector:@selector(signUpView:withUsername:withPassword:withconfirmPassword:withverificationCode:)])
    {
        [self.delegate signUpView:self
                     withUsername:self.textField.text
                     withPassword:self.textField2.text
              withconfirmPassword:self.textField3.text
             withverificationCode:self.textField1.text];
    }
    
}

#pragma mark - 点击获取验证码按钮
-(void)didClickVerificationButton
{
    if (!self.lockButton)
    {
        self.lockButton = YES;
        
        if ([self.type isEqualToString:@"立即注册"])
        {
            /**
             *  false为注册，accessCode不存在才可以注册
             */
            [self clickVerificationButtonwithIsExisted:@"false"];
        }
        else
        {
            /**
             *  ture为找回密码，accessCode存在才可以找回密码
             */
            [self clickVerificationButtonwithIsExisted:@"true"];
        }
        
    }
}

-(void)clickVerificationButtonwithIsExisted:(NSString*)IsExisted
{
    if ([self.delegate respondsToSelector:@selector(didClickVerificationButtonWithSignUpView:withUsername:withIsExisted:withCallback:)])
    {
        [self.delegate didClickVerificationButtonWithSignUpView:self
                                                   withUsername:self.textField.text
                                                  withIsExisted:IsExisted
                                                   withCallback:^(BOOL success, NSError *error, id result)
         {
             
             
             if (success)
             {
                 /**
                  *  倒计时按钮
                  *
                  *  @param timeLine 倒计时总时间
                  *  @param title    还没倒计时的title
                  *  @param subTitle 倒计时中的子名字，如时、分
                  *  @param mColor   还没倒计时的颜色
                  *  @param color    倒计时中的颜色
                  */
                 [AppManagerSingleton.countDownButton startWithTime:60
                                                  title:@"获取验证码"
                                         countDownTitle:@"秒后重新获取"
                                              mainColor:UIColorFromRGB(0xffffff)
                                             countColor:UIColorFromRGB(0xffffff)];

             }
             else
             {
                 [SVProgressHUD showInfoWithStatus:@"验证码发送失败"];
             }
             
             /**
              *  解锁
              */
             self.lockButton = NO;
             
         }];
    }
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:kNotify_verification_Button object:nil];
}
@end
