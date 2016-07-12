//
//  MyCommentDataViewController.m
//  automaintain
//
//  Created by eric on 16/7/1.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "MyCommentDataViewController.h"
#import "MyCommentFirstCollectionViewCell.h"
#import "MyCommentSecondCollectionViewCell.h"
#import "MyCommentThirdCollectionViewCell.h"

@implementation MyCommentDataViewController

-(CustomNavigationView *)customNavigationView
{
    if (!_customNavigationView)
    {
        _customNavigationView = [CustomNavigationView customNavigationViewWithLeftBtnImage:ImageNamed(@"register_back") withRightBtnImage:nil withTitle:@"发布评论"];
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
        
        [_collectionView registerClass:[MyCommentFirstCollectionViewCell class] forCellWithReuseIdentifier:MyCommentFirstCollectionViewCellId];
        [_collectionView registerClass:[MyCommentSecondCollectionViewCell class] forCellWithReuseIdentifier:MyCommentSecondCollectionViewCellId];
        [_collectionView registerClass:[MyCommentThirdCollectionViewCell class] forCellWithReuseIdentifier:MyCommentThirdCollectionViewCellId];        
        
    }
    return _collectionView;
}

@end
