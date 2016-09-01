//
//  CommonCollectionViewCell.m
//  automaintain
//
//  Created by eric on 16/6/27.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "CommonCollectionViewCell.h"
@interface CommonCollectionViewCell()

@property (nonatomic, weak) UILabel* label;
@end
@implementation CommonCollectionViewCell

NSString* const commonCellId = @"commonCellId";

+(CommonCollectionViewCell *)collectionView:(UICollectionView *)collectionView dequeueReusableCellWithReuseIdentifier:(NSString *)reuseIdentifier forIndexPath:(NSIndexPath *)indexPath
{
    CommonCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    return cell;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UILabel* label = [[UILabel alloc]init];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:10];
        label.layer.borderColor = UIColorFromRGB(0x7b7b7b).CGColor;
        label.layer.borderWidth = 0.5f;
        label.layer.cornerRadius = 2;
        [self addSubview:label];
        self.label = label;
        
        label.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    }
    return self;
}

-(void)layoutWithObject:(id)object
{
    if ([object isKindOfClass:[NSString class]])
    {
        self.label.text = (NSString*)object;
    }
}
-(void)layoutTextColorWithColor:(UIColor *)textColor
{
    if ([textColor isKindOfClass:[UIColor class]])
    {
        self.label.textColor = textColor;
    }
}

-(void)layoutBackgroundColorWithColor:(UIColor *)Color
{
    if ([Color isKindOfClass:[UIColor class]])
    {
        self.label.backgroundColor = Color;
    }
}
@end
