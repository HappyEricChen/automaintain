//
//  FirstCollectionViewCell.m
//  一号车库
//
//  Created by eric on 16/6/27.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "FirstCollectionViewCell.h"

@implementation FirstCollectionViewCell

NSString * const firstCellId = @"firstCellId";

+(FirstCollectionViewCell *)collectionView:(UICollectionView *)collectionView
    dequeueReusableCellWithReuseIdentifier:(NSString *)reuseIdentifier
                              forIndexPath:(NSIndexPath *)indexPath
{
    FirstCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier
                                                                              forIndexPath:indexPath];
    return cell;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        NSArray* imageArr = @[@"home_banner",@"home_buttomimg"];
        SDCycleScrollView * cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:self.bounds imageNamesGroup:imageArr];
        cycleScrollView.currentPageDotImage = ImageNamed(@"home_c2");
        cycleScrollView.pageDotImage = ImageNamed(@"home_c1");
        [self addSubview:cycleScrollView];
    }
    return self;
}
@end
