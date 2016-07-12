//
//  LoginTextField.m
//  automaintain
//
//  Created by eric on 16/6/23.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "LoginTextField.h"
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
        imageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:imageView];
        
        UITextField* textField = [[UITextField alloc]init];
        textField.placeholder = placeHolder;
        /**
         *  修改placeholder颜色
         */
        [textField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
        textField.translatesAutoresizingMaskIntoConstraints = NO;
        textField.textAlignment = NSTextAlignmentLeft;
        textField.textColor = [UIColor whiteColor];
        [self addSubview:textField];
        textField.delegate = self;
        self.textField = textField;
        
        
        textField.sd_layout.leftSpaceToView(self,ScreenWidth*0.16).topEqualToView(self).bottomEqualToView(self).rightEqualToView(self);
        
        if ([type isEqualToString:@"password"])
        {
            textField.secureTextEntry = YES;
            textField.returnKeyType = UIReturnKeyDone;
            imageView.sd_layout.leftSpaceToView(self,ScreenWidth*0.04).centerYEqualToView(self).widthIs(ScreenWidth*0.045).heightIs(ScreenHeight*0.036);
        }
        else
        {
            textField.keyboardType = UIKeyboardTypeNumberPad;
            
            imageView.sd_layout.leftSpaceToView(self,ScreenWidth*0.04).centerYEqualToView(self).widthIs(ScreenWidth*0.053).heightIs(ScreenHeight*0.036);
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
@end
