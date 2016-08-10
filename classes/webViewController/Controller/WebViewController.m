//
//  WebViewController.m
//  一号车库
//
//  Created by eric on 16/7/29.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "WebViewController.h"
#import "WebDataViewController.h"
@interface WebViewController ()<CustomNavigationViewDelegate,UIWebViewDelegate>

@property (nonatomic, strong) WebDataViewController* webDataViewController;
@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webDataViewController = [[WebDataViewController alloc]initWithTitle:self.title];
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
    NSLog(@"%@",self.urlStr);
    UIWebView* webView = [[UIWebView alloc]init];
    webView.delegate = self;
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    [self.view addSubview:webView];
    
    /**
     *  显示进度
     */
    [SVProgressHUD show];
    
    
    webView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topSpaceToView(self.webDataViewController.customNavigationView,0).bottomEqualToView(self.view);
   
}
#pragma mark - webView代理方法
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    /**
     *  防止方法多次调用，网页内有异步请求或者重定向时会多次调用这个方法
     */
    if (webView.isLoading)
    {
        return;
    }
    [SVProgressHUD dismiss];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    /**
     *  在uiwebview里，如果load一个url还没结束就立即load另一个url，那么就会callback didFailLoadWithError method，error code is -999。solution is 在didFailLoadWithError 里添加下列code
     */
    if ([error code] != NSURLErrorCancelled)
    {
         [SVProgressHUD showInfoWithStatus:@"网络请求失败"];
    }
}
#pragma mark - CustomNavigationViewDelegate
-(void)didSelectedLeftButtonAtCustomNavigationView:(CustomNavigationView *)customNavigationView
{
    [SVProgressHUD dismiss];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
