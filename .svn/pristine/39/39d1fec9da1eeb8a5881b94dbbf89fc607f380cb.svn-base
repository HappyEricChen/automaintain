//
//  MyCommentViewController.m
//  automaintain
//
//  Created by eric on 16/7/1.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "MyCommentViewController.h"
#import "MyCommentDataViewController.h"
#import "MyCommentFirstCollectionViewCell.h"
#import "MyCommentSecondCollectionViewCell.h"
#import "MyCommentThirdCollectionViewCell.h"

@interface MyCommentViewController ()<CustomNavigationViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) MyCommentDataViewController* myCommentDataViewController;
@end

@implementation MyCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myCommentDataViewController = [[MyCommentDataViewController alloc]init];
    [self configureNavigationView];
    [self configureCollectionView];
}


-(void)configureNavigationView
{
    [self.view addSubview:self.myCommentDataViewController.customNavigationView];
    self.myCommentDataViewController.customNavigationView.delegate = self;
    self.myCommentDataViewController.customNavigationView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topEqualToView(self.view).heightIs(ScreenHeight*0.1);
}

-(void)configureCollectionView
{
    [self.view addSubview:self.myCommentDataViewController.collectionView];
    
    self.myCommentDataViewController.collectionView.delegate = self;
    self.myCommentDataViewController.collectionView.dataSource = self;
    
    self.myCommentDataViewController.collectionView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topSpaceToView(self.myCommentDataViewController.customNavigationView,0).bottomEqualToView(self.view);
    
}

#pragma mark - CustomNavigationViewDelegate
-(void)didSelectedLeftButtonAtCustomNavigationView:(CustomNavigationView *)customNavigationView
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = nil;
    
    if (indexPath.section == 0)
    {
        MyCommentFirstCollectionViewCell * firstCell = [MyCommentFirstCollectionViewCell collectionView:collectionView dequeueReusableCellWithReuseIdentifier:MyCommentFirstCollectionViewCellId forIndexPath:indexPath];
        cell = firstCell;
    }
    else if (indexPath.section == 1)
    {
        MyCommentSecondCollectionViewCell * secondCell = [MyCommentSecondCollectionViewCell collectionView:collectionView dequeueReusableCellWithReuseIdentifier:MyCommentSecondCollectionViewCellId forIndexPath:indexPath];
        cell =secondCell;
    }
    else if (indexPath.section == 2)
    {
        MyCommentThirdCollectionViewCell * thirdCell = [MyCommentThirdCollectionViewCell collectionView:collectionView dequeueReusableCellWithReuseIdentifier:MyCommentThirdCollectionViewCellId forIndexPath:indexPath];
        cell = thirdCell;
    }
    
    return cell;
}

#pragma mark - UICollectionViewFlowLayoutDelegate

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return CGSizeMake(ScreenWidth, ScreenHeight*0.118);
    }
    else if (indexPath.section == 1)
    {
        return CGSizeMake(ScreenWidth, ScreenHeight*0.198);
    }
    else if (indexPath.section == 2)
    {
        return CGSizeMake(ScreenWidth, ScreenHeight*0.049);
    }
    return CGSizeZero;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 1)
    {
        return UIEdgeInsetsMake(ScreenHeight*0.03, 0, 0, 0);
    }
    else if (section == 2)
    {
        return UIEdgeInsetsMake(ScreenHeight*0.055, 0, 0, 0);
    }
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

@end
