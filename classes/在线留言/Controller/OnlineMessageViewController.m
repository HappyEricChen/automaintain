//
//  OnlineMessageViewController.m
//  automaintain
//
//  Created by eric on 16/6/30.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "OnlineMessageViewController.h"
#import "OnlineMessageDataViewController.h"
#import "OnlineMessageCollectionViewCell.h"
#import "OnlineMessageSecondCollectionViewCell.h"
#import "MyMessageView.h"
#import "OnlineMessageModel.h"
@interface OnlineMessageViewController ()<CustomNavigationViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,MyMessageViewDelegate>

@property (nonatomic, strong) OnlineMessageDataViewController* onlineMessageDataViewController;

/**
 *  刷新翻页，下拉刷新index=0，下拉刷新index+=1
 */
@property (nonatomic, assign) NSInteger index;
@end

@implementation OnlineMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.onlineMessageDataViewController = [[OnlineMessageDataViewController alloc]init];
    
//    self.contentArr = @[@{@"question":@"这边最晚营业到什么时候?",@"answer":@""},
//                        @{@"question":@"只有办卡才能到这边预约洗车吗?",@"answer":@"回复：您好，目前我们APP主要是为我们的会员卡用户提供预约服务的。如果您这边有需要可以去小区物业处咨询。"}];
    [self configureNavigationView];
    [self configureCollectionView];
    [self configureMyMessageView];
    
    [self loadMJRefreshMethod];//配置刷新
}

-(void)configureNavigationView
{
    [self.view addSubview:self.onlineMessageDataViewController.customNavigationView];
    self.onlineMessageDataViewController.customNavigationView.delegate = self;
    self.onlineMessageDataViewController.customNavigationView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topEqualToView(self.view).heightIs(ScreenHeight*0.1);
}

-(void)configureCollectionView
{
    [self.view addSubview:self.onlineMessageDataViewController.collectionView];
    
    self.onlineMessageDataViewController.collectionView.delegate = self;
    self.onlineMessageDataViewController.collectionView.dataSource = self;
    self.onlineMessageDataViewController.collectionView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topSpaceToView(self.onlineMessageDataViewController.customNavigationView,0).bottomEqualToView(self.view);
}

-(void)configureMyMessageView
{
    [self.view addSubview:self.onlineMessageDataViewController.myMessageView];
    self.onlineMessageDataViewController.myMessageView.hidden = YES;
    self.onlineMessageDataViewController.myMessageView.delegate = self;
    self.onlineMessageDataViewController.myMessageView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topSpaceToView(self.onlineMessageDataViewController.customNavigationView,0).bottomEqualToView(self.view);
}

-(void)loadMJRefreshMethod
{
    self.index = 0;//初始化
    
    MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadDataFromService:)];
    self.onlineMessageDataViewController.collectionView.mj_header = header;
    [self.onlineMessageDataViewController.collectionView.mj_header beginRefreshing];//开始刷新
    self.onlineMessageDataViewController.collectionView .mj_header.automaticallyChangeAlpha = YES;
    
    MJRefreshAutoNormalFooter * footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadDataFromService:)];
    self.onlineMessageDataViewController.collectionView.mj_footer = footer;
    
}

-(void)loadDataFromService:(MJRefreshComponent*)headerFooterView
{
    if ([headerFooterView isKindOfClass:[MJRefreshNormalHeader class]])
    {
        self.index = 0;
    }
    else
    {
        self.index += 1;
    }
    
    NSString* indexStr = [NSString stringWithFormat:@"%ld",self.index];
    [self.onlineMessageDataViewController postOnlineMessageListWithAccessCode:AppManagerSingleton.accessCode
                                                                withPageIndex:indexStr
                                                                 withCallback:^(BOOL success, NSError *error, id result)
     {
         [self.onlineMessageDataViewController.collectionView.mj_header endRefreshing];//结束刷新
         [self.onlineMessageDataViewController.collectionView.mj_footer endRefreshing];//结束刷新
         if (success)
         {
             [self.onlineMessageDataViewController.collectionView reloadData];
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
    return 2;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return self.onlineMessageDataViewController.onlineMessageModelArr.count>0?self.onlineMessageDataViewController.onlineMessageModelArr.count:0;
    }
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = nil;
    if (indexPath.section == 0)
    {
        OnlineMessageCollectionViewCell * firstCell = [OnlineMessageCollectionViewCell collectionView:collectionView dequeueReusableCellWithReuseIdentifier:OnlineMessageCollectionViewCellId forIndexPath:indexPath];
        [firstCell layoutWithObject:self.onlineMessageDataViewController.onlineMessageModelArr[indexPath.row]];
        cell = firstCell;
    }
    else if (indexPath.section == 1)
    {
        OnlineMessageSecondCollectionViewCell * secondCell = [OnlineMessageSecondCollectionViewCell collectionView:collectionView dequeueReusableCellWithReuseIdentifier:OnlineMessageSecondCollectionViewCellId forIndexPath:indexPath];
        cell =secondCell;
    }

    
    return cell;
}

#pragma mark - UICollectionViewFlowLayoutDelegate

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    OnlineMessageModel* onlineMessageModel;
    
    if (self.onlineMessageDataViewController.onlineMessageModelArr && self.onlineMessageDataViewController.onlineMessageModelArr.count>0)
    {
        onlineMessageModel = self.onlineMessageDataViewController.onlineMessageModelArr[indexPath.row];
    }
    
    if (indexPath.section == 0)
    {
        if (!onlineMessageModel.ReplyContent || [onlineMessageModel.ReplyContent  isEqualToString:@""])
        {
            return CGSizeMake(ScreenWidth*0.925, ScreenHeight*0.095);
        }
        else
        {
            return CGSizeMake(ScreenWidth*0.925, ScreenHeight*0.148);
        }
        
    }
    else if (indexPath.section == 1)
    {
        return CGSizeMake(ScreenWidth*0.925, ScreenHeight*0.05);
    }

    return CGSizeZero;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    return UIEdgeInsetsMake(ScreenHeight*0.022,0,0,0);
}

#pragma mark - UICollectionViewDelegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1)
    {
        self.onlineMessageDataViewController.collectionView.hidden = YES;
        self.onlineMessageDataViewController.myMessageView.hidden = NO;
    }
}

#pragma mark - MyMessageViewDelegate
-(void)didSelectedSubmitButtonWithMyMessageView:(MyMessageView *)myMessageView withMessageContent:(NSString *)messageContent
{
    [SVProgressHUD show];
    [self.onlineMessageDataViewController postMessageToServiceWithAccessCode:AppManagerSingleton.accessCode
                                                          withCommentContent:messageContent
                                                                withCallback:^(BOOL success, NSError *error, id result)
     {
         [self.view endEditing:YES];
         if (success)
         {
             [SVProgressHUD showSuccessWithStatus:@"提交成功"];
             self.onlineMessageDataViewController.collectionView.hidden = NO;
             self.onlineMessageDataViewController.myMessageView.hidden = YES;
             [self.onlineMessageDataViewController.collectionView.mj_header beginRefreshing];
             
         }
         else
         {
             [SVProgressHUD showErrorWithStatus:result];
         }
     }];
}
@end
