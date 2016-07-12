//
//  OnlineMessageDataViewController.m
//  automaintain
//
//  Created by eric on 16/6/30.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "OnlineMessageDataViewController.h"
#import "OnlineMessageCollectionViewCell.h"
#import "OnlineMessageSecondCollectionViewCell.h"
#import "MyMessageView.h"

@implementation OnlineMessageDataViewController

-(CustomNavigationView *)customNavigationView
{
    if (!_customNavigationView)
    {
        _customNavigationView = [CustomNavigationView customNavigationViewWithLeftBtnImage:ImageNamed(@"register_back")  withRightBtnImage:nil withTitle:@"在线留言"];
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
        
        [_collectionView registerClass:[OnlineMessageCollectionViewCell class] forCellWithReuseIdentifier:OnlineMessageCollectionViewCellId];
        [_collectionView registerClass:[OnlineMessageSecondCollectionViewCell class] forCellWithReuseIdentifier:OnlineMessageSecondCollectionViewCellId];
        
    }
    return _collectionView;
}

-(UIView *)myMessageView
{
    if (!_myMessageView)
    {
        _myMessageView = [[MyMessageView alloc]init];
    }
    return _myMessageView;
}

@end
