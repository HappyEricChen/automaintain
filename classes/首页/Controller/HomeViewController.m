//
//  HomeViewController.m
//  一号车库
//
//  Created by eric on 16/6/24.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeDataViewController.h"
#import "FirstCollectionViewCell.h"
#import "SecondCollectionViewCell.h"
#import "ThirdCollectionViewCell.h"
#import "FourCollectionViewCell.h"
#import "OrderCarViewController.h"
#import "PersonalViewController.h"
#import "MaintenanceViewController.h"
#import "MyOrderViewController.h"
#import "AdsCarouselModel.h"
#import "WebViewController.h"
#import "BottomAdsModel.h"

@interface HomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,SecondCollectionViewCellDelegate,FirstCollectionViewCellDelegate>
@property (nonatomic, strong) HomeDataViewController* homeDataViewController;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.homeDataViewController = [[HomeDataViewController alloc]init];
    [self configureNavigationView];
    [self configureCollectionView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadDataFromService];
}

-(void)loadDataFromService
{
    if (AppManagerSingleton.accessCode)
    {
        /**
         *  更新导航栏的文字
         */
        [self.homeDataViewController.customNavigationView refreshTitleLabel];
        /**
         *  轮播请求
         */
        [self.homeDataViewController postListofAdsCarouselWithAccessCode:AppManagerSingleton.accessCode withCallback:^(BOOL success, NSError *error, id result)
         {
             if (success)
             {
                 [self.homeDataViewController.collectionView reloadData];
             }
             else
             {
                 
             }
        }];
        /**
         *  便民服务列表
         */
        [self.homeDataViewController postListofConvenienceServiceWithAccessCode:AppManagerSingleton.accessCode withCallback:^(BOOL success, NSError *error, id result)
         {
             if (success)
             {
                 [self.homeDataViewController.collectionView reloadData];
             }
             else
             {
                 
             }
         }];
        /**
         *  底部广告图
         */
        [self.homeDataViewController postListofBottomAdsWithAccessCode:AppManagerSingleton.accessCode withCallback:^(BOOL success, NSError *error, id result)
         {
             if (success)
             {
                 [self.homeDataViewController.collectionView reloadData];
             }
             else
             {
                 [SVProgressHUD showInfoWithStatus:result];
             }
         }];
    }
}
-(void)configureNavigationView
{
    [self.view addSubview:self.homeDataViewController.customNavigationView];
    
    self.homeDataViewController.customNavigationView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topEqualToView(self.view).heightIs(ScreenHeight*0.1);
}

-(void)configureCollectionView
{
    [self.view addSubview:self.homeDataViewController.collectionView];
    
    self.homeDataViewController.collectionView.delegate = self;
    self.homeDataViewController.collectionView.dataSource = self;
    
    self.homeDataViewController.collectionView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topSpaceToView(self.homeDataViewController.customNavigationView,0).bottomEqualToView(self.view);
    
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 4;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 3)
    {
        return self.homeDataViewController.bottomAdsArr.count>0?self.homeDataViewController.bottomAdsArr.count:1;
    }
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BaseCollectionViewCell * cell;
    id object = nil;
    if (indexPath.section == 0)
    {
         FirstCollectionViewCell * firstCell = [FirstCollectionViewCell collectionView:collectionView dequeueReusableCellWithReuseIdentifier:firstCellId forIndexPath:indexPath];
        firstCell.delegate = self;
        object = self.homeDataViewController.adsCarouselArr;
        cell = firstCell;
    }
    else if (indexPath.section == 1)
    {
        SecondCollectionViewCell * secondCell = [SecondCollectionViewCell collectionView:collectionView dequeueReusableCellWithReuseIdentifier:secondCellId forIndexPath:indexPath];
        secondCell.delegate = self;
        cell =secondCell;
    }
    else if (indexPath.section == 2)
    {
        ThirdCollectionViewCell * thirdCell = [ThirdCollectionViewCell collectionView:collectionView dequeueReusableCellWithReuseIdentifier:thirdCellId forIndexPath:indexPath];
        object = self.homeDataViewController.convenienceServiceArr;
        cell = thirdCell;
    }
    else
    {
        FourCollectionViewCell * fourCell = [FourCollectionViewCell collectionView:collectionView dequeueReusableCellWithReuseIdentifier:fourCellId forIndexPath:indexPath];
        object = self.homeDataViewController.bottomAdsArr[indexPath.row];
        cell = fourCell;
    }
   
    [cell layoutWithObject:object];
    return cell;
}

