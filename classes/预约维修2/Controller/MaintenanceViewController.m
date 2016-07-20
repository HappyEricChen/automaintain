//
//  MaintenanceViewController.m
//  automaintain
//
//  Created by eric on 16/6/29.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "MaintenanceViewController.h"
#import "MaintenanceDataViewController.h"
#import "WashCarFiveCollectionViewCell.h"
#import "CommentHeaderView.h"
#import "MaintenanceHeaderView.h"
#import "TypeSelectedViewController.h"
#import "TimeSelectedViewController.h"
#import "ImageAmplificationViewController.h"
#import "MaintenanceHeaderView.h"
#import "OrderTypeModel.h"

@interface MaintenanceViewController ()<CustomNavigationViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,MaintenanceHeaderViewDelegate,WashCarFiveCollectionViewCellDelegate>

@property (nonatomic, strong) MaintenanceDataViewController* maintenanceDataViewController;
/**
 *  用户评论模型数组
 */
@property (nonatomic, strong) NSArray* userCommentModelArr;

@end

@implementation MaintenanceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.maintenanceDataViewController = [[MaintenanceDataViewController alloc]init];
    self.view.backgroundColor = [UIColor whiteColor];
    [self configureNavigationView];
    [self configureHeaderView];
    [self configureCollectionView];
    [self loadDataFromService];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.maintenanceDataViewController.maintenanceHeaderView layoutWithOrderTypeModel:self.orderTypeModel];
    
}

-(void)configureNavigationView
{
    [self.view addSubview:self.maintenanceDataViewController.customNavigationView];
    self.maintenanceDataViewController.customNavigationView.delegate = self;
    self.maintenanceDataViewController.customNavigationView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topEqualToView(self.view).heightIs(ScreenHeight*0.1);
}

-(void)configureHeaderView
{
    [self.view addSubview:self.maintenanceDataViewController.maintenanceHeaderView];
    self.maintenanceDataViewController.maintenanceHeaderView.delegate = self;
    self.maintenanceDataViewController.maintenanceHeaderView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topSpaceToView(self.maintenanceDataViewController.customNavigationView,0).heightIs(ScreenHeight*0.255);
}

-(void)configureCollectionView
{
    [self.view addSubview:self.maintenanceDataViewController.collectionView];
    
    self.maintenanceDataViewController.collectionView.delegate = self;
    self.maintenanceDataViewController.collectionView.dataSource = self;
    
    self.maintenanceDataViewController.collectionView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topSpaceToView(self.maintenanceDataViewController.maintenanceHeaderView,ScreenHeight*0.07).bottomEqualToView(self.view);
    
}

-(void)loadDataFromService
{
    [AutomaintainAPI postCommentListWithAccessCode:AppManagerSingleton.accessCode withMaintianSubjectGuid:SubjectGuidWashCar withCallback:^(BOOL success, NSError *error, id result)
     {
         if (success)
         {
             
             self.userCommentModelArr = (NSArray*)result;
             [self.maintenanceDataViewController.collectionView reloadData];
         }
         else
         {
             [SVProgressHUD showErrorWithStatus:result];
         }
     }];
    
}

#pragma mark - CustomNavigationViewDelegate
-(void)didSelectedLeftButtonAtCustomNavigationView:(CustomNavigationView *)customNavigationView
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.userCommentModelArr.count>0?self.userCommentModelArr.count:0;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BaseCollectionViewCell * cell = nil;
    
    if (indexPath.section == 0)
    {
        WashCarFiveCollectionViewCell * thirdCell = [WashCarFiveCollectionViewCell collectionView:collectionView dequeueReusableCellWithReuseIdentifier:WashCarFiveCollectionViewCellId forIndexPath:indexPath];
        thirdCell.delegate = self;
        
        [cell layoutWithObject:self.userCommentModelArr[indexPath.row]];
        cell = thirdCell;
    }
    
    return cell;
}

#pragma mark - UICollectionViewFlowLayoutDelegate

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return CGSizeMake(ScreenWidth, ScreenHeight*0.187);
    }
    return CGSizeZero;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 0)
    {
        return UIEdgeInsetsMake(17, 0, 0, 0);
    }
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return CGSizeMake(ScreenWidth,45);
    }
    return CGSizeZero;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView * reusableView = nil;
    
    if (kind == UICollectionElementKindSectionHeader)
    {
        CommentHeaderView* headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerId forIndexPath:indexPath];
        
        reusableView = headerView;
    }
    
    return reusableView;
}

#pragma mark - MaintenanceHeaderViewDelegate
/**
 *  类型选择
 */
-(void)didSelectedTypeChangeButtonWithMaintenanceHeaderView:(MaintenanceHeaderView *)maintenanceHeaderView
{
    TypeSelectedViewController* typeSelectedViewController = [[TypeSelectedViewController alloc]init];
    typeSelectedViewController.orderTypeModel = self.orderTypeModel;
    [self.navigationController pushViewController:typeSelectedViewController animated:YES];
}
/**
 *  时间选择
 */
-(void)didSelectedTimeChangeButtonWithMaintenanceHeaderView:(MaintenanceHeaderView *)maintenanceHeaderView
{
    TimeSelectedViewController* timeSelectedViewController = [[TimeSelectedViewController alloc]init];
    
    [self.navigationController pushViewController:timeSelectedViewController animated:YES];
}
#pragma mark -WashCarFiveCollectionViewCellDelegate
-(void)didClickCarImageWithWashCarFiveCollectionViewCell:(WashCarFiveCollectionViewCell *)washCarFiveCollectionViewCell withImageView:(UIImageView *)imageView
{
    ImageAmplificationViewController* imageAmplificationViewController = [[ImageAmplificationViewController alloc]init];
    imageAmplificationViewController.image = imageView.image;
    [imageAmplificationViewController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self presentViewController:imageAmplificationViewController animated:YES completion:nil];
}
@end
