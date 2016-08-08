//
//  WebDataViewController.h
//  一号车库
//
//  Created by eric on 16/7/29.
//  Copyright © 2016年 eric. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebDataViewController : NSObject

@property (nonatomic, strong) CustomNavigationView* customNavigationView;

/**
 *  初始化导航栏的标题
 */
-(instancetype)initWithTitle:(NSString*)title;

@end
