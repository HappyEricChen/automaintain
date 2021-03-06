//
//  SecondCollectionViewCell.m
//  一号车库
//
//  Created by eric on 16/6/27.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "SecondCollectionViewCell.h"
#import "CustomButton.h"

@implementation SecondCollectionViewCell

NSString* const secondCellId = @"secondCellId";

+(SecondCollectionViewCell *)collectionView:(UICollectionView *)collectionView dequeueReusableCellWithReuseIdentifier:(NSString *)reuseIdentifier forIndexPath:(NSIndexPath *)indexPath
{
    SecondCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier
                                                                               forIndexPath:indexPath];
    return cell;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        
        CustomButton* button1 = [[CustomButton alloc]initWithImage:ImageNamed(@"home_icon_cleancar") WithTitle:@"预约洗车"];
        [button1 addTarget:self action:@selector(clickOrderCarButton) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button1];
        
        CustomButton* button2 = [[CustomButton alloc]initWithImage:ImageNamed(@"home_icon_check") WithTitle:@"美容维修"];
        [button2 addTarget:self action:@selector(clickMaintenanceButton) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button2];
        
        CustomButton* button3 = [[CustomButton alloc]initWithImage:ImageNamed(@"home_icon_order") WithTitle:@"我的预约"];
        [button3 addTarget:self action:@selector(clickMyOrderButton) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button3];
        
        CustomButton* button4 = [[CustomButton alloc]initWithImage:ImageNamed(@"home_icon_personal") WithTitle:@"个人中心"];
        [button4 addTarget:self action:@selector(clickPersonalButton) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button4];
        
        button1.sd_layout.leftSpaceToView(self,(ScreenWidth-200)*0.2).heightIs(50+20).widthIs(50).centerYEqualToView(self);
        button2.sd_layout.leftSpaceToView(button1,(ScreenWidth-200)*0.2).heightIs(50+20).widthIs(50).centerYEqualToView(self);
        button3.sd_layout.leftSpaceToView(button2,(ScreenWidth-200)*0.2).heightIs(50+20).widthIs(50).centerYEqualToView(self);
        button4.sd_layout.leftSpaceToView(button3,(ScreenWidth-200)*0.2).heightIs(50+20).widthIs(50).centerYEqualToView(self);
        
    }
    return self;
}

-(void)clickOrderCarButton
{
    if ([self.delegate respondsToSelector:@selector(didSelectedOrderCarButtonWithSecondCollectionViewCell:)])
    {
        [self.delegate didSelectedOrderCarButtonWithSecondCollectionViewCell:self];
    }
}

-(void)clickMaintenanceButton
{
    if ([self.delegate respondsToSelector:@selector(didSelectedMaintenanceButtonWithSecondCollectionViewCell:)])
    {
        [self.delegate didSelectedMaintenanceButtonWithSecondCollectionViewCell:self];
    }
}

-(void)clickMyOrderButton
{
    if ([self.delegate respondsToSelector:@selector(didSelectedMyOrderButtonWithSecondCollectionViewCell:)])
    {
        [self.delegate didSelectedMyOrderButtonWithSecondCollectionViewCell:self];
    }
}

-(void)clickPersonalButton
{
    if ([self.delegate respondsToSelector:@selector(didSelectedPersonalButtonWithSecondCollectionViewCell:)])
    {
        [self.delegate didSelectedPersonalButtonWithSecondCollectionViewCell:self];
    }
}
@end
