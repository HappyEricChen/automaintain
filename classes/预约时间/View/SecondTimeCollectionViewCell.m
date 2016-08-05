//
//  SecondTimeCollectionViewCell.m
//  automaintain
//
//  Created by eric on 16/6/30.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "SecondTimeCollectionViewCell.h"
#import "ScheduleListModel.h"

@interface SecondTimeCollectionViewCell()

@property (nonatomic, weak) UIButton* timeButton;
@end
@implementation SecondTimeCollectionViewCell

NSString* const secondTimeCellId = @"secondTimeCellId";

+(SecondTimeCollectionViewCell *)collectionView:(UICollectionView *)collectionView
                dequeueReusableCellWithReuseIdentifier:(NSString *)reuseIdentifier
                                          forIndexPath:(NSIndexPath *)indexPath
{
    SecondTimeCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier
                                                                                          forIndexPath:indexPath];
    return cell;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        /**
         *  可预约时间
         */
        UIButton* timeButton = [[UIButton alloc]init];
        timeButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        timeButton.titleLabel.font = [UIFont systemFontOfSize:10];
        [timeButton setTitleColor:UIColorFromRGB(0x000000) forState:UIControlStateNormal];
        timeButton.layer.borderColor = UIColorFromRGB(0x7b7b7b).CGColor;
        timeButton.layer.borderWidth = 0.5f;
        timeButton.layer.cornerRadius = 2;
        timeButton.translatesAutoresizingMaskIntoConstraints = NO;
        timeButton.userInteractionEnabled = NO;
        [self addSubview:timeButton];
        self.timeButton = timeButton;
        
        timeButton.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
        
    }
    return self;
}

-(void)layoutWithObject:(id)object
{
    if ([object isKindOfClass:[ScheduleListModel class]])
    {
        
        ScheduleListModel* scheduleListModel = (ScheduleListModel*)object;
        [self.timeButton setTitle:scheduleListModel.TimeSegment forState:UIControlStateNormal];
        
        /**
         *  时间选中，选中的日期对应的时间背景颜色变蓝色
         */
        if ([AppManagerSingleton.selectedOrderDate isEqualToString:AppManagerSingleton.selectedDate])
        {
            if ([AppManagerSingleton.selectedTime isEqualToString:scheduleListModel.TimeSegment])
            {
                [self.timeButton setBackgroundColor:UIColorFromRGB(0x40add8)];
            }
            else
            {
                [self.timeButton setBackgroundColor:[UIColor whiteColor]];
            }
        }
        else
        {
            [self.timeButton setBackgroundColor:[UIColor whiteColor]];
        }
        
        /**
         *  时间比较，超过的时间变灰色
         */
        if ([AppManagerSingleton.currentDate isEqualToString:AppManagerSingleton.selectedDate])
        {
            
            if ([AppManagerSingleton.currentTime compare:scheduleListModel.ShopTime options:NSCaseInsensitiveSearch] == NSOrderedAscending)
            {
                [self.timeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                self.timeButton.userInteractionEnabled = NO;
            }
            else
            {
                [self.timeButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                self.timeButton.userInteractionEnabled = YES;
                self.timeButton.adjustsImageWhenHighlighted = NO;
            }
        }
        else
        {
            [self.timeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.timeButton.userInteractionEnabled = NO;
        }
        
    }
}


@end
