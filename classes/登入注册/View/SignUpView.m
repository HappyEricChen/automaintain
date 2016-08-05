//
//  SignUpView.m
//  automaintain
//
//  Created by eric on 16/6/24.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "SignUpView.h"
@interface SignUpView()<UITextFieldDelegate>

@property (nonatomic, weak) UITextField* textField;//账号
@property (nonatomic, weak) UITextField* textField1;//验证码
@property (nonatomic, weak) UITextField* textField2;//密码
@property (nonatomic, weak) UITextField* textField3;//密码验证

@property (nonatomic, weak) UIButton* verificationButton;//发送验证按钮

/**
 *  定时器，用来防止按钮多次点击
 */
@property (nonatomic, strong) NSTimer* timer;

@end
@implementation SignUpView

-(instancetype)initWithType:(NSString *)type
{
    self = [super init];
    if (self)
    {
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
        
        UIButton* verificationButton = [[UIButton alloc]init];
        [verificationButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [verificationButton setTitleColor:UIColorFromRGB(0xbf2e0d) forState:UIControlStateNormal];
        verificationButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        verificationButton.titleLabel.font = [UIFont systemFontOfSize:12];
        verificationButton.translatesAutoresizingMaskIntoConstraints = NO;
        [baseView1 addSubview:verificationButton];
        self.verificationButton = verificationButton;
        
        
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
        
        UITextField* textField2 = [[UITextField alloc]init];
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
        
        UITextField* textField3 = [[UITextField alloc]init];
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
            [verificationButton addTarget:self action:@selector(signupClickVerificationButton) forControlEvents:UIControlEventTouchUpInside];
        }
        else
        {
            passwordLabel.text = @"新密码";
            textField2.placeholder = @"设置新密码";
            textField3.placeholder = @"确认新密码";
            [signupButton addTarget:self action:@selector(findPasswordAction) forControlEvents:UIControlEventTouchUpInside];
            [verificationButton addTarget:self action:@selector(changePasswordClickVerificationButton) forControlEvents:UIControlEventTouchUpInside];
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
        textField1.sd_layout.leftSpaceToView(verificationLabel,12).topEqualToView(baseView1).bottomEqualToView(baseView1).widthIs(ScreenWidth*0.50);
        
        lineView.sd_layout.leftSpaceToView(textField1,0).topSpaceToView(baseView1,5).bottomSpaceToView(baseView1,5).widthIs(1.5);
        verificationButton.sd_layout.leftSpaceToView(lineView,0).topEqualToView(baseView1).bottomEqualToView(baseView1).rightEqualToView(baseView1);
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
-(void)signupClickVerificationButton
{
    [self clickVerificationButtonwithIsExisted:@"false"];
}
-(void)changePasswordClickVerificationButton
{
    [self clickVerificationButtonwithIsExisted:@"true"];
}

-(void)clickVerificationButtonwithIsExisted:(NSString*)IsExisted
{
    if ([self.delegate respondsToSelector:@selector(didClickVerificationButtonWithSignUpView:withUsername:withIsExisted:withCallback:)])
    {
        [self.delegate didClickVerificationButtonWithSignUpView:self withUsername:self.textField.text withIsExisted:IsExisted withCallback:^(BOOL success, NSError *error, id result)
         {
             if (success)
             {
                 
                 __block int timeout=59; //倒计时时间
                 dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
                 dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
                 dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
                 dispatch_source_set_event_handler(_timer, ^{
                     if(timeout<=0){ //倒计时结束，关闭
                         dispatch_source_cancel(_timer);
                         dispatch_async(dispatch_get_main_queue(), ^{
                             //设置界面的按钮显示 根据自己需求设置
                             [self.verificationButton setTitle:@"获取验证码" forState:UIControlStateNormal];
                             self.verificationButton.userInteractionEnabled = YES;
                             
                         });
                     }else{
                         //                         int minutes = timeout / 60;
                         int seconds = timeout % 60;
                         NSString *strTime = [NSString stringWithFormat:@"%.2d秒后重新获取", seconds];
                         dispatch_async(dispatch_get_main_queue(), ^{
                             //设置界面的按钮显示 根据自己需求设置
                             [self.verificationButton setTitle:strTime forState:UIControlStateNormal];
                             self.verificationButton.userInteractionEnabled = NO;
                         });
                         timeout--;
                         
                     }
                 });
                 dispatch_resume(_timer);
             }
             else
             {
                 
             }
             
         }];
    }
}
@end
