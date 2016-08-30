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
/**
 *  汽车品牌+型号，没有数据用用户名占位
 */
@property (nonatomic, weak) UILabel* nameLabel;
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
        self.backgroundView = [[UIImageView alloc]initWithImage:ImageNamed(@"register_k2")];
        
        
        UIImageView* iconImageView = [[UIImageView alloc]init];
        iconImageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:iconImageView];
        self.iconImageView = iconImageView;
        
        UILabel* nameLabel = [[UILabel alloc]init];
        nameLabel.font = [UIFont boldSystemFontOfSize:17];
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        UILabel* licensePlateNumberLabel = [[UILabel alloc]init];
        licensePlateNumberLabel.textColor = UIColorFromRGB(0x9c9c9c);
        licensePlateNumberLabel.font = [UIFont systemFontOfSize:12];
        licensePlateNumberLabel.textAlignment = NSTextAlignmentLeft;
        licensePlateNumberLabel.text = AppManagerSingleton.CarNo;
        licensePlateNumberLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:licensePlateNumberLabel];
        
        CGFloat licensePlateNumberWidth = [nameLabel calculateWidthWithLabelContent:licensePlateNumberLabel.text
                                                         WithFontName:nil
                                                         WithFontSize:12
                                                             WithBold:NO];
        
        iconImageView.sd_layout.leftSpaceToView(self,ScreenWidth*0.021).centerYEqualToView(self).heightIs(60).widthEqualToHeight();
        nameLabel.sd_layout.leftSpaceToView(iconImageView,ScreenWidth*0.0267).topSpaceToView(self,ScreenHeight*0.03).rightSpaceToView(self,ScreenWidth*0.0267).autoHeightRatio(0);
        licensePlateNumberLabel.sd_layout.leftEqualToView(nameLabel).topSpaceToView(nameLabel,ScreenHeight*0.015).widthIs(licensePlateNumberWidth).autoHeightRatio(0);
        
    }
    return self;
}

-(void)layoutWithObject:(id)object
{
    if ([object isKindOfClass:[NSString class]])
    {
        [self.iconImageView setImageWithURL:[NSURL URLWithString:object] placeholder:ImageNamed(@"personal_img0") options:YYWebImageOptionShowNetworkActivity completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error)
         {
             
         }];
    }
    
    if (!AppManagerSingleton.CarBrand)
    {
        self.nameLabel.text = AppManagerSingleton.userName;
    }
    else
    {
        self.nameLabel.text = [NSString stringWithFormat:@"%@%@",AppManagerSingleton.CarBrand,AppManagerSingleton.CarModel];
    }
}

@end
