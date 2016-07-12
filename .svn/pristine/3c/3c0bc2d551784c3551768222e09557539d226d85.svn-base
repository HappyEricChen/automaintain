//
//  MaintenanceHeaderView.m
//  automaintain
//
//  Created by eric on 16/6/29.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "MaintenanceHeaderView.h"

@implementation MaintenanceHeaderView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
#pragma mark - 预约类型
        UIButton* baseViewButton = [[UIButton alloc]init];
        [baseViewButton addTarget:self action:@selector(clickTypeChangeButton) forControlEvents:UIControlEventTouchUpInside];
        baseViewButton.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:baseViewButton];
        
        /**
         预约类型
         */
        UILabel* typeLabel = [[UILabel alloc]init];
        typeLabel.text = @"预约类型:";
        typeLabel.font = [UIFont systemFontOfSize:14];
        typeLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [baseViewButton addSubview:typeLabel];
        
        CGFloat typeLabelWidth = [typeLabel calculateWidthWithLabelContent:typeLabel.text
                                                              WithFontName:nil
                                                              WithFontSize:14
                                                                  WithBold:NO];
        /**
         *  保养/精细/项目内容名称
         */
        UILabel* contentLabel = [[UILabel alloc]init];
        contentLabel.text = @"保养/精细洗车(预计2小时)";
        contentLabel.font = [UIFont systemFontOfSize:14];
        contentLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [baseViewButton addSubview:contentLabel];
        
        CGFloat contentLabelWidth = [typeLabel calculateWidthWithLabelContent:contentLabel.text
                                                              WithFontName:nil
                                                              WithFontSize:14
                                                                  WithBold:NO];
        /**
         右边箭头
         */
        UIImageView* rightImageView = [[UIImageView alloc]initWithImage:ImageNamed(@"order_wx_right")];
        rightImageView.translatesAutoresizingMaskIntoConstraints = NO;
        [baseViewButton addSubview:rightImageView];
        
        UIView* lineView = [[UIView alloc]init];
        lineView.backgroundColor = [UIColor colorWithPatternImage:ImageNamed(@"order_wx_line")];
        lineView.translatesAutoresizingMaskIntoConstraints = NO;
        [baseViewButton addSubview:lineView];
        
        baseViewButton.sd_layout.leftEqualToView(self).rightEqualToView(self).topEqualToView(self).heightIs(ScreenHeight*0.067);
        typeLabel.sd_layout.leftSpaceToView(baseViewButton,ScreenWidth*0.037).topSpaceToView(baseViewButton,ScreenHeight*0.036).widthIs(typeLabelWidth).autoHeightRatio(0);
        contentLabel.sd_layout.leftSpaceToView(typeLabel,ScreenWidth*0.12).topSpaceToView(baseViewButton,ScreenHeight*0.036).widthIs(contentLabelWidth).autoHeightRatio(0);
        rightImageView.sd_layout.rightSpaceToView(baseViewButton,20).centerYEqualToView(typeLabel).widthIs(9).heightIs(18);
        lineView.sd_layout.leftEqualToView(baseViewButton).rightEqualToView(baseViewButton).heightIs(2).topSpaceToView(contentLabel,6);
        
        
#pragma mark - 预约时间
        UIButton* baseViewButton1 = [[UIButton alloc]init];
        baseViewButton1.translatesAutoresizingMaskIntoConstraints = NO;
        [baseViewButton1 addTarget:self action:@selector(clickTimeChangeButton) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:baseViewButton1];
        
        /**
         预约时间
         */
        UILabel* typeLabel1 = [[UILabel alloc]init];
        typeLabel1.text = @"预约时间:";
        typeLabel1.font = [UIFont systemFontOfSize:14];
        typeLabel1.translatesAutoresizingMaskIntoConstraints = NO;
        [baseViewButton1 addSubview:typeLabel1];
        
        CGFloat typeLabelWidth1 = [typeLabel calculateWidthWithLabelContent:typeLabel1.text
                                                              WithFontName:nil
                                                              WithFontSize:14
                                                                  WithBold:NO];
        /**
         *  2016-06-01 15:00-17:00
         */
        UILabel* contentLabel1 = [[UILabel alloc]init];
        contentLabel1.text = @"2016-06-01 15:00-17:00";
        contentLabel1.font = [UIFont systemFontOfSize:14];
        contentLabel1.translatesAutoresizingMaskIntoConstraints = NO;
        [baseViewButton1 addSubview:contentLabel1];
        
        CGFloat contentLabelWidth1 = [typeLabel calculateWidthWithLabelContent:contentLabel1.text
                                                                 WithFontName:nil
                                                                 WithFontSize:14
                                                                     WithBold:NO];
        /**
         右边箭头
         */
        UIImageView* rightImageView1 = [[UIImageView alloc]initWithImage:ImageNamed(@"order_wx_right")];
        rightImageView1.translatesAutoresizingMaskIntoConstraints = NO;
        [baseViewButton1 addSubview:rightImageView1];
        
        UIView* lineView1 = [[UIView alloc]init];
        lineView1.backgroundColor = [UIColor colorWithPatternImage:ImageNamed(@"order_wx_line")];
        lineView1.translatesAutoresizingMaskIntoConstraints = NO;
        [baseViewButton1 addSubview:lineView1];
        
        baseViewButton1.sd_layout.leftEqualToView(self).rightEqualToView(self).topSpaceToView(baseViewButton,0).heightIs(ScreenHeight*0.067);
        typeLabel1.sd_layout.leftSpaceToView(baseViewButton1,ScreenWidth*0.037).topSpaceToView(baseViewButton1,ScreenHeight*0.036).widthIs(typeLabelWidth1).autoHeightRatio(0);
        contentLabel1.sd_layout.leftSpaceToView(typeLabel1,ScreenWidth*0.12).topSpaceToView(baseViewButton1,ScreenHeight*0.036).widthIs(contentLabelWidth1).autoHeightRatio(0);
        rightImageView1.sd_layout.rightSpaceToView(baseViewButton1,20).centerYEqualToView(typeLabel1).widthIs(9).heightIs(18);
        lineView1.sd_layout.leftEqualToView(baseViewButton1).rightEqualToView(baseViewButton1).heightIs(2).topSpaceToView(contentLabel1,6);
        
#pragma mark - 提交预约按钮
        
        UIButton* submitButton = [[UIButton alloc]init];
        [submitButton setBackgroundImage:ImageNamed(@"order_wx_commit") forState:UIControlStateNormal];
        [submitButton setTitle:@"提交预约" forState:UIControlStateNormal];
        submitButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [submitButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
        submitButton.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:submitButton];
        
        submitButton.sd_layout.leftSpaceToView(self,ScreenWidth*0.04).rightSpaceToView(self,ScreenWidth*0.04).topSpaceToView(baseViewButton1,ScreenHeight*0.067).heightIs(ScreenHeight*0.05);
    }
    return self;
}

-(void)clickTypeChangeButton
{
    if ([self.delegate respondsToSelector:@selector(didSelectedTypeChangeButtonWithMaintenanceHeaderView:)])
    {
        [self.delegate didSelectedTypeChangeButtonWithMaintenanceHeaderView:self];
    }
}

-(void)clickTimeChangeButton
{
    if ([self.delegate respondsToSelector:@selector(didSelectedTimeChangeButtonWithMaintenanceHeaderView:)])
    {
        [self.delegate didSelectedTimeChangeButtonWithMaintenanceHeaderView:self];
    }
}
@end
