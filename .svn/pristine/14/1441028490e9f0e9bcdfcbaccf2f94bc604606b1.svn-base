//
//  OnlineMessageSecondCollectionViewCell.m
//  automaintain
//
//  Created by eric on 16/7/1.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "OnlineMessageSecondCollectionViewCell.h"

@implementation OnlineMessageSecondCollectionViewCell

NSString* const OnlineMessageSecondCollectionViewCellId = @"OnlineMessageSecondCollectionViewCellId";

+(OnlineMessageSecondCollectionViewCell *)collectionView:(UICollectionView *)collectionView
            dequeueReusableCellWithReuseIdentifier:(NSString *)reuseIdentifier
                                      forIndexPath:(NSIndexPath *)indexPath
{
    OnlineMessageSecondCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier
                                                                                      forIndexPath:indexPath];
    return cell;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        UIButton* submitButton = [[UIButton alloc]init];
        [submitButton setBackgroundImage:ImageNamed(@"register_commit") forState:UIControlStateNormal];
        [submitButton setTitle:@"我要留言" forState:UIControlStateNormal];
        submitButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        submitButton.translatesAutoresizingMaskIntoConstraints = NO;
        submitButton.userInteractionEnabled = NO;
        [self addSubview:submitButton];
        
        submitButton.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
        
        
    }
    return self;
}

@end
