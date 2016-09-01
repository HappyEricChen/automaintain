//
//  SettingFirstCollectionViewCell.m
//  automaintain
//
//  Created by eric on 16/7/4.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "SettingFirstCollectionViewCell.h"

@interface SettingFirstCollectionViewCell()

@property (nonatomic, weak) UILabel* contentLabel;
@property (nonatomic, weak) UIImageView* iconImageView;
@end
@implementation SettingFirstCollectionViewCell

NSString * const SettingFirstCollectionViewCellId = @"SettingFirstCollectionViewCellId";

+(SettingFirstCollectionViewCell *)collectionView:(UICollectionView *)collectionView
             dequeueReusableCellWithReuseIdentifier:(NSString *)reuseIdentifier
                                       forIndexPath:(NSIndexPath *)indexPath
{
    SettingFirstCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier
                                                                                       forIndexPath:indexPath];
    return cell;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor colorWithPatternImage:ImageNamed(@"set_k")];
        
        UIImageView* iconImageView = [[UIImageView alloc]init];
        [self addSubview:iconImageView];
        self.iconImageView = iconImageView;
        
        UILabel* contentLabel = [[UILabel alloc]init];
        contentLabel.font = [UIFont boldSystemFontOfSize:12];
        [self addSubview:contentLabel];
        self.contentLabel = contentLabel;
        
        UIImageView* arrowImageView = [[UIImageView alloc]initWithImage:ImageNamed(@"set_arrow_right")];
        [self addSubview:arrowImageView];
        
        iconImageView.sd_layout.leftSpaceToView(self,ScreenWidth*0.032).centerYEqualToView(self).widthIs(21).heightIs(22);
        contentLabel.sd_layout.leftSpaceToView(iconImageView,ScreenWidth*0.04).centerYEqualToView(self).widthIs(ScreenWidth*0.18).autoHeightRatio(0);
        
        arrowImageView.sd_layout.rightSpaceToView(self,ScreenWidth*0.04).centerYEqualToView(self).widthIs(6).heightIs(13);
    }
    return self;
}

-(void)layoutWithObject:(id)object
{
    if ([object isKindOfClass:[NSDictionary class]])
    {
        NSDictionary* dic = (NSDictionary*)object;
        
        self.contentLabel.text = [dic objectForKey:@"title"];
        self.iconImageView.image = ImageNamed([dic objectForKey:@"image"]);
    }
}
@end
