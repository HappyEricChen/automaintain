//
//  FourCollectionViewCell.m
//  一号车库
//
//  Created by eric on 16/6/27.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "FourCollectionViewCell.h"
#import "BottomAdsModel.h"

@interface FourCollectionViewCell()
@property (nonatomic, weak) UIImageView* imageView;
@end
@implementation FourCollectionViewCell

NSString* const fourCellId = @"fourCellId";

+(FourCollectionViewCell *)collectionView:(UICollectionView *)collectionView dequeueReusableCellWithReuseIdentifier:(NSString *)reuseIdentifier forIndexPath:(NSIndexPath *)indexPath
{
    FourCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier
                                                                             forIndexPath:indexPath];
    
    return cell;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UIImageView* imageView = [[UIImageView alloc]init];
        imageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:imageView];
        self.imageView = imageView;
        
        imageView.sd_layout.leftEqualToView(self).rightEqualToView(self).topEqualToView(self).bottomEqualToView(self);
    }
    return self;
}

-(void)layoutWithObject:(id)object
{
    if ([object isKindOfClass:[BottomAdsModel class]])
    {
        BottomAdsModel* bottomAdsModel = (BottomAdsModel*)object;
        
        NSString* completedImageStr = bottomAdsModel.PicUrl;
        NSURL* completedImageUrl = [NSURL URLWithString:completedImageStr];
        [self.imageView sd_setImageWithURL:completedImageUrl];
        
    }
}
@end
