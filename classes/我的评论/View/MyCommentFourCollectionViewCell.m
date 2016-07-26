//
//  MyCommentFourCollectionViewCell.m
//  一号车库
//
//  Created by eric on 16/7/26.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "MyCommentFourCollectionViewCell.h"

@implementation MyCommentFourCollectionViewCell

NSString * const MyCommentFourCollectionViewCellId = @"MyCommentFourCollectionViewCellId";

+(MyCommentFourCollectionViewCell *)collectionView:(UICollectionView *)collectionView
             dequeueReusableCellWithReuseIdentifier:(NSString *)reuseIdentifier
                                       forIndexPath:(NSIndexPath *)indexPath
{
    MyCommentFourCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier
                                                                                       forIndexPath:indexPath];
    return cell;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UIButton* submitButton = [[UIButton alloc]init];
        [submitButton setTitle:@"提交评论" forState:UIControlStateNormal];
        submitButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        submitButton.userInteractionEnabled = NO;
        [submitButton setBackgroundImage:ImageNamed(@"register_commit") forState:UIControlStateNormal];
        submitButton.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:submitButton];
        
        submitButton.sd_layout.leftSpaceToView(self,ScreenWidth*0.032).rightSpaceToView(self,ScreenWidth*0.032).topEqualToView(self).heightIs(ScreenHeight*0.049);
        
    }
    return self;
}


@end
