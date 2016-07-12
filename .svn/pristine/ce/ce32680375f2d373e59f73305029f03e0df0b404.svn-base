//
//  CustomNavigationView.h
//  automaintain
//
//  Created by eric on 16/6/24.
//  Copyright © 2016年 eric. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CustomNavigationView;
@protocol CustomNavigationViewDelegate <NSObject>

@optional
/**
 * delegate method. user click left button at custom navigationview
 */
-(void)didSelectedLeftButtonAtCustomNavigationView:(CustomNavigationView*)customNavigationView;
/**
 * delegate method. user click right button at custom navigationview
 */
-(void)didSelectedRightButtonAtCustomNavigationView:(CustomNavigationView*)customNavigationView;

@end
@interface CustomNavigationView : UIView

@property (nonatomic, weak) id <CustomNavigationViewDelegate> delegate;

/**
 * initial method. this initial method contain leftbtn, rightbtn and title, fixed postion
 */
+(CustomNavigationView*)customNavigationViewWithLeftBtnImage:(UIImage*)leftImage
                                           withRightBtnImage:(UIImage*)rightImage
                                                   withTitle:(NSString*)title;

/**
 * 主页的导航栏
 */
+(CustomNavigationView*)homeCustomNavigationViewWithLeftBtnImage:(UIImage*)leftImage
                                           withRightBtnImage:(UIImage*)rightImage
                                                   withTitle:(NSString*)title;
@end
