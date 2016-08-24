//
//  TimeSelectedHeaderView.m
//  automaintain
//
//  Created by eric on 16/6/30.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "TimeSelectedHeaderView.h"

@interface TimeSelectedHeaderView()
/**
 *  他人已预约文字
 */
@property (nonatomic, weak) UILabel* label;
/**
 *  他人已预约图片
 */
@property (nonatomic, weak) UIImageView* imageView;
/**
 *  我的预约文字
 */
@property (nonatomic, weak) UILabel* myOrderLabel;
/**
 *  我的预约图片
 */
@property (nonatomic, weak) UIImageView* myOrderImageView;
@end
@implementation TimeSelectedHeaderView

NSString* const TimeSelectedHeaderViewId = @"TimeSelectedHeaderViewId";

+(TimeSelectedHeaderView *)collectionView:(UICollectionView *)collectionView dequeueReusableCellWithReuseIdentifier:(NSString *)reuseIdentifier forIndexPath:(NSIndexPath *)indexPath
{
    TimeSelectedHeaderView* cell = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    return cell;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        /**
         他人已预约/可预约文字图片
         */
        UILabel* label = [[UILabel alloc]init];
        label.font = [UIFont systemFontOfSize:11];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:label];
        self.label = label;
        
        UIImageView* imageView = [[UIImageView alloc]init];
        imageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:imageView];
        self.imageView = imageView;
        
        /**
         我的预约文字/图片
         */
        UILabel* myOrderLabel = [[UILabel alloc]init];
        myOrderLabel.font = [UIFont systemFontOfSize:11];
        myOrderLabel.text = @"您的预约";
        myOrderLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:myOrderLabel];
        self.myOrderLabel = myOrderLabel;
        
        UIImageView* myOrderImageView = [[UIImageView alloc]init];
        myOrderImageView.image = ImageNamed(@"order_choose_blue");
        myOrderImageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:myOrderImageView];
        self.myOrderImageView = myOrderImageView;
        
        imageView.sd_layout.leftSpaceToView(self,ScreenWidth*0.037).centerYEqualToView(self).widthIs(18).heightIs(17);
        label.sd_layout.leftSpaceToView(imageView,ScreenWidth*0.026).centerYEqualToView(imageView).topEqualToView(self).bottomEqualToView(self).widthIs(ScreenWidth*0.2);
        
        myOrderImageView.sd_layout.leftSpaceToView(label,ScreenWidth*0.037).centerYEqualToView(imageView).widthIs(18).heightIs(17);
        myOrderLabel.sd_layout.leftSpaceToView(myOrderImageView,ScreenWidth*0.026).centerYEqualToView(imageView).topEqualToView(self).bottomEqualToView(self).widthIs(ScreenWidth*0.2);
    }
    return self;
}

-(void)layoutWithImage:(UIImage *)image withTitle:(NSString *)title withMyOrderHidden:(BOOL)hidden
{
    if (hidden)
    {
        self.myOrderLabel.hidden = YES;
        self.myOrderImageView.hidden = YES;
    }
    else
    {
        self.myOrderLabel.hidden = NO;
        self.myOrderImageView.hidden = NO;
    }
    self.imageView.image = image;
    self.label.text = title;
}

@end
