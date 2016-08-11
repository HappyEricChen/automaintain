//
//  OrderConfirmViewController.m
//  一号车库
//
//  Created by eric on 16/8/11.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "OrderConfirmViewController.h"
#import "OrderConfirmDataViewController.h"
#import "OrderConfirmView.h"

@interface OrderConfirmViewController ()<CustomNavigationViewDelegate>
@property (nonatomic, strong) OrderConfirmDataViewController* orderConfirmDataViewController;
@end

@implementation OrderConfirmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.orderConfirmDataViewController = [[OrderConfirmDataViewController alloc]init];
    
    [self configureNavigationView];
    [self configureMyMessageView];
}

-(void)configureNavigationView
{
    [self.view addSubview:self.orderConfirmDataViewController.customNavigationView];
    self.orderConfirmDataViewController.customNavigationView.delegate = self;
    self.orderConfirmDataViewController.customNavigationView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topEqualToView(self.view).heightIs(ScreenHeight*0.1);
}

-(void)configureMyMessageView
{
    [self.view addSubview:self.orderConfirmDataViewController.orderConfirmView];
    //    self.myMessageDataViewController.myMessageView.delegate = self;
    self.orderConfirmDataViewController.orderConfirmView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topSpaceToView(self.orderConfirmDataViewController.customNavigationView,0).bottomEqualToView(self.view);
}

#pragma mark - CustomNavigationViewDelegate
-(void)didSelectedLeftButtonAtCustomNavigationView:(CustomNavigationView *)customNavigationView
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
