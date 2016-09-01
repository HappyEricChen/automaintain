//
//  LoginTextField.m
//  automaintain
//
//  Created by eric on 16/6/23.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "LoginTextField.h"
#import "BaseTextField.h"

@interface LoginTextField()<UITextFieldDelegate>

@end
@implementation LoginTextField


-(instancetype)initWithImage:(UIImage *)image withPlaceHolder:(NSString *)placeHolder withType:(NSString*)type
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = UIColorFromRGBWithAlpha(0xffffff, 0.2);
        self.layer.cornerRadius = 5.5;
        
        UIImageView* imageView = [[UIImageView alloc]initWithImage:image];
        [self addSubview:imageView];
        
        if ([type isEqualToString:@"password"])
        {
            BaseTextField* textField = [[BaseTextField alloc]init];
            textField.placeholder = placeHolder;
            /**
             *  修改placeholder颜色
             */
            [textField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
            /**
             *  设置textfield光标为白色
             */
            textField.tintColor = [UIColor whiteColor];;
            textField.textAlignment = NSTextAlignmentLeft;
            textField.textColor = [UIColor whiteColor];
            [self addSubview:textField];
            textField.delegate = self;
            self.textField = textField;
            
            textField.secureTextEntry = YES;
            textField.clearsOnBeginEditing = NO;
            textField.returnKeyType = UIReturnKeyDone;
            imageView.sd_layout.leftSpaceToView(self,ScreenWidth*0.04).centerYEqualToView(self).widthIs(ScreenWidth*0.053).heightIs(ScreenHeight*0.036);
            textField.sd_layout.leftSpaceToView(self,ScreenWidth*0.16).topEqualToView(self).bottomEqualToView(self).rightEqualToView(self);
        }
        else
        {
            UITextField* textField = [[UITextField alloc]init];
            textField.placeholder = placeHolder;
            /**
             *  修改placeholder颜色
             */
            [textField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
            /**
             *  设置textfield光标为白色
             */
            textField.tintColor = [UIColor whiteColor];;
            textField.textAlignment = NSTextAlignmentLeft;
            textField.textColor = [UIColor whiteColor];
            [self addSubview:textField];
            textField.delegate = self;
            self.textField = textField;
            textField.keyboardType = UIKeyboardTypeNumberPad;
            
            imageView.sd_layout.leftSpaceToView(self,ScreenWidth*0.04).centerYEqualToView(self).widthIs(ScreenWidth*0.053).heightIs(ScreenHeight*0.036);
            textField.sd_layout.leftSpaceToView(self,ScreenWidth*0.16).topEqualToView(self).bottomEqualToView(self).rightEqualToView(self);
        }
        
    }
    return self;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.textField resignFirstResponder];
    if ([self.delegate respondsToSelector:@selector(didClickReturnBurronWithLoginTextField:)])
    {
        [self.delegate didClickReturnBurronWithLoginTextField:self];
    }
    return YES;
}

#pragma mark -UITextFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([self.delegate respondsToSelector:@selector(didClickTextFieldWithLoginTextField:)])
    {
        [self.delegate didClickTextFieldWithLoginTextField:self];
    }
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}
//
//-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
//{
//    if (action == @selector(paste:))//禁止粘贴
//        return NO;
//    if (action == @selector(select:))// 禁止选择
//        return NO;
//    if (action == @selector(selectAll:))// 禁止全选
//        return NO;
//    return [super canPerformAction:action withSender:sender];
//}

@end
