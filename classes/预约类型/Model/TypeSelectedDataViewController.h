//
//  TypeSelectedDataViewController.h
//  automaintain
//
//  Created by eric on 16/6/29.
//  Copyright © 2016年 eric. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TypeSelectedView;

@interface TypeSelectedDataViewController : NSObject

@property (nonatomic, strong) CustomNavigationView* customNavigationView;

@property (nonatomic, strong) TypeSelectedView* typeSelectedView;

@property (nonatomic, strong) UITableView* customTableView;

/**
 *  预约额项目内容，洗车、维修
 */
@property (nonatomic, strong) NSMutableArray* typeSelectedArr;
/**
 *   预约类型/POST 请求
 *
 *  @param accessCode   唯一标识符
 *  @param callback    回调
 */
-(void)postOrderTypeListWithAccessCode:(NSString*)accessCode
                          withCallback:(Callback )callback;
@end
