//
//  LoginTextField.h
//  automaintain
//
//  Created by eric on 16/6/23.
//  Copyright © 2016年 eric. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LoginTextField;
@protocol LoginTextFieldDelegate <NSObject>

@optional
/**
 *  点击键盘，输入框上移
 */
-(void)didClickTextFieldWithLoginTextField:(LoginTextField*)loginTextField;

/**
 *  点击键盘return，输入框回复原位
 */
-(void)didClickReturnBurronWithLoginTextField:(LoginTextField*)loginTextField;

@end
@interface LoginTextField : UIView

-(instancetype)initWithImage:(UIImage *)image withPlaceHolder:(NSString *)placeHolder withType:(NSString*)type;

@property (nonatomic, weak) id <LoginTextFieldDelegate> delegate;

/**
 *  输入框
 */
@property (nonatomic, strong) UITextField* textField;


@end
