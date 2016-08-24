//
//  BaseViewController.m
//  automaintain
//
//  Created by eric on 16/6/24.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromRGB(0xf0f8fb);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    /**
     *  清除图片缓存
     */
    
//    [[SDImageCache sharedImageCache]clearMemory];//清除内存图片
//    
//    [[SDImageCache sharedImageCache]cleanDisk];///清空磁盘图片
//    
//    [[SDImageCache sharedImageCache]clearDisk];//清除物理缓存
    
    [[YYImageCache sharedCache].memoryCache removeAllObjects];
    [[YYImageCache sharedCache].diskCache removeAllObjectsWithBlock:^{
        
    }];
}

@end
