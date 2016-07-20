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
 *  预约项目模型数组，当前选中的数组
 */
@property (nonatomic, strong) NSMutableArray* typeSelectedArr;
/**
 *  美容洗护服务模型数组
 */
@property (nonatomic, strong) NSMutableArray* beautyServiceArr;
/**
 *  维修服务模型数组
 */
@property (nonatomic, strong) NSMutableArray* maintenanceArr;
/**
 *   预约类型/POST 请求
 *
 *  @param accessCode   唯一标识符
 *  @param callback    回调
 */
-(void)postOrderTypeListWithAccessCode:(NSString*)accessCode
                          withCallback:(Callback )callback;
@end
