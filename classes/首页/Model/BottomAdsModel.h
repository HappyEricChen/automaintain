//
//  BottomAdsModel.h
//  一号车库
//
//  Created by eric on 16/7/13.
//  Copyright © 2016年 eric. All rights reserved.
// 首页底部广告模型

#import <Foundation/Foundation.h>

@interface BottomAdsModel : NSObject
/**
 *
 */
@property (nonatomic, strong) NSString* FileName;
/**
 *
 */
@property (nonatomic, strong) NSString* FullPicUrl;
/**
 *
 */
@property (nonatomic, strong) NSString* Guid;
/**
 *
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
@property (nonatomic, strong) NSString* StatusName;
/**
 *
 */
@property (nonatomic, strong) NSString* Title;
/**
 *
 */
@property (nonatomic, strong) NSString* Url;

/**
 *  广告图的高度
 */
@property (nonatomic, strong) NSString* PicHeight;
@end
