//
//  WashCarCollectionViewCell.m
//  一号车库
//
//  Created by eric on 16/7/14.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "WashCarCollectionViewCell.h"

@interface WashCarCollectionViewCell()
@property (nonatomic, strong) UIButton* button;

@end
@implementation WashCarCollectionViewCell

NSString* const WashCarCollectionViewCell1Id = @"WashCarCollectionViewCell1Id";

+(WashCarCollectionViewCell *)collectionView:(UICollectionView *)collectionView dequeueReusableCellWithReuseIdentifier:(NSString *)reuseIdentifier forIndexPath:(NSIndexPath *)indexPath
{
    WashCarCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    return cell;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UIButton* button = [[UIButton alloc]init];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        button.titleLabel.font = [UIFont systemFontOfSize:10];
        button.layer.borderColor = UIColorFromRGB(0x7b7b7b).CGColor;
        button.layer.borderWidth = 0.5f;
        button.layer.cornerRadius = 2;
        button.clipsToBounds = YES;
        button.translatesAutoresizingMaskIntoConstraints = NO;
        [button addTarget:self action:@selector(clickCurrentButton:) forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundImage:ImageNamed(@"order_choose_blue") forState:UIControlStateSelected];
        [button setBackgroundImage:ImageNamed(@"order_choose_white") forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:button];
        self.button = button;
        
        button.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    }
    return self;
}

-(void)layoutWithObject:(id)object
{
    if ([object isKindOfClass:[NSString class]])
    {
        [self.button setTitle:(NSString*)object forState:UIControlStateNormal];
    }
  
//    if (self.buttonColor == blueColor)
//    {
//        [self.button setBackgroundImage:ImageNamed(@"order_choose_blue") forState:UIControlStateSelected];
//        self.button.enabled = NO;
//    }
//    else if (self.buttonColor == redColor)
//    {
//        [self.button setBackgroundImage:ImageNamed(@"order_choose_red") forState:UIControlStateSelected];
//        self.button.enabled = NO;
//    }
}




-(void)clickCurrentButton:(UIButton*)sender
{
    
    if ([self.delegate respondsToSelector:@selector(didSelectedButtonWithWashCarCollectionViewCell:withCurrentBtn:)])
    {
        [self.delegate didSelectedButtonWithWashCarCollectionViewCell:self withCurrentBtn:sender];
    }
}
@end
