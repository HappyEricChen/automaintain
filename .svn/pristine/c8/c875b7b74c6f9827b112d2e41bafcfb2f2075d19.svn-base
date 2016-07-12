//
//  FeedbackDataViewController.m
//  automaintain
//
//  Created by eric on 16/7/4.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "FeedbackDataViewController.h"
#import "FeedbackFirstCollectionViewCell.h"
#import "FeedbackSecondCollectionViewCell.h"
#import "FeedbackThirdCollectionViewCell.h"

@implementation FeedbackDataViewController

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
        _collectionView.backgroundColor = UIColorFromRGB(0xf4f4f4);
        
        [_collectionView registerClass:[FeedbackFirstCollectionViewCell class] forCellWithReuseIdentifier:FeedbackFirstCollectionViewCellId];
        [_collectionView registerClass:[FeedbackSecondCollectionViewCell class] forCellWithReuseIdentifier:FeedbackSecondCollectionViewCellId];
        [_collectionView registerClass:[FeedbackThirdCollectionViewCell class] forCellWithReuseIdentifier:FeedbackThirdCollectionViewCellId];
    }
    return _collectionView;
}


-(UITableView *)listTableView
{
    if (!_listTableView)
    {
        _listTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];

    }
    return _listTableView;
}
@end
