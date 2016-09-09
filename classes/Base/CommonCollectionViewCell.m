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
    
    cell.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    cell.layer.shadowOffset = CGSizeMake(5, 2.5);//阴影偏移位置
    cell.layer.shadowRadius = 4.0f;
    cell.layer.shadowOpacity = 0.5f;
    cell.layer.masksToBounds = NO;
    cell.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:cell.bounds cornerRadius:cell.contentView.layer.cornerRadius].CGPath;
    return cell;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UILabel* label = [[UILabel alloc]init];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = FONT_KAITI(13);
        label.textColor = UIColorFromRGB(0x423d3d);
        label.backgroundColor = [UIColor whiteColor];
        label.layer.masksToBounds = YES;
        [self.contentView addSubview:label];
        self.label = label;
        
        label.sd_layout.leftSpaceToView(self.contentView,0).rightSpaceToView(self.contentView,0).topSpaceToView(self.contentView,0).bottomSpaceToView(self.contentView,0);
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

@end
