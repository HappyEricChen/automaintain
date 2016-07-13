//
//  HomeViewController.h
//  一号车库
//
//  Created by eric on 16/6/24.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "BaseViewController.h"

@interface HomeViewController : BaseViewController

/**
 *  token/用户登录后获取，会过期
 */
@property (nonatomic, strong) NSString* accessCode;
@end
