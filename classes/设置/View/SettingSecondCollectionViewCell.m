//
//  SettingSecondCollectionViewCell.m
//  automaintain
//
//  Created by eric on 16/7/4.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "SettingSecondCollectionViewCell.h"

@implementation SettingSecondCollectionViewCell

NSString * const SettingSecondCollectionViewCellId = @"SettingSecondCollectionViewCellId";

+(SettingSecondCollectionViewCell *)collectionView:(UICollectionView *)collectionView
           dequeueReusableCellWithReuseIdentifier:(NSString *)reuseIdentifier
                                     forIndexPath:(NSIndexPath *)indexPath
{
    SettingSecondCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier
                                                                                     forIndexPath:indexPath];
    return cell;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UIButton* submitButton = [[UIButton alloc]init];
        [submitButton setTitle:@"退出登录" forState:UIControlStateNormal];
        submitButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [submitButton addTarget:self action:@selector(clickSubmitBtn) forControlEvents:UIControlEventTouchUpInside];
        [submitButton setBackgroundImage:ImageNamed(@"register_commit") forState:UIControlStateNormal];
        [self addSubview:submitButton];
        
        submitButton.sd_layout.leftSpaceToView(self,ScreenWidth*0.032).rightSpaceToView(self,ScreenWidth*0.032).topEqualToView(self).heightIs(ScreenHeight*0.049);
    }
    return self;
}

-(void)clickSubmitBtn
{
    if ([self.delegate respondsToSelector:@selector(didClickSubmitButtonWithSettingSecondCollectionViewCell:)])
    {
        [self.delegate didClickSubmitButtonWithSettingSecondCollectionViewCell:self];
    }
}

@end
