//
//  WebViewController.m
//  一号车库
//
//  Created by eric on 16/7/29.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "WebViewController.h"
#import "WebDataViewController.h"
@interface WebViewController ()<CustomNavigationViewDelegate>

@property (nonatomic, strong) WebDataViewController* webDataViewController;
@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webDataViewController = [[WebDataViewController alloc]init];
    [self configureNavigationView];
    [self configureWebView];
}

-(void)configureNavigationView
{
    [self.view addSubview:self.webDataViewController.customNavigationView];
    self.webDataViewController.customNavigationView.delegate = self;
    self.webDataViewController.customNavigationView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topEqualToView(self.view).heightIs(ScreenHeight*0.1);
}

-(void)configureWebView
{
     NSURL* url = [NSURL URLWithString:self.urlStr];
    
    UIWebView* webView = [[UIWebView alloc]init];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    [self.view addSubview:webView];
    
    webView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topSpaceToView(self.webDataViewController.customNavigationView,0).bottomEqualToView(self.view);
   
}

#pragma mark - CustomNavigationViewDelegate
-(void)didSelectedLeftButtonAtCustomNavigationView:(CustomNavigationView *)customNavigationView
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
