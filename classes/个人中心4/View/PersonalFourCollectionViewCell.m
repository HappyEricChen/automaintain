//
//  PersonalFourCollectionViewCell.m
//  automaintain
//
//  Created by eric on 16/6/29.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "PersonalFourCollectionViewCell.h"

@implementation PersonalFourCollectionViewCell

NSString* const personalFourId = @"personalFourId";

+(PersonalFourCollectionViewCell *)collectionView:(UICollectionView *)collectionView
            dequeueReusableCellWithReuseIdentifier:(NSString *)reuseIdentifier
                                      forIndexPath:(NSIndexPath *)indexPath
{
    PersonalFourCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier
                                                                                      forIndexPath:indexPath];
    return cell;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor colorWithPatternImage:ImageNamed(@"personal_k")];
        
        UIImageView* iconImageView = [[UIImageView alloc]initWithImage:ImageNamed(@"personal_contect")];
        iconImageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:iconImageView];
       
        /**
         我的预约
         */
        UILabel* nameLabel = [[UILabel alloc]init];
        nameLabel.font = [UIFont boldSystemFontOfSize:15];
        nameLabel.text = @"联系我们";
        nameLabel.textColor = UIColorFromRGB(0x000000);
        nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:nameLabel];
       
        
        CGFloat nameWidth = [nameLabel calculateWidthWithLabelContent:nameLabel.text
                                                         WithFontName:nil
                                                         WithFontSize:15
                                                             WithBold:YES];
        
        UILabel* rightLabel = [[UILabel alloc]init];
        rightLabel.text = @"4002-9889-888";
        rightLabel.textColor = UIColorFromRGB(0xc64e35);
        rightLabel.font = [UIFont boldSystemFontOfSize:12];
        rightLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:rightLabel];
        
        CGFloat rightLabelWidth = [rightLabel calculateWidthWithLabelContent:rightLabel.text
                                                                WithFontName:nil
                                                                WithFontSize:12
                                                                    WithBold:YES];
        
        
        
        iconImageView.sd_layout.centerYEqualToView(self).leftSpaceToView(self,ScreenWidth*0.045).widthIs(14).heightIs(16);
        nameLabel.sd_layout.centerYEqualToView(iconImageView).leftSpaceToView(iconImageView,18).widthIs(nameWidth).autoHeightRatio(0);
        
        rightLabel.sd_layout.centerYEqualToView(self).rightSpaceToView(self,ScreenWidth*0.045).widthIs(rightLabelWidth).autoHeightRatio(0);
        
        
        
        
    }
    return self;
}

@end
