//
//  ModifyPasswordView.m
//  automaintain
//
//  Created by eric on 16/7/5.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "ModifyPasswordView.h"

@interface ModifyPasswordView()
/**
 *  旧密码
 */
@property (nonatomic, weak) UITextField* oldPasswordField;
/**
 *  新密码
 */
@property (nonatomic, weak) UITextField* freshPasswordField;
/**
 *  密码确认
 */
@property (nonatomic, weak) UITextField* confirmPasswordField;

/**
 *  定时器，用来防止按钮多次点击
 */
@property (nonatomic, strong) NSTimer* timer;

@end
@implementation ModifyPasswordView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        /**
         原密码
         */
        UIView* baseView = [[UIView alloc]init];
        baseView.translatesAutoresizingMaskIntoConstraints = NO;
        baseView.backgroundColor = [UIColor colorWithPatternImage:ImageNamed(@"register_textarea")];
        [self addSubview:baseView];
        
        UILabel* accountLabel = [[UILabel alloc]init];
        accountLabel.text = @"原密码";
        accountLabel.font = [UIFont systemFontOfSize:14];
        accountLabel.textColor = [UIColor blackColor];
        accountLabel.textAlignment = NSTextAlignmentCenter;
        accountLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [baseView addSubview:accountLabel];
        
        UITextField* oldPasswordField = [[UITextField alloc]init];
        oldPasswordField.placeholder = @"请输入原密码";
        oldPasswordField.keyboardType = UIKeyboardTypeASCIICapable;
        oldPasswordField.textAlignment = NSTextAlignmentLeft;
        oldPasswordField.textColor = UIColorFromRGB(0x000000);
        oldPasswordField.font = [UIFont systemFontOfSize:14];
        oldPasswordField.translatesAutoresizingMaskIntoConstraints = NO;
        [baseView addSubview:oldPasswordField];
        oldPasswordField.secureTextEntry = YES;
        self.oldPasswordField = oldPasswordField;
        
        /**
         新密码
         */
        UIView* baseView2 = [[UIView alloc]init];
        baseView2.translatesAutoresizingMaskIntoConstraints = NO;
        baseView2.backgroundColor = [UIColor colorWithPatternImage:ImageNamed(@"register_textarea")];
        [self addSubview:baseView2];
        
        UILabel* passwordLabel = [[UILabel alloc]init];
        passwordLabel.font = [UIFont systemFontOfSize:14];
        passwordLabel.textAlignment = NSTextAlignmentCenter;
        passwordLabel.translatesAutoresizingMaskIntoConstraints = NO;
        passwordLabel.text = @"新密码";
        [baseView2 addSubview:passwordLabel];
        
        UITextField* freshPasswordField = [[UITextField alloc]init];
        freshPasswordField.textAlignment = NSTextAlignmentLeft;
        freshPasswordField.textColor = UIColorFromRGB(0x000000);
        freshPasswordField.font = [UIFont systemFontOfSize:14];
        freshPasswordField.placeholder = @"设置新密码";
        freshPasswordField.keyboardType = UIKeyboardTypeASCIICapable;
        freshPasswordField.translatesAutoresizingMaskIntoConstraints = NO;
        [baseView2 addSubview:freshPasswordField];
        freshPasswordField.secureTextEntry = YES;
        self.freshPasswordField = freshPasswordField;
        
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
        
        UITextField* confirmPasswordField = [[UITextField alloc]init];
        confirmPasswordField.textAlignment = NSTextAlignmentLeft;
        confirmPasswordField.font = [UIFont systemFontOfSize:14];
        confirmPasswordField.textColor = UIColorFromRGB(0x000000);
        confirmPasswordField.placeholder = @"确认新密码";
        confirmPasswordField.keyboardType = UIKeyboardTypeASCIICapable;
        confirmPasswordField.translatesAutoresizingMaskIntoConstraints = NO;
        [baseView3 addSubview:confirmPasswordField];
        confirmPasswordField.secureTextEntry = YES;
        self.confirmPasswordField = confirmPasswordField;
        
        
        UIButton* changePasswordButton = [[UIButton alloc]init];
        [changePasswordButton setBackgroundImage:ImageNamed(@"register_commit") forState:UIControlStateNormal];
        [changePasswordButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [changePasswordButton setTitle:@"提交" forState:UIControlStateNormal];
        changePasswordButton.titleLabel.font = [UIFont systemFontOfSize:14];
        changePasswordButton.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:changePasswordButton];
        
        
        
        [changePasswordButton addTarget:self action:@selector(changePasswordAction) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        /**
         * 原密码
         */
        baseView.sd_layout.leftEqualToView(self).rightEqualToView(self).topSpaceToView(self,9).heightIs(ScreenHeight*0.05);
        accountLabel.sd_layout.leftSpaceToView(baseView,ScreenWidth*0.037).topEqualToView(baseView).bottomEqualToView(baseView).widthIs(ScreenWidth*0.15);
        oldPasswordField.sd_layout.leftSpaceToView(accountLabel,12).topEqualToView(baseView).bottomEqualToView(baseView).rightEqualToView(baseView);
        
        /**
         *  新密码
         */
        baseView2.sd_layout.leftEqualToView(self).rightEqualToView(self).topSpaceToView(baseView,9).heightIs(ScreenHeight*0.05);
        passwordLabel.sd_layout.leftSpaceToView(baseView2,ScreenWidth*0.037).topEqualToView(baseView2).bottomEqualToView(baseView2).widthIs(ScreenWidth*0.15);
        freshPasswordField.sd_layout.leftSpaceToView(passwordLabel,12).topEqualToView(baseView2).bottomEqualToView(baseView2).rightEqualToView(baseView2);
        /**
         *  密码确认
         */
        baseView3.sd_layout.leftEqualToView(self).rightEqualToView(self).topSpaceToView(baseView2,9).heightIs(ScreenHeight*0.05);
        passwordLabel1.sd_layout.leftSpaceToView(baseView3,ScreenWidth*0.037).topEqualToView(baseView3).bottomEqualToView(baseView3).widthIs(ScreenWidth*0.15);
        confirmPasswordField.sd_layout.leftSpaceToView(passwordLabel1,12).topEqualToView(baseView3).bottomEqualToView(baseView3).rightEqualToView(baseView3);
        
        changePasswordButton.sd_layout.leftSpaceToView(self,ScreenWidth*0.05).rightSpaceToView(self,ScreenWidth*0.05).topSpaceToView(baseView3,ScreenHeight*0.04).heightIs(ScreenHeight*0.05);
        
    }
    return self;
}

-(void)changePasswordAction
{
    
    /**
     *  保证短时间内点击按钮，只有最后一次有效
     */
    [self.timer invalidate];
    self.timer = nil;
    self.timer =[NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:NO];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}

-(void)updateTimer
{
    if ([self.delegate respondsToSelector:@selector(didClickSubmitButtonWithOldPassword:withNewPassword:withConfirmPassword:withModifyPasswordView:)])
    {
        [self.delegate didClickSubmitButtonWithOldPassword:self.oldPasswordField.text
                                           withNewPassword:self.freshPasswordField.text
                                       withConfirmPassword:self.confirmPasswordField.text
                                    withModifyPasswordView:self];
    }
    
}
@end
