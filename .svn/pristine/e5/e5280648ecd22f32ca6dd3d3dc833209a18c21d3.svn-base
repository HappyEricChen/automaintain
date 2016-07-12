//
//  PersonalSecondCollectionViewCell.m
//  automaintain
//
//  Created by eric on 16/6/29.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "PersonalSecondCollectionViewCell.h"

@implementation PersonalSecondCollectionViewCell

NSString* const personalSecondId = @"personalSecondId";

+(PersonalSecondCollectionViewCell *)collectionView:(UICollectionView *)collectionView
            dequeueReusableCellWithReuseIdentifier:(NSString *)reuseIdentifier
                                      forIndexPath:(NSIndexPath *)indexPath
{
    PersonalSecondCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier
                                                                                      forIndexPath:indexPath];
    return cell;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor colorWithPatternImage:ImageNamed(@"personal_k")];
        
        UIImageView* iconImageView = [[UIImageView alloc]initWithImage:ImageNamed(@"register_Location")];
        iconImageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:iconImageView];
        /**
         欢迎进入凯旋花苑一号车库社区汽车服务站
         */
        UILabel* nameLabel = [[UILabel alloc]init];
        nameLabel.font = [UIFont boldSystemFontOfSize:12];
        nameLabel.text = @"欢迎进入凯旋花苑一号车库社区汽车服务站";
        nameLabel.textColor = UIColorFromRGB(0x9c9c9c);
        nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:nameLabel];
        
        CGFloat nameWidth = [nameLabel calculateWidthWithLabelContent:nameLabel.text
                                                         WithFontName:nil
                                                         WithFontSize:12
                                                             WithBold:NO];
        
        
        iconImageView.sd_layout.centerYEqualToView(self).leftSpaceToView(self,ScreenWidth*0.045).widthIs(13).heightIs(16);
        nameLabel.sd_layout.centerYEqualToView(iconImageView).leftSpaceToView(iconImageView,9).widthIs(nameWidth).autoHeightRatio(0);
       
        
    }
    return self;
}



@end
