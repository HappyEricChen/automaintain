//
//  HomeDataViewController.m
//  一号车库
//
//  Created by eric on 16/6/24.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "HomeDataViewController.h"
#import "FirstCollectionViewCell.h"
#import "SecondCollectionViewCell.h"
#import "ThirdCollectionViewCell.h"
#import "FourCollectionViewCell.h"
#import "AdsCarouselModel.h"

@implementation HomeDataViewController

-(CustomNavigationView *)customNavigationView
{
    if (!_customNavigationView)
    {
        _customNavigationView = [[CustomNavigationView alloc] initHomeCustomNavigationViewWithLeftBtnImage:ImageNamed(@"home_Location") withRightBtnImage:nil withTitle:AppManagerSingleton.welcomeStr];
    }
    return _customNavigationView;
}

-(UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
        
        [_collectionView registerClass:[FirstCollectionViewCell class] forCellWithReuseIdentifier:firstCellId];
        [_collectionView registerClass:[SecondCollectionViewCell class] forCellWithReuseIdentifier:secondCellId];
        [_collectionView registerClass:[ThirdCollectionViewCell class] forCellWithReuseIdentifier:thirdCellId];
        [_collectionView registerClass:[FourCollectionViewCell class] forCellWithReuseIdentifier:fourCellId];
        
        
    }
    return _collectionView;
}

/**
 首页轮播广告图/POST 请求
 */
-(void)postListofAdsCarouselWithAccessCode:(NSString*)accessCode
                              withCallback:(Callback )callback
{
    [AutomaintainAPI postListofAdsCarouselWithAccessCode:accessCode withCallback:^(BOOL success, NSError *error, id result)
    {
        if (success)
        {
           
            if ([result isKindOfClass:[NSArray class]])
            {
                self.adsCarouselArr = (NSArray*)result;
            }
            
             callback(YES,nil,result);
        }
        else
        {
            callback(NO,nil,result);
        }
    }];
}
/**
 便民服务列表/POST 请求
 */
-(void)postListofConvenienceServiceWithAccessCode:(NSString *)accessCode
                                     withCallback:(Callback)callback
{
    [AutomaintainAPI postListofConvenienceServiceWithAccessCode:accessCode withCallback:^(BOOL success, NSError *error, id result)
     {
         if (success)
         {
             if ([result isKindOfClass:[NSArray class]])
             {
                 self.convenienceServiceArr = (NSArray*)result;
             }
             
             callback(YES,nil,result);
             
         }
         else
         {
             callback(NO,nil,result);
         }
     }];
}

/**
 最下边的广告位/POST 请求
 */
-(void)postListofBottomAdsWithAccessCode:(NSString*)accessCode
                            withCallback:(Callback )callback
{
    [AutomaintainAPI postListofBottomAdsWithAccessCode:accessCode withCallback:^(BOOL success, NSError *error, id result)
    {
        if (success)
        {
            callback(YES,nil,result);
            
            if ([result isKindOfClass:[NSArray class]])
            {
                self.bottomAdsArr = (NSArray*)result;
            }
        }
        else
        {
            callback(NO,nil,result);
        }
    }];
}
@end
