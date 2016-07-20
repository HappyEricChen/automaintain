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
    }
}


@end
