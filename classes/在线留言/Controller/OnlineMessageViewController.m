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
#import "MyMessageSubmitButtonView.h"
#import "OnlineMessageModel.h"
#import "MyMessageViewController.h"
@interface OnlineMessageViewController ()<CustomNavigationViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,MyMessageSubmitButtonViewDelegate>

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
    
    [self configureNavigationView];
    [self configureMyMessageButtonView];
    [self configureCollectionView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     [self loadMJRefreshMethod];//配置刷新
}

-(void)configureNavigationView
{
    [self.view addSubview:self.onlineMessageDataViewController.customNavigationView];
    self.onlineMessageDataViewController.customNavigationView.delegate = self;
    self.onlineMessageDataViewController.customNavigationView.translatesAutoresizingMaskIntoConstraints = NO;
    self.onlineMessageDataViewController.customNavigationView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topEqualToView(self.view).heightIs(ScreenHeight*0.1);
}

-(void)configureMyMessageButtonView
{
    [self.view addSubview:self.onlineMessageDataViewController.myMessageSubmitButtonView];
    self.onlineMessageDataViewController.myMessageSubmitButtonView.delegate = self;
    self.onlineMessageDataViewController.myMessageSubmitButtonView.translatesAutoresizingMaskIntoConstraints = NO;
    self.onlineMessageDataViewController.myMessageSubmitButtonView.sd_layout.leftSpaceToView(self.view,ScreenWidth*0.04).rightSpaceToView(self.view,ScreenWidth*0.04).bottomSpaceToView(self.view,ScreenHeight*0.015).heightIs(ScreenHeight*0.065);
}

-(void)configureCollectionView
{
    [self.view addSubview:self.onlineMessageDataViewController.collectionView];
    
    self.onlineMessageDataViewController.collectionView.delegate = self;
    self.onlineMessageDataViewController.collectionView.dataSource = self;
    self.onlineMessageDataViewController.collectionView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topSpaceToView(self.onlineMessageDataViewController.customNavigationView,0).bottomSpaceToView(self.onlineMessageDataViewController.myMessageSubmitButtonView,0);
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
    
    NSString* indexStr = [NSString stringWithFormat:@"%ld",self.index];
    [self.onlineMessageDataViewController postOnlineMessageListWithAccessCode:AppManagerSingleton.accessCode
                                                                withPageIndex:indexStr
                                                                 withCallback:^(BOOL success, NSError *error, id result)
     {
         if (success)
         {
             [self.onlineMessageDataViewController.collectionView reloadData];
             
             /**
              *  前一次请求成功后，index再+1
              */
             self.index += 1;
         }
         else
         {
             [SVProgressHUD showInfoWithStatus:result];
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
    
    return self.onlineMessageDataViewController.onlineMessageModelArr.count>0?self.onlineMessageDataViewController.onlineMessageModelArr.count:0;
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell;
    if (indexPath.section == 0)
    {
        OnlineMessageCollectionViewCell * firstCell = [OnlineMessageCollectionViewCell collectionView:collectionView dequeueReusableCellWithReuseIdentifier:OnlineMessageCollectionViewCellId forIndexPath:indexPath];
        [firstCell layoutWithObject:self.onlineMessageDataViewController.onlineMessageModelArr[indexPath.row]];
        cell = firstCell;
    }
//    else if (indexPath.section == 1)
//    {
//        OnlineMessageSecondCollectionViewCell * secondCell = [OnlineMessageSecondCollectionViewCell collectionView:collectionView dequeueReusableCellWithReuseIdentifier:OnlineMessageSecondCollectionViewCellId forIndexPath:indexPath];
//        cell =secondCell;
//    }

    
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
    
    CGFloat textHeight = [self calculateHeighWithLabelContent:onlineMessageModel.Text
                                                 WithFontName:nil
                                                 WithFontSize:12
                                                    WithWidth:ScreenWidth*0.855
                                                     WithBold:NO];
    if (indexPath.section == 0)
    {
        if (!onlineMessageModel.ReplyContent || [onlineMessageModel.ReplyContent  isEqualToString:@""])
        {
            return CGSizeMake(ScreenWidth*0.925, ScreenHeight*0.05+textHeight);
        }
        else
        {
            CGFloat replyContentHeight = [self calculateHeighWithLabelContent:onlineMessageModel.ReplyContent
                                                                 WithFontName:nil
                                                                 WithFontSize:10
                                                                    WithWidth:ScreenWidth*0.855
                                                                     WithBold:NO];
            return CGSizeMake(ScreenWidth*0.925, ScreenHeight*0.065+textHeight+replyContentHeight);
        }
        
    }

    return CGSizeZero;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    return UIEdgeInsetsMake(ScreenHeight*0.022,0,0,0);
}

#pragma mark - MyMessageSubmitButtonViewDelegate

-(void)didClickMyMessageSubmitButtonView:(MyMessageSubmitButtonView *)myMessageSubmitButtonView
{
    MyMessageViewController* myMessageViewController = [[MyMessageViewController alloc]init];
    [self.navigationController pushViewController:myMessageViewController animated:YES];
}
@end
