//
//  FeedbackThirdCollectionViewCell.m
//  automaintain
//
//  Created by eric on 16/7/4.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "FeedbackThirdCollectionViewCell.h"

@implementation FeedbackThirdCollectionViewCell

NSString * const FeedbackThirdCollectionViewCellId = @"FeedbackThirdCollectionViewCellId";

+(FeedbackThirdCollectionViewCell *)collectionView:(UICollectionView *)collectionView
            dequeueReusableCellWithReuseIdentifier:(NSString *)reuseIdentifier
                                      forIndexPath:(NSIndexPath *)indexPath
{
    FeedbackThirdCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier
                                                                                      forIndexPath:indexPath];
    return cell;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UIButton* submitButton = [[UIButton alloc]init];
        [submitButton setTitle:@"提交反馈" forState:UIControlStateNormal];
        submitButton.titleLabel.font = [UIFont systemFontOfSize:14];
        submitButton.userInteractionEnabled = NO;
        [submitButton setBackgroundImage:ImageNamed(@"register_commit") forState:UIControlStateNormal];
        submitButton.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:submitButton];
        
        submitButton.sd_layout.leftSpaceToView(self,ScreenWidth*0.04).rightSpaceToView(self,ScreenWidth*0.04).topEqualToView(self).heightIs(ScreenHeight*0.049);
    }
    return self;
}

@end
