//
//  PersonalFirstCollectionViewCell.m
//  automaintain
//
//  Created by eric on 16/6/29.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "PersonalFirstCollectionViewCell.h"

@interface PersonalFirstCollectionViewCell()
@property (nonatomic, weak) UIImageView* iconImageView;
@end
@implementation PersonalFirstCollectionViewCell

NSString* const personalFirstId = @"personalFirstId";

+(PersonalFirstCollectionViewCell *)collectionView:(UICollectionView *)collectionView
           dequeueReusableCellWithReuseIdentifier:(NSString *)reuseIdentifier
                                     forIndexPath:(NSIndexPath *)indexPath
{
    PersonalFirstCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier
                                                                                     forIndexPath:indexPath];
    return cell;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor colorWithPatternImage:ImageNamed(@"register_k2")];
        
        UIImageView* iconImageView = [[UIImageView alloc]init];
        iconImageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:iconImageView];
        self.iconImageView = iconImageView;
        
        UILabel* nameLabel = [[UILabel alloc]init];
        nameLabel.font = [UIFont boldSystemFontOfSize:17];
        nameLabel.text = @"奥迪A6L";
        nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:nameLabel];
        
        CGFloat nameWidth = [nameLabel calculateWidthWithLabelContent:nameLabel.text
                                                         WithFontName:nil
                                                         WithFontSize:17
                                                             WithBold:YES];
        
        UILabel* licensePlateNumberLabel = [[UILabel alloc]init];
        licensePlateNumberLabel.textColor = UIColorFromRGB(0x9c9c9c);
        licensePlateNumberLabel.font = [UIFont systemFontOfSize:12];
        licensePlateNumberLabel.text = @"沪A8888888";
        licensePlateNumberLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:licensePlateNumberLabel];
        
        CGFloat licensePlateNumberWidth = [nameLabel calculateWidthWithLabelContent:licensePlateNumberLabel.text
                                                         WithFontName:nil
                                                         WithFontSize:12
                                                             WithBold:NO];
        
        iconImageView.sd_layout.leftSpaceToView(self,ScreenWidth*0.021).centerYEqualToView(self).heightIs(60).widthEqualToHeight();
        nameLabel.sd_layout.leftSpaceToView(iconImageView,10).topSpaceToView(self,15).widthIs(nameWidth).autoHeightRatio(0);
        licensePlateNumberLabel.sd_layout.leftEqualToView(nameLabel).topSpaceToView(nameLabel,5).widthIs(licensePlateNumberWidth).autoHeightRatio(0);
        
    }
    return self;
}

-(void)layoutWithObject:(id)object
{
    if ([object isKindOfClass:[UIImage class]])
    {
        self.iconImageView.image = (UIImage*)object;
    }
}

@end
