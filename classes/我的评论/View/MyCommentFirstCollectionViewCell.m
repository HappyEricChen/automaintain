//
//  MyCommentFirstCollectionViewCell.m
//  automaintain
//
//  Created by eric on 16/7/1.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "MyCommentFirstCollectionViewCell.h"

@implementation MyCommentFirstCollectionViewCell

NSString * const MyCommentFirstCollectionViewCellId = @"MyCommentFirstCollectionViewCellId";

+(MyCommentFirstCollectionViewCell *)collectionView:(UICollectionView *)collectionView
    dequeueReusableCellWithReuseIdentifier:(NSString *)reuseIdentifier
                              forIndexPath:(NSIndexPath *)indexPath
{
    MyCommentFirstCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier
                                                                              forIndexPath:indexPath];
    return cell;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        UILabel* titleLabel = [[UILabel alloc]init];
        titleLabel.text = @"预约类型：";
        titleLabel.font = [UIFont boldSystemFontOfSize:14];
        titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:titleLabel];
        
        CGFloat titleLabelWidth = [titleLabel calculateWidthWithLabelContent:titleLabel.text
                                                              WithFontName:nil
                                                              WithFontSize:14
                                                                  WithBold:YES];
        
        UILabel* scoreLabel = [[UILabel alloc]init];
        scoreLabel.text = @"评分：";
        scoreLabel.font = [UIFont boldSystemFontOfSize:14];
        scoreLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:scoreLabel];
        
        CGFloat scoreLabelWidth = [scoreLabel calculateWidthWithLabelContent:scoreLabel.text
                                                                WithFontName:nil
                                                                WithFontSize:14
                                                                    WithBold:YES];
        
        UIView *baseView1 = [[UIView alloc]init];
        baseView1.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:baseView1];
        
        
        for (NSInteger i=0; i<5; i++)
        {
            UIImageView* starImageView = [[UIImageView alloc]initWithImage:ImageNamed(@"order_star")];
            
            starImageView.frame = CGRectMake(5+13*i, 1, 13, 13);
            [baseView1 addSubview:starImageView];
            
        }
        
        
        
        UILabel* contentLabel = [[UILabel alloc]init];
        contentLabel.text = @"维修/更换轮胎";
        contentLabel.font = [UIFont systemFontOfSize:14];
        contentLabel.textColor = UIColorFromRGB(0x929292);
        contentLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:contentLabel];
        
        titleLabel.sd_layout.leftSpaceToView(self,ScreenWidth*0.03).topSpaceToView(self,ScreenHeight*0.024).widthIs(titleLabelWidth).autoHeightRatio(0);
        contentLabel.sd_layout.leftSpaceToView(titleLabel,10).topEqualToView(titleLabel).rightEqualToView(self).autoHeightRatio(0);
        scoreLabel.sd_layout.leftEqualToView(titleLabel).topSpaceToView(titleLabel,ScreenHeight*0.03).widthIs(scoreLabelWidth).autoHeightRatio(0);
        baseView1.sd_layout.centerYEqualToView(scoreLabel).leftSpaceToView(scoreLabel,10).topEqualToView(scoreLabel).bottomEqualToView(scoreLabel).rightEqualToView(self);
    }
    return self;
}

@end
