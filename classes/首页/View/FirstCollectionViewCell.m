//
//  FirstCollectionViewCell.m
//  一号车库
//
//  Created by eric on 16/6/27.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "FirstCollectionViewCell.h"
#import "AdsCarouselModel.h"

@interface FirstCollectionViewCell()<SDCycleScrollViewDelegate>
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
        cycleScrollView.delegate = self;
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
        /**
         *  轮播图最多6张
         */
        for (NSInteger i=0; i<MIN(6, adsModelArr.count); i++)
        {
            AdsCarouselModel* adsCarousel  = adsModelArr[i];
            
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
#pragma mark - 点击轮播图调用
-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    if ([self.delegate respondsToSelector:@selector(didSelectedImageWithFirstCollectionViewCell:withItemAtIndex:)])
    {
        [self.delegate didSelectedImageWithFirstCollectionViewCell:self withItemAtIndex:index];
    }
}
@end
