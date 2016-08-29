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
    NSString* imageUrl_1 = [AppManagerSingleton appndingImageUrlWithString:imageUrlStr];
    
    [self.imageView setImageWithURL:[NSURL URLWithString:imageUrl_1]
                        placeholder:ImageNamed(@"personal_img0")
                            options:YYWebImageOptionIgnoreAnimatedImage |YYWebImageOptionIgnoreImageDecoding
                         completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error)
     {
         
     }];
    
}

@end
