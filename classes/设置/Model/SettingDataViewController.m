//
//  SettingDataViewController.m
//  automaintain
//
//  Created by eric on 16/7/4.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "SettingDataViewController.h"
#import "SettingFirstCollectionViewCell.h"
#import "SettingSecondCollectionViewCell.h"

@implementation SettingDataViewController

-(CustomNavigationView *)customNavigationView
{
    if (!_customNavigationView)
    {
        _customNavigationView = [CustomNavigationView customNavigationViewWithLeftBtnImage:ImageNamed(@"register_back") withRightBtnImage:nil withTitle:@"设置"];
    }
    return _customNavigationView;
}

-(UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
       _collectionView.backgroundColor = UIColorFromRGB(0xf4f4f4);
        
        [_collectionView registerClass:[SettingFirstCollectionViewCell class] forCellWithReuseIdentifier:SettingFirstCollectionViewCellId];
        [_collectionView registerClass:[SettingSecondCollectionViewCell class] forCellWithReuseIdentifier:SettingSecondCollectionViewCellId];
    }
    return _collectionView;
}

@end
