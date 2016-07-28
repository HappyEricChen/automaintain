//
//  FirstCollectionViewCell.m
//  一号车库
//
//  Created by eric on 16/6/27.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "FirstCollectionViewCell.h"
#import "AdsCarouselModel.h"

@interface FirstCollectionViewCell()
@property (nonatomic, weak) SDCycleScrollView* cycleScrollView;
@end
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
        SDCycleScrollView * cycleScrollView = [[SDCycleScrollView alloc]initWithFrame:self.bounds];
        cycleScrollView.currentPageDotImage = ImageNamed(@"home_c2");
        cycleScrollView.pageDotImage = ImageNamed(@"home_c1");
        [self addSubview:cycleScrollView];
        self.cycleScrollView = cycleScrollView;
    }
    return self;
}

-(void)layoutWithObject:(id)object
{
    if ([object isKindOfClass:[NSArray class]])
    {
        NSArray* adsModelArr = (NSArray*)object;
        NSMutableArray* imageArr = [NSMutableArray array];
        for (AdsCarouselModel* adsCarousel in adsModelArr)
        {
            NSString* completeUrl = adsCarousel.PicUrl;
            [imageArr addObject:completeUrl];
        }
        /**
         *  设置轮播占位图
         */
        [self.cycleScrollView setPlaceholderImage:ImageNamed(@"home_banner_img0")];
        [self.cycleScrollView setImageURLStringsGroup:imageArr];
        
    }
}
@end
