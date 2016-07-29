//
//  PersonalThirdCollectionViewCell.m
//  automaintain
//
//  Created by eric on 16/6/29.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "PersonalThirdCollectionViewCell.h"
@interface PersonalThirdCollectionViewCell()
@property (nonatomic, weak) UIImageView* iconImageView;//图片
@property (nonatomic, weak) UILabel* nameLabel;//名字
@end
@implementation PersonalThirdCollectionViewCell

NSString* const personalThirdId = @"personalThirdId";

+(PersonalThirdCollectionViewCell *)collectionView:(UICollectionView *)collectionView
             dequeueReusableCellWithReuseIdentifier:(NSString *)reuseIdentifier
                                       forIndexPath:(NSIndexPath *)indexPath
{
    PersonalThirdCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier
                                                                                       forIndexPath:indexPath];
    return cell;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundView = [[UIImageView alloc]initWithImage:ImageNamed(@"personal_k")];
        
        UIImageView* iconImageView = [[UIImageView alloc]initWithImage:ImageNamed(@"personal_order")];
        iconImageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:iconImageView];
        self.iconImageView = iconImageView;
        /**
         我的预约
         */
        UILabel* nameLabel = [[UILabel alloc]init];
        nameLabel.font = [UIFont boldSystemFontOfSize:15];
        nameLabel.text = @"我的预约";
        nameLabel.textColor = UIColorFromRGB(0x000000);
        nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        CGFloat nameWidth = [nameLabel calculateWidthWithLabelContent:nameLabel.text
                                                         WithFontName:nil
                                                         WithFontSize:15
                                                             WithBold:YES];
        
        UIButton* rightButton = [[UIButton alloc]init];
        [rightButton setImage:ImageNamed(@"register_arrow_right") forState:UIControlStateNormal];
        rightButton.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:rightButton];
       
        
        
        iconImageView.sd_layout.centerYEqualToView(self).leftSpaceToView(self,ScreenWidth*0.045).widthIs(14).heightIs(16);
        nameLabel.sd_layout.centerYEqualToView(iconImageView).leftSpaceToView(iconImageView,18).widthIs(nameWidth).autoHeightRatio(0);
      
        rightButton.sd_layout.centerYEqualToView(self).rightSpaceToView(self,ScreenWidth*0.045).widthIs(6).heightIs(12);

       
        
        
    }
    return self;
}

-(void)layoutWithObject:(id)object
{
    if ([object isKindOfClass:[NSDictionary class]])
    {
        NSDictionary* dic = (NSDictionary*)object;
        
        self.iconImageView.image = ImageNamed([dic objectForKey:@"image"]);
        self.nameLabel.text = [dic objectForKey:@"name"];
        
    }
}

@end
