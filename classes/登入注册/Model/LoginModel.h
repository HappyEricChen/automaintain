//
//  LoginModel.h
//  一号车库
//
//  Created by eric on 16/7/13.
//  Copyright © 2016年 eric. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginModel : NSObject

/**
 *  token/唯一编号
 */
@property (nonatomic, strong) NSString* AccessCode;

/**
 *  头像url
 */
@property (nonatomic, strong) NSString* AvatarUrl;

/**
 *  汽车品牌
 */
@property (nonatomic, strong) NSString* CarBrand;

/**
 *  汽车
 */
@property (nonatomic, strong) NSString* CarModel;

/**
 *  车牌号
 */
@property (nonatomic, strong) NSString* CarNo;

/**
 *
 */
@property (nonatomic, strong) NSString* CardNo;

/**
 *
 */
@property (nonatomic, strong) NSString* Role;

/**
 *
 */
@property (nonatomic, strong) NSString* SectionName;

/**
 *
 */
@property (nonatomic, strong) NSString* ShopName;


@end
