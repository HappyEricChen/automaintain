//
//  WashCarCollectionViewCell.m
//  一号车库
//
//  Created by eric on 16/7/14.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "WashCarCollectionViewCell.h"
#import "ScheduleListModel.h"

@interface WashCarCollectionViewCell()
@property (nonatomic, strong) UIButton* button;
/**
 *  数量
 */
@property (nonatomic, strong) NSString* appointmentCount;
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
//        [button setBackgroundImage:ImageNamed(@"order_choose_blue") forState:UIControlStateSelected];
        button.userInteractionEnabled = NO;
        [self addSubview:button];
        self.button = button;
        
        button.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    }
    return self;
}

-(void)layoutWithObject:(id)object
{
    
    ScheduleListModel* scheduleListModel = (ScheduleListModel*)object;
    
    [self.button setTitle:scheduleListModel.TimeSegment forState:UIControlStateNormal];
    self.appointmentCount = scheduleListModel.AppointmentCount;
    
    if ([self.appointmentCount isEqualToString:@"myOrder"])
    {
        
        [self.button setBackgroundImage:ImageNamed(@"order_choose_blue") forState:UIControlStateNormal];
        self.userInteractionEnabled = NO;
    }
    else if ([self.appointmentCount isEqualToString:@"full"])
    {
        [self.button setBackgroundImage:ImageNamed(@"order_choose_red") forState:UIControlStateSelected];
        self.userInteractionEnabled = NO;
    }
    else if ([self.appointmentCount isEqualToString:@"myTempOrder"])
    {
        [self.button setBackgroundImage:ImageNamed(@"order_choose_blue") forState:UIControlStateNormal];
        self.userInteractionEnabled = NO;
    }
    else
    {
        [self.button setBackgroundImage:ImageNamed(@"register_k2") forState:UIControlStateNormal];
        self.userInteractionEnabled = YES;
    }
    
    if ([AppManagerSingleton.currentDate isEqualToString:AppManagerSingleton.selectedDate])
    {
        
        if ([AppManagerSingleton.currentTime compare:scheduleListModel.ShopTime options:NSCaseInsensitiveSearch] == NSOrderedAscending)
        {
            [self.button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.button.userInteractionEnabled = NO;
        }
        else
        {
            [self.button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            self.button.userInteractionEnabled = YES;
            self.button.adjustsImageWhenHighlighted = NO;
        }
    }
    else
    {
        [self.button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.button.userInteractionEnabled = NO;
    }
    
}




-(void)clickCurrentButton:(UIButton*)sender
{
//    if ([self.delegate respondsToSelector:@selector(didSelectedButtonWithWashCarCollectionViewCell:withCurrentBtn:)])
//    {
//        [self.delegate didSelectedButtonWithWashCarCollectionViewCell:self withCurrentBtn:sender];
//    }
}
@end
