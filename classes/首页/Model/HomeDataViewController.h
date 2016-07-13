//
//  HomeDataViewController.h
//  一号车库
//
//  Created by eric on 16/6/24.
//  Copyright © 2016年 eric. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeDataViewController : NSObject

@property (nonatomic, strong) CustomNavigationView* customNavigationView;

@property (nonatomic, strong) UICollectionView* collectionView;

/**
 首页轮播广告图/POST 请求
 */
-(void)postListofAdsCarouselWithAccessCode:(NSString*)accessCode
                              withCallback:(Callback )callback;

/**
 *  首页轮播图模型数组
 */
@property (nonatomic, strong) NSArray* adsCarouselArr;

/**
 便民服务列表/POST 请求
 */
-(void)postListofConvenienceServiceWithAccessCode:(NSString*)accessCode
                                     withCallback:(Callback )callback;

/**
 *  便民服务列表模型数组
 */
@property (nonatomic, strong) NSArray* convenienceServiceArr;

/**
 最下边的广告位/POST 请求
 */
-(void)postListofBottomAdsWithAccessCode:(NSString*)accessCode
                            withCallback:(Callback )callback;
/**
 *  最下面广告列表数组
 */
@property (nonatomic, strong) NSArray* bottomAdsArr;
@end
