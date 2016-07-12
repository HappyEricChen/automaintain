//
//  CustomNavigationView.m
//  automaintain
//
//  Created by eric on 16/6/24.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "CustomNavigationView.h"

@implementation CustomNavigationView

+(CustomNavigationView *)customNavigationViewWithLeftBtnImage:(UIImage *)leftImage
                                            withRightBtnImage:(UIImage *)rightImage
                                                    withTitle:(NSString *)title
{
    CustomNavigationView* customNavigationView = [[CustomNavigationView alloc]init];
    customNavigationView.backgroundColor = [[UIColor alloc]initWithPatternImage:ImageNamed(@"register_topbg")];
    
    UIButton* leftBtn = [[UIButton alloc]init];
    [leftBtn addTarget:customNavigationView
                action:@selector(leftBtnAction:)
      forControlEvents:UIControlEventTouchUpInside];
    leftBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [customNavigationView addSubview:leftBtn];
    
    UIImageView* leftArrowImageView = [[UIImageView alloc]initWithImage:leftImage];
    leftArrowImageView.userInteractionEnabled = NO;
    leftArrowImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [leftBtn addSubview:leftArrowImageView];
    
    UIButton* rightBtn = [[UIButton alloc]init];
    [rightBtn addTarget:customNavigationView
                 action:@selector(rightBtnAction:)
       forControlEvents:UIControlEventTouchUpInside];
    rightBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [customNavigationView addSubview:rightBtn];
    
    UIImageView* rightArrowImageView = [[UIImageView alloc]initWithImage:rightImage];
    rightArrowImageView.userInteractionEnabled = NO;
    rightArrowImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [rightBtn addSubview:rightArrowImageView];
    
    UILabel* titleLabel = [[UILabel alloc]init];
    titleLabel.font = [UIFont systemFontOfSize:17];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = title;
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [customNavigationView addSubview:titleLabel];
   
    
    leftBtn.sd_layout.leftEqualToView(customNavigationView).topEqualToView(customNavigationView).bottomEqualToView(customNavigationView).widthEqualToHeight();
    leftArrowImageView.sd_layout.leftSpaceToView(leftBtn,ScreenWidth*0.042).topSpaceToView(leftBtn,ScreenHeight*0.1*0.496).widthIs(9).heightIs(18);
    rightBtn.sd_layout.rightEqualToView(customNavigationView).topEqualToView(customNavigationView).bottomEqualToView(customNavigationView).widthEqualToHeight();
    rightArrowImageView.sd_layout.rightSpaceToView(rightBtn,ScreenWidth*0.042).topSpaceToView(rightBtn,ScreenHeight*0.1*0.496).widthIs(16).heightIs(16);
    titleLabel.sd_layout.spaceToSuperView(UIEdgeInsetsMake(ScreenHeight*0.1*0.55,ScreenWidth*0.096,ScreenHeight*0.1*0.29,ScreenWidth*0.096));
    
    return customNavigationView;
}

+(CustomNavigationView *)homeCustomNavigationViewWithLeftBtnImage:(UIImage *)leftImage
                                                withRightBtnImage:(UIImage *)rightImage
                                                        withTitle:(NSString *)title
{
    CustomNavigationView* customNavigationView = [[CustomNavigationView alloc]init];
    customNavigationView.backgroundColor = [[UIColor alloc]initWithPatternImage:ImageNamed(@"register_topbg")];
    
    UIImageView* leftImageView = [[UIImageView alloc]initWithImage:leftImage];
    [customNavigationView addSubview:leftImageView];
    
    
    UILabel* titleLabel = [[UILabel alloc]init];
    titleLabel.font = [UIFont systemFontOfSize:12];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = title;
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [customNavigationView addSubview:titleLabel];
    
    
    leftImageView.sd_layout.leftSpaceToView(customNavigationView,ScreenWidth*0.042).topSpaceToView(customNavigationView,ScreenHeight*0.1*0.496).widthIs(13).heightIs(16);
   
    titleLabel.sd_layout.spaceToSuperView(UIEdgeInsetsMake(ScreenHeight*0.1*0.55,ScreenWidth*0.096,ScreenHeight*0.1*0.29,ScreenWidth*0.096));
    
    return customNavigationView;

}

-(void)leftBtnAction:(UIButton*)sender
{
    if ([self.delegate respondsToSelector:@selector(didSelectedLeftButtonAtCustomNavigationView:)])
    {
        [self.delegate didSelectedLeftButtonAtCustomNavigationView:self];
    }
}
-(void)rightBtnAction:(UIButton*)sender
{
    if ([self.delegate respondsToSelector:@selector(didSelectedRightButtonAtCustomNavigationView:)])
    {
        [self.delegate didSelectedRightButtonAtCustomNavigationView:self];
    }
}
@end
