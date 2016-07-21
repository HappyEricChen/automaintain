//
//  SettingDataViewController.h
//  automaintain
//
//  Created by eric on 16/7/4.
//  Copyright © 2016年 eric. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingDataViewController : NSObject

@property (nonatomic, strong) CustomNavigationView* customNavigationView;

@property (nonatomic, strong) UICollectionView* collectionView;

/**
 会员登出/POST 请求
 */
-(void)logoutWithAccessCode:(NSString*)accessCode
               withCallback:(Callback )callback;

@end
