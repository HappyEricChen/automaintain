//
//  HomeDataViewController.m
//  一号车库
//
//  Created by eric on 16/6/24.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "HomeDataViewController.h"
#import "FirstCollectionViewCell.h"
#import "SecondCollectionViewCell.h"
#import "ThirdCollectionViewCell.h"
#import "FourCollectionViewCell.h"

@implementation HomeDataViewController

-(CustomNavigationView *)customNavigationView
{
    if (!_customNavigationView)
    {
        _customNavigationView = [CustomNavigationView homeCustomNavigationViewWithLeftBtnImage:ImageNamed(@"home_Location") withRightBtnImage:nil withTitle:@"欢迎进入凯旋花苑一号车库社区汽车服务站"];
    }
    return _customNavigationView;
}

-(UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor clearColor];
        
        [_collectionView registerClass:[FirstCollectionViewCell class] forCellWithReuseIdentifier:firstCellId];
        [_collectionView registerClass:[SecondCollectionViewCell class] forCellWithReuseIdentifier:secondCellId];
        [_collectionView registerClass:[ThirdCollectionViewCell class] forCellWithReuseIdentifier:thirdCellId];
        [_collectionView registerClass:[FourCollectionViewCell class] forCellWithReuseIdentifier:fourCellId];
        
        
    }
    return _collectionView;
}


@end