#pragma mark - UICollectionViewFlowLayoutDelegate

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return CGSizeMake(ScreenWidth, ScreenHeight*0.28);
    }
    else if (indexPath.section == 1)
    {
        return CGSizeMake(ScreenWidth, ScreenHeight*0.159);
    }
    else if (indexPath.section == 2)
    {
        return CGSizeMake(ScreenWidth, ScreenHeight*0.223);
    }
    else if (indexPath.section == 3)
    {
        return CGSizeMake(ScreenWidth, ScreenHeight*0.2);
    }
    return CGSizeZero;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 2)
    {
        return UIEdgeInsetsMake(ScreenHeight*0.015, 0, 0, 0);
    }
    else if (section == 3)
    {
        return UIEdgeInsetsMake(ScreenHeight*0.025, 0, 0, 0);
    }
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
#pragma mark - UICollectionViewDelegate 点击底部广告调用
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 3)
    {
        BottomAdsModel* bottomAdsModel = self.homeDataViewController.bottomAdsArr[indexPath.row];
        
        WebViewController* webViewController = [[WebViewController alloc]init];
        webViewController.urlStr = bottomAdsModel.Url;
        webViewController.webTitle = bottomAdsModel.Title;
        [self.navigationController pushViewController:webViewController animated:YES];
    }
}

#pragma mark - SecondCollectionViewCellDelegate

-(void)didSelectedOrderCarButtonWithSecondCollectionViewCell:(SecondCollectionViewCell *)secondCollectionViewCell
{
    OrderCarViewController* orderCarViewController = [[OrderCarViewController alloc]init];
    
    [self.navigationController pushViewController:orderCarViewController animated:YES];
}

-(void)didSelectedPersonalButtonWithSecondCollectionViewCell:(SecondCollectionViewCell *)secondCollectionViewCell
{
    PersonalViewController* personalViewController = [[PersonalViewController alloc]init];
    
    [self.navigationController pushViewController:personalViewController animated:YES];
}
/**
 *  预约维修
 */
-(void)didSelectedMaintenanceButtonWithSecondCollectionViewCell:(SecondCollectionViewCell *)secondCollectionViewCell
{
    MaintenanceViewController* maintenanceViewController = [[MaintenanceViewController alloc]init];
    SharedAppDelegateHelper.maintenanceViewController = maintenanceViewController;
    [self.navigationController pushViewController:maintenanceViewController animated:YES];
    
}

-(void)didSelectedMyOrderButtonWithSecondCollectionViewCell:(SecondCollectionViewCell *)secondCollectionViewCell
{
    MyOrderViewController* myOrderViewController = [[MyOrderViewController alloc]init];
    
    [self.navigationController pushViewController:myOrderViewController animated:YES];
}

#pragma mark - FirstCollectionViewCellDelegate 点击轮播图调用
-(void)didSelectedImageWithFirstCollectionViewCell:(FirstCollectionViewCell *)firstCollectionViewCell withItemAtIndex:(NSInteger)index
{
    AdsCarouselModel* adsCarouselModel = self.homeDataViewController.adsCarouselArr[index];
   
    WebViewController* webViewController = [[WebViewController alloc]init];
    webViewController.urlStr = adsCarouselModel.Url;
    webViewController.webTitle = adsCarouselModel.Title;
    [self.navigationController pushViewController:webViewController animated:YES];
}
@end
