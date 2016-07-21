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
 *  用户头像url
 */
@property (nonatomic, strong) NSString* AvatarUrl;

/**
 *  汽车品牌: 奥迪
 */
@property (nonatomic, strong) NSString* CarBrand;

/**
 *  汽车型号: A6L
 */
@property (nonatomic, strong) NSString* CarModel;

/**
 *  车牌号: 沪A888888
 */
@property (nonatomic, strong) NSString* CarNo;

/**
 *  会员号--暂时不用
 */
@property (nonatomic, strong) NSString* CardNo;

/**
 *  角色:普通会员/VIP会员---暂时不用
 */
@property (nonatomic, strong) NSString* Role;

/**
 *  小区名称：凯旋花苑
 */
@property (nonatomic, strong) NSString* SectionName;

/**
 *  门店名称: 暂时不用
 */
@property (nonatomic, strong) NSString* ShopName;


@end
