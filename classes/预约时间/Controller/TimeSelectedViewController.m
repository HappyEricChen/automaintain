//
//  TimeSelectedViewController.m
//  automaintain
//
//  Created by eric on 16/6/30.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "TimeSelectedViewController.h"
#import "TimeSelectedDataViewController.h"
#import "WashCarFirstCollectionViewCell.h"
#import "TimeSelectedHeaderView.h"
#import "FirstTimeSelecetdCollectionViewCell.h"
#import "WashCarSecondCollectionViewCell.h"
#import "SecondTimeCollectionViewCell.h"

@interface TimeSelectedViewController ()<CustomNavigationViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) TimeSelectedDataViewController* timeSelectedDataViewController;
@end

@implementation TimeSelectedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.timeSelectedDataViewController = [[TimeSelectedDataViewController alloc]init];
    self.view.backgroundColor = [UIColor whiteColor];
    [self configureNavigationView];
    [self configureCollectionView];
    
    [self loadDataFromService];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(currentDateNotification:) name:kNotify_selected_date object:nil];
}

-(void)configureNavigationView
{
    [self.view addSubview:self.timeSelectedDataViewController.customNavigationView];
    self.timeSelectedDataViewController.customNavigationView.delegate = self;
    self.timeSelectedDataViewController.customNavigationView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topEqualToView(self.view).heightIs(ScreenHeight*0.1);
}

-(void)configureCollectionView
{
    [self.view addSubview:self.timeSelectedDataViewController.collectionView];
    
    self.timeSelectedDataViewController.collectionView.delegate = self;
    self.timeSelectedDataViewController.collectionView.dataSource = self;
    
    self.timeSelectedDataViewController.collectionView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topSpaceToView(self.timeSelectedDataViewController.customNavigationView,0).bottomEqualToView(self.view);
    
}

-(void)loadDataFromService
{
    [self.timeSelectedDataViewController postListofWashCarPlaceListWithAccessCode:AppManagerSingleton.accessCode
                                                                  withCurrentDate:AppManagerSingleton.currentDate
                                                                  withSubjectGuid:SubjectGuidWashCar
                                                                     withCallback:^(BOOL success, NSError *error, id result)
     {
         if (success)
         {
             [self.timeSelectedDataViewController.collectionView reloadData];
         }
         else
         {
             
         }
     }];
}


/**
 *  切换日期刷新数据
 */
//-(void)currentDateNotification:(NSNotification*)object
//{
//    NSString* currentDateStr = [object.userInfo objectForKey:@"currentDate"];
//    
//    NSString* dateStringFormate1 = [currentDateStr stringByReplacingOccurrencesOfString:@"年" withString:@"-"];
//    NSString* dateStringFormate2 = [dateStringFormate1 stringByReplacingOccurrencesOfString:@"月" withString:@"-"];
//    NSString* dateStringFormate3 = [dateStringFormate2 stringByReplacingOccurrencesOfString:@"日" withString:@" "];
//    self.selectedDate = dateStringFormate3;
//    
//    [self.timeSelectedDataViewController postListofWashCarPlaceListWithAccessCode:AppManagerSingleton.accessCode withCurrentDate:dateStringFormate3 withSubjectGuid:SubjectGuidWashCar withCallback:^(BOOL success, NSError *error, id result)
//     {
//         if (success)
//         {
//             [SVProgressHUD dismiss];
//             [self.timeSelectedDataViewController.collectionView reloadData];
//         }
//         else
//         {
//             [SVProgressHUD showErrorWithStatus:result];
//         }
//     }];
//    
//}



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
    if (section == 1)
    {
        return self.timeSelectedDataViewController.fullOrderMaintenanceArr.count>0?self.timeSelectedDataViewController.fullOrderMaintenanceArr.count:0;
    }
    else if (section == 2)
    {
        return self.timeSelectedDataViewController.canOrderMaintenanceArr.count>0?self.timeSelectedDataViewController.canOrderMaintenanceArr.count:0;
    }
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = nil;
    
    if (indexPath.section == 0)
    {
        WashCarFirstCollectionViewCell * firstCell = [WashCarFirstCollectionViewCell collectionView:collectionView dequeueReusableCellWithReuseIdentifier:washCarFirstId forIndexPath:indexPath];
        [firstCell layoutWithObject:nil];
        cell = firstCell;
    }
    else if (indexPath.section == 1)
    {
        FirstTimeSelecetdCollectionViewCell * secondCell = [FirstTimeSelecetdCollectionViewCell collectionView:collectionView dequeueReusableCellWithReuseIdentifier:firstTimeCellId forIndexPath:indexPath];
         [secondCell layoutWithObject:self.timeSelectedDataViewController.fullOrderMaintenanceArr[indexPath.row]];
        cell =secondCell;
    }
    else if (indexPath.section == 2)
    {
        SecondTimeCollectionViewCell * thirdCell = [SecondTimeCollectionViewCell collectionView:collectionView dequeueReusableCellWithReuseIdentifier:secondTimeCellId forIndexPath:indexPath];
        [thirdCell layoutWithObject:self.timeSelectedDataViewController.canOrderMaintenanceArr[indexPath.row]];
        cell = thirdCell;
    }

    
    return cell;
}

#pragma mark - UICollectionViewFlowLayoutDelegate

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return CGSizeMake(ScreenWidth, ScreenHeight*0.08);
    }
    else if (indexPath.section == 1)
    {
        return CGSizeMake(ScreenWidth*0.27, ScreenHeight*0.04);
    }
    else if (indexPath.section == 2)
    {
        return CGSizeMake(ScreenWidth*0.27, ScreenHeight*0.04);
    }
    
    return CGSizeZero;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 1 || section == 2)
    {
        return UIEdgeInsetsMake(0, ScreenWidth*0.04, 0, ScreenWidth*0.04);
    }
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 1 || section == 2)
    {
        return CGSizeMake(ScreenWidth,ScreenHeight*0.05);
    }
    return CGSizeZero;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView * reusableView = nil;
    
    if (kind == UICollectionElementKindSectionHeader)
    {
        TimeSelectedHeaderView* headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:TimeSelectedHeaderViewId forIndexPath:indexPath];
        
        if (indexPath.section == 1)
        {
            [headerView layoutWithImage:ImageNamed(@"order_choose_red") WithTitle:@"他人已预约"];
        }
        else if (indexPath.section == 2)
        {
            [headerView layoutWithImage:ImageNamed(@"order_choose_white") WithTitle:@"可预约"];
        }
        
        reusableView = headerView;
    }
    
    return reusableView;
}
#pragma mark - UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
