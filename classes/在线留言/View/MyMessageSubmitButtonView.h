//
//  MyMessageSubmitButtonView.h
//  一号车库
//
//  Created by eric on 16/8/8.
//  Copyright © 2016年 eric. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyMessageSubmitButtonView;
@protocol MyMessageSubmitButtonViewDelegate <NSObject>

@optional
-(void)didClickMyMessageSubmitButtonView:(MyMessageSubmitButtonView*)myMessageSubmitButtonView;

@end
@interface MyMessageSubmitButtonView : UIView

@property (nonatomic, weak) id <MyMessageSubmitButtonViewDelegate> delegate;
@end
