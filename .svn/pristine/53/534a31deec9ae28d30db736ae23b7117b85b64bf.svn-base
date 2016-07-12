//
//  WashCarThirdCollectionViewCell.m
//  一号车库
//
//  Created by eric on 16/6/28.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "WashCarThirdCollectionViewCell.h"

@interface WashCarThirdCollectionViewCell()

@property (nonatomic, weak) UIButton* timeButton;

@property (nonatomic, strong) NSArray* myOrderArr;//我的预定

@property (nonatomic, strong) NSArray* otherOrderArr;//他人预定
@end
@implementation WashCarThirdCollectionViewCell

NSString* const WashCarThirdCollectionViewCellId = @"WashCarThirdCollectionViewCellId";

+(WashCarThirdCollectionViewCell *)collectionView:(UICollectionView *)collectionView
           dequeueReusableCellWithReuseIdentifier:(NSString *)reuseIdentifier
                                     forIndexPath:(NSIndexPath *)indexPath
{
    WashCarThirdCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier
                                                                                      forIndexPath:indexPath];
    
    return cell;
}


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        /**
         *  时间选择
         */
        UIButton* timeButton = [[UIButton alloc]init];
        timeButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        timeButton.titleLabel.font = [UIFont systemFontOfSize:10];
        [timeButton setTitleColor:UIColorFromRGB(0x000000) forState:UIControlStateNormal];
        timeButton.layer.borderColor = UIColorFromRGB(0x7b7b7b).CGColor;
        timeButton.layer.borderWidth = 0.5f;
        timeButton.layer.cornerRadius = 2;
        timeButton.clipsToBounds = YES;
        timeButton.translatesAutoresizingMaskIntoConstraints = NO;
        [timeButton addTarget:self action:@selector(clickTimeOrderButton:) forControlEvents:UIControlEventTouchUpInside];
        [timeButton setBackgroundImage:ImageNamed(@"order_choose_blue") forState:UIControlStateSelected];
        [self addSubview:timeButton];
        self.timeButton = timeButton;
        
        timeButton.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
        
        self.myOrderArr = @[@"14:00-14:30"];
        
        self.otherOrderArr = @[@"9:30-10:00",
                               @"10:00-10:30",
                               @"11:30-12:00"];
      
    }
    return self;
}

-(void)layoutWithObject:(id)object
{
    
    [self.timeButton setTitle:(NSString*)object forState:UIControlStateNormal];
    
    [self layoutWithImge];
    
}

-(void)layoutWithImge
{
    
    for (NSInteger i=0; i<self.myOrderArr.count; i++)
    {
        if ([self.timeButton.titleLabel.text isEqualToString:self.myOrderArr[i]])
        {
            self.timeButton.selected = YES;
        }
    }
    
    for (NSInteger i=0; i<self.otherOrderArr.count; i++)
    {
        if ([self.timeButton.titleLabel.text isEqualToString:self.otherOrderArr[i]])
        {
            [self.timeButton setBackgroundImage:ImageNamed(@"order_choose_red") forState:UIControlStateNormal];
        }
    }
}

-(void)clickTimeOrderButton:(UIButton*)sender
{

    for (NSInteger i=0; i<self.otherOrderArr.count; i++)
    {
        if ([sender.titleLabel.text isEqualToString:self.otherOrderArr[i]])
        {
            return;
        }
    }
    
        sender.selected = !sender.isSelected;
    
}
@end
