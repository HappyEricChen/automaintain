//
//  MaintenanceDataViewController.m
//  automaintain
//
//  Created by eric on 16/6/29.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "MaintenanceDataViewController.h"
#import "MaintenanceHeaderView.h"
#import "WashCarFiveCollectionViewCell.h"
#import "CommentHeaderView.h"

@implementation MaintenanceDataViewController

-(CustomNavigationView *)customNavigationView
{
    if (!_customNavigationView)
    {
        _customNavigationView = [CustomNavigationView customNavigationViewWithLeftBtnImage:ImageNamed(@"register_back")  withRightBtnImage:nil withTitle:@"维修保养"];
    }
    return _customNavigationView;
}

-(UIView *)maintenanceHeaderView
{
    if (!_maintenanceHeaderView)
    {
        _maintenanceHeaderView = [[MaintenanceHeaderView alloc]init];
    }
    return _maintenanceHeaderView;
}

-(UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor clearColor];
        
        [_collectionView registerClass:[WashCarFiveCollectionViewCell class] forCellWithReuseIdentifier:WashCarFiveCollectionViewCellId];
        
        [_collectionView registerClass:[CommentHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerId];
    }
    return _collectionView;
}

@end
