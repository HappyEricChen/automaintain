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
    NSURL* completedImageUrl;
    if ([object isKindOfClass:[BottomAdsModel class]])
    {
        BottomAdsModel* bottomAdsModel = (BottomAdsModel*)object;
        
        NSString* completedImageStr = bottomAdsModel.PicUrl;
        completedImageUrl = [NSURL URLWithString:completedImageStr];
    }
    /**
     *  设置启动时的背景图
     */
    
    [self.imageView setImageWithURL:completedImageUrl
                        placeholder:ImageNamed(@"home_buttom_img0")
                            options:YYWebImageOptionShowNetworkActivity
                         completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error)
    {
        /**
         *  回调刷新cell高度
         */
    }];
}
@end
