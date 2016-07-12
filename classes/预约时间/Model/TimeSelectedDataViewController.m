//
//  TimeSelectedDataViewController.m
//  automaintain
//
//  Created by eric on 16/6/30.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "TimeSelectedDataViewController.h"
#import "WashCarFirstCollectionViewCell.h"
#import "TimeSelectedHeaderView.h"
#import "FirstTimeSelecetdCollectionViewCell.h"
#import "SecondTimeCollectionViewCell.h"

@implementation TimeSelectedDataViewController

-(CustomNavigationView *)customNavigationView
{
    if (!_customNavigationView)
    {
        _customNavigationView = [CustomNavigationView customNavigationViewWithLeftBtnImage:ImageNamed(@"register_back")  withRightBtnImage:nil withTitle:@"预约时间"];
    }
    return _customNavigationView;
}

-(UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor clearColor];
        
        [_collectionView registerClass:[WashCarFirstCollectionViewCell class] forCellWithReuseIdentifier:washCarFirstId];
        [_collectionView registerClass:[FirstTimeSelecetdCollectionViewCell class] forCellWithReuseIdentifier:firstTimeCellId];
        [_collectionView registerClass:[SecondTimeCollectionViewCell class] forCellWithReuseIdentifier:secondTimeCellId];
        
        [_collectionView registerClass:[TimeSelectedHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:TimeSelectedHeaderViewId];
        
        
    }
    return _collectionView;
}

-(void)loadMaintenanceOrderTimeArr
{
    
    self.otherOrderMaintenanceArr = @[@"10:00-10:30",
                                      @"10:30-11:00",
                                      @"11:00-11:30",
                                      @"11:30-12:00",
                                      @"12:00-12:30",
                                      @"12:30-13:00",];
    
    self.canOrderMaintenanceArr = @[@"7:00-7:30",
                               @"7:30-8:00",
                               @"8:00-8:30",
                               @"8:30-9:00",
                               @"9:00-9:30",
                               @"9:30-10:00",
                               @"13:00-13:30",
                               @"13:30-14:00",
                               @"14:00-14:30",
                               @"14:30-15:00",
                               @"15:00-15:30",
                               @"15:30-16:00",
                               @"16:00-16:30",
                               @"17:30-18:00",
                               @"17:00-17:30",
                               @"17:30-18:00",
                               @"18:00-18:30",
                               @"18:30-19:00"];
}

@end
