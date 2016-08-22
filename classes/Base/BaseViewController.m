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
    [[SDWebImageManager sharedManager]cancelAll];
    
    [[SDImageCache sharedImageCache]cleanDisk];
}

@end
