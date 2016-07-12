//
//  TimeSelectedHeaderView.m
//  automaintain
//
//  Created by eric on 16/6/30.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "TimeSelectedHeaderView.h"

@interface TimeSelectedHeaderView()

@property (nonatomic, weak) UILabel* label;

@property (nonatomic, weak) UIImageView* imageView;
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
        
        imageView.sd_layout.leftSpaceToView(self,ScreenWidth*0.037).centerYEqualToView(self).widthIs(18).heightIs(17);
        label.sd_layout.leftSpaceToView(imageView,10).centerYEqualToView(imageView).topEqualToView(self).bottomEqualToView(self).widthIs(ScreenWidth*0.5);
    }
    return self;
}

-(void)layoutWithImage:(UIImage*)image WithTitle:(NSString*)title
{
    self.imageView.image = image;
    self.label.text = title;
}

@end
