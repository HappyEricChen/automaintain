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
    
    
    if ([AppManagerSingleton.currentDate isEqualToString:AppManagerSingleton.selectedDate])
    {
        /**
         *  时间比较，当前时间和初始时间比较，初始时间小于当前时间变灰色
         */
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
    
    
    /**
     *  红色是他人已预约，蓝色是我预约过，白色是没预约过
     */
    if ([self.appointmentCount isEqualToString:@"myOrder"])
    {
        
        [self.button setBackgroundImage:ImageNamed(@"order_choose_blue") forState:UIControlStateNormal];
        [self.button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        self.userInteractionEnabled = NO;
    }
    else if ([self.appointmentCount isEqualToString:@"full"])
    {
        [self.button setBackgroundImage:ImageNamed(@"order_choose_red") forState:UIControlStateNormal];
        [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.userInteractionEnabled = NO;
    }
    else if ([AppManagerSingleton.selectedOrderDate isEqualToString:AppManagerSingleton.selectedDate])
    {
        /**
         *  时间选中，选中的日期对应的时间背景颜色变蓝色
         */
        if ([AppManagerSingleton.selectedTime isEqualToString:scheduleListModel.TimeSegment])
        {
            [self.button setBackgroundImage:ImageNamed(@"order_choose_blue") forState:UIControlStateNormal];
            [self.button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.userInteractionEnabled = NO;
        }
        else
        {
            [self.button setBackgroundImage:ImageNamed(@"register_k2") forState:UIControlStateNormal];
            self.userInteractionEnabled = YES;
        }
        
        
    }
    else
    {
        [self.button setBackgroundImage:ImageNamed(@"register_k2") forState:UIControlStateNormal];
        self.userInteractionEnabled = YES;
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
