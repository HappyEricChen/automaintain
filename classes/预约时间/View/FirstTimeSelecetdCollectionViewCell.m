//
//  FirstTimeSelecetdCollectionViewCell.m
//  automaintain
//
//  Created by eric on 16/6/30.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "FirstTimeSelecetdCollectionViewCell.h"
#import "ScheduleListModel.h"
@interface FirstTimeSelecetdCollectionViewCell()

@property (nonatomic, weak) UIButton* timeButton;
@end

@implementation FirstTimeSelecetdCollectionViewCell

NSString* const firstTimeCellId = @"firstTimeCellId";

+(FirstTimeSelecetdCollectionViewCell *)collectionView:(UICollectionView *)collectionView
           dequeueReusableCellWithReuseIdentifier:(NSString *)reuseIdentifier
                                     forIndexPath:(NSIndexPath *)indexPath
{
    FirstTimeSelecetdCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier
                                                                                     forIndexPath:indexPath];
    return cell;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        /**
         *  他人已预约/时间
         */
        UIButton* timeButton = [[UIButton alloc]init];
        timeButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        timeButton.titleLabel.font = [UIFont systemFontOfSize:10];
        [timeButton setTitleColor:UIColorFromRGB(0x000000) forState:UIControlStateNormal];
        [timeButton setBackgroundImage:ImageNamed(@"order_choose_red") forState:UIControlStateNormal];
        timeButton.layer.borderColor = UIColorFromRGB(0x7b7b7b).CGColor;
        timeButton.clipsToBounds = YES;
        timeButton.layer.borderWidth = 0.5f;
        timeButton.layer.cornerRadius = 2;
        timeButton.translatesAutoresizingMaskIntoConstraints = NO;
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
