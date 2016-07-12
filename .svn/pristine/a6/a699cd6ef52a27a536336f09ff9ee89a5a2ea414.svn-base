//
//  ImageAmplificationViewController.m
//  automaintain
//
//  Created by eric on 16/7/6.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "ImageAmplificationViewController.h"

@interface ImageAmplificationViewController ()

@end

@implementation ImageAmplificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self configureImageView];
}

-(void)configureImageView
{
    UIImageView* imageView = [[UIImageView alloc]initWithImage:self.image];
    imageView.frame = CGRectMake(0, ScreenHeight*0.2, ScreenWidth, ScreenWidth*self.image.size.width/self.image.size.width);
    
    UITapGestureRecognizer* tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImageAction)];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:tapRecognizer];
    
    [self.view addSubview:imageView];
}

-(void)tapImageAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
