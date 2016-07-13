//
//  AdsCarouselModel.h
//  一号车库
//
//  Created by eric on 16/7/13.
//  Copyright © 2016年 eric. All rights reserved.
//  首页图片轮播模型

#import <Foundation/Foundation.h>

@interface AdsCarouselModel : NSObject
/**
 *
 */
@property (nonatomic, strong) NSString* CreateTime;
/**
 *
 */
@property (nonatomic, strong) NSString* Guid;
/**
 *
 */
@property (nonatomic, strong) NSString* Id;
/**
 *  轮播图片url
 */
@property (nonatomic, strong) NSString* PicUrl;
/**
 *
 */
@property (nonatomic, strong) NSString* Sort;
/**
 *
 */
@property (nonatomic, strong) NSString* Status;
/**
 *
 */
@property (nonatomic, strong) NSString* Title;
/**
 *
 */
@property (nonatomic, strong) NSString* Type;
/**
 *
 */
@property (nonatomic, strong) NSString* Url;

@end
