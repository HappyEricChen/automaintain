//
//  MyMessageView.h
//  automaintain
//
//  Created by eric on 16/7/1.
//  Copyright © 2016年 eric. All rights reserved.
// 在线留言/我的留言

#import <UIKit/UIKit.h>

@class MyMessageView;
@protocol MyMessageViewDelegate <NSObject>

@optional
-(void)didSelectedSubmitButtonWithMyMessageView:(MyMessageView*)myMessageView withMessageContent:(NSString*)messageContent;

@end
@interface MyMessageView : UIView

@property (nonatomic, weak) id <MyMessageViewDelegate> delegate;
@end
