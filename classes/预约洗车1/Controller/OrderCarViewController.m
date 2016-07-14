//
//  OrderCarViewController.m
//  一号车库
//
//  Created by eric on 16/6/28.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "OrderCarViewController.h"
#import "OrderCarDataViewController.h"
#import "WashCarFirstCollectionViewCell.h"
#import "WashCarSecondCollectionViewCell.h"
#import "WashCarThirdCollectionViewCell.h"
#import "WashCarFourCollectionViewCell.h"
#import "WashCarFiveCollectionViewCell.h"
#import "CommentHeaderView.h"
#import "ImageAmplificationViewController.h"

@interface OrderCarViewController ()<CustomNavigationViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,WashCarFiveCollectionViewCellDelegate>
@property (nonatomic, strong) OrderCarDataViewController* orderCarDataViewController;
@end

@implementation OrderCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.orderCarDataViewController = [[OrderCarDataViewController alloc]init];
    [self configureNavigationView];
    [self configureCollectionView];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [NSDate date];
    [self.orderCarDataViewController postListofWashCarPlaceListWithAccessCode:AppManagerSingleton.accessCode withCurrentDate:AppManagerSingleton.currentDate withSubjectGuid:@"00000000-0000-0000-0000-000000000001" withCallback:^(BOOL success, NSError *error, id result)
     {
         if (success)
         {
             [self.orderCarDataViewController.collectionView reloadData];
         }
         else
         {
             
         }
     }];
}

-(void)configureNavigationView
{
    [self.view addSubview:self.orderCarDataViewController.customNavigationView];
    self.orderCarDataViewController.customNavigationView.delegate = self;
    self.orderCarDataViewController.customNavigationView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topEqualToView(self.view).heightIs(ScreenHeight*0.1);
}

-(void)configureCollectionView
{
    [self.view addSubview:self.orderCarDataViewController.collectionView];
    
    self.orderCarDataViewController.collectionView.delegate = self;
    self.orderCarDataViewController.collectionView.dataSource = self;
    
    self.orderCarDataViewController.collectionView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topSpaceToView(self.orderCarDataViewController.customNavigationView,0).bottomEqualToView(self.view);
    
}


#pragma mark - CustomNavigationViewDelegate
-(void)didSelectedLeftButtonAtCustomNavigationView:(CustomNavigationView *)customNavigationView
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 5;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    if (section == 4)
    {
        return 5;
    }
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BaseCollectionViewCell * cell = nil;
    id object = nil;
    if (indexPath.section == 0)
    {
        WashCarFirstCollectionViewCell * firstCell = [WashCarFirstCollectionViewCell collectionView:collectionView dequeueReusableCellWithReuseIdentifier:washCarFirstId forIndexPath:indexPath];
        [firstCell layoutWithObject:nil];
        cell = firstCell;
    }
    else if (indexPath.section == 1)
    {
        WashCarSecondCollectionViewCell * secondCell = [WashCarSecondCollectionViewCell collectionView:collectionView dequeueReusableCellWithReuseIdentifier:WashCarSecondId forIndexPath:indexPath];
        cell =secondCell;
    }
    else if (indexPath.section == 2)
    {
        WashCarThirdCollectionViewCell * thirdCell = [WashCarThirdCollectionViewCell collectionView:collectionView dequeueReusableCellWithReuseIdentifier:WashCarThirdCollectionViewCellId forIndexPath:indexPath];
        object = self.orderCarDataViewController.washCarDateListModel;
        
        cell = thirdCell;
    }
    else if (indexPath.section == 3)
    {
        WashCarFourCollectionViewCell * fourCell = [WashCarFourCollectionViewCell collectionView:collectionView dequeueReusableCellWithReuseIdentifier:WashCarFourCollectionViewCellId forIndexPath:indexPath];
        cell = fourCell;
    }
    else if (indexPath.section == 4)
    {
        WashCarFiveCollectionViewCell * fiveCell = [WashCarFiveCollectionViewCell collectionView:collectionView dequeueReusableCellWithReuseIdentifier:WashCarFiveCollectionViewCellId forIndexPath:indexPath];
        fiveCell.delegate = self;
        cell = fiveCell;
    }
    
    [cell layoutWithObject:object];
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
        return CGSizeMake(ScreenWidth, ScreenHeight*0.065);
    }
    else if (indexPath.section == 2)
    {
        return CGSizeMake(ScreenWidth, ScreenHeight*0.4);
    }
    else if (indexPath.section == 3)
    {
        return CGSizeMake(ScreenWidth, ScreenHeight*0.1);
    }
    else if (indexPath.section == 4)
    {
        return CGSizeMake(ScreenWidth, ScreenHeight*0.2);
    }
    return CGSizeZero;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
//    if (section == 2)
//    {
//        return UIEdgeInsetsMake(0, ScreenWidth*0.04, 0, ScreenWidth*0.04);
//    }

    return UIEdgeInsetsMake(0, 0, 0, 0);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 4)
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
#pragma mark -UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2)
    {
        
    }
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
