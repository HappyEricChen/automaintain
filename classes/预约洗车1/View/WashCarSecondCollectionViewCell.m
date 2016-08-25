//
//  WashCarSecondCollectionViewCell.m
//  一号车库
//
//  Created by eric on 16/6/28.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "WashCarSecondCollectionViewCell.h"
#import "CommonCollectionView.h"

@interface WashCarSecondCollectionViewCell()

@property (nonatomic, strong) CommonCollectionView* commonCollectionView;
@end
@implementation WashCarSecondCollectionViewCell

NSString* const WashCarSecondId = @"WashCarSecondId";

+(WashCarSecondCollectionViewCell *)collectionView:(UICollectionView *)collectionView
           dequeueReusableCellWithReuseIdentifier:(NSString *)reuseIdentifier
                                     forIndexPath:(NSIndexPath *)indexPath
{
    WashCarSecondCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier
                                                                                     forIndexPath:indexPath];
    return cell;
}


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        self.backgroundColor = UIColorFromRGB(0xf6f6f6);
        /**
         可预约／您的预约／他人已预约
         */
        UIButton* button1 = [[UIButton alloc]init];
        [button1 setTitle:@"可预约" forState:UIControlStateNormal];
        [button1 setImage:ImageNamed(@"order_choose_white") forState:UIControlStateNormal];
        button1.titleLabel.font = [UIFont systemFontOfSize:12];
        button1.clipsToBounds = YES;
        [button1 setTitleColor:UIColorFromRGB(0x000000) forState:UIControlStateNormal];
        [button1 setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
        [self addSubview:button1];
        
        UIButton* button2 = [[UIButton alloc]init];
        [button2 setTitle:@"您的预约" forState:UIControlStateNormal];
        [button2 setImage:ImageNamed(@"order_choose_blue") forState:UIControlStateNormal];
        button2.titleLabel.font = [UIFont systemFontOfSize:12];
        button2.clipsToBounds = YES;
        [button2 setTitleColor:UIColorFromRGB(0x000000) forState:UIControlStateNormal];
        [button2 setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
        [self addSubview:button2];
        
        UIButton* button3 = [[UIButton alloc]init];
        [button3 setTitle:@"他人已预约" forState:UIControlStateNormal];
        [button3 setImage:ImageNamed(@"order_choose_red") forState:UIControlStateNormal];
        button3.titleLabel.font = [UIFont systemFontOfSize:12];
        button3.clipsToBounds = YES;
        [button3 setTitleColor:UIColorFromRGB(0x000000) forState:UIControlStateNormal];
        [button3 setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
        [self addSubview:button3];
        
                
        button1.sd_layout.leftSpaceToView(self,ScreenWidth*0.05).topSpaceToView(self,8).heightIs(ScreenHeight*0.028).widthIs(ScreenWidth*0.293);
        button2.sd_layout.leftSpaceToView(button1,ScreenWidth*0.01).topSpaceToView(self,8).bottomEqualToView(button1).widthIs(ScreenWidth*0.294);
        button3.sd_layout.leftSpaceToView(button2,ScreenWidth*0.01).topSpaceToView(self,8).bottomEqualToView(button2).widthIs(ScreenWidth*0.295);
        
    }
    return self;
}



@end
