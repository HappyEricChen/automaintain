//
//  CommentImageCollectionViewCell.m
//  一号车库
//
//  Created by eric on 16/8/25.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "CommentImageCollectionViewCell.h"

@interface CommentImageCollectionViewCell()

@property (nonatomic, weak) UIImageView* imageView;
@end

@implementation CommentImageCollectionViewCell

NSString* const CommentImageCollectionViewCellId = @"CommentImageCollectionViewCellId";

+(CommentImageCollectionViewCell *)collectionView:(UICollectionView *)collectionView dequeueReusableCellWithReuseIdentifier:(NSString *)reuseIdentifier forIndexPath:(NSIndexPath *)indexPath
{
    CommentImageCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    return cell;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UIImageView* imageView = [[YYAnimatedImageView alloc]init];
        self.imageView = imageView;
        [self.contentView addSubview:imageView];
        
        imageView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
        
        
        
    }
    return self;
}

-(void)layoutWithObject:(id)object
{
    NSString* imageUrlStr = (NSString*)object;
    
    /**
     *  高性能设置
     */
//    [self.imageView yy_setImageWithURL:[NSURL URLWithString:imageUrlStr]
//                           placeholder:ImageNamed(@"personal_img0")
//                               options:YYWebImageOptionIgnoreAnimatedImage |YYWebImageOptionIgnoreImageDecoding
//                            completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error)
//     {
//         
//     }];
    
    //SDWebImageRetryFailed ：下载失败后,会重新下载
    //SDWebImageLowPriority ：在用户正在进行用户操作的时候，SDWebImage停止下载图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrlStr]
                      placeholderImage:ImageNamed(@"personal_img0")
                               options:SDWebImageLowPriority | SDWebImageRetryFailed
                             completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
    {
        
    }];
}

@end
