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
 *  轮播图片url
 */
@property (nonatomic, strong) NSString* PicUrl;
/**
 *  排序
 */
@property (nonatomic, strong) NSString* Sort;
/**
 *  标题
 */
@property (nonatomic, strong) NSString* Title;
/**
 *  点击图片跳转的Url
 */
@property (nonatomic, strong) NSString* Url;

@end
