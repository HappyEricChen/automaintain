//
//  MyMessageViewController.m
//  一号车库
//
//  Created by eric on 16/8/8.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "MyMessageViewController.h"
#import "MyMessageDataViewController.h"
#import "MyMessageView.h"

@interface MyMessageViewController ()<CustomNavigationViewDelegate,MyMessageViewDelegate>

@property (nonatomic, strong) MyMessageDataViewController* myMessageDataViewController;
@end

@implementation MyMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myMessageDataViewController = [[MyMessageDataViewController alloc]init];
    
    [self configureNavigationView];
    [self configureMyMessageView];
}

-(void)configureNavigationView
{
    [self.view addSubview:self.myMessageDataViewController.customNavigationView];
    self.myMessageDataViewController.customNavigationView.delegate = self;
    self.myMessageDataViewController.customNavigationView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topEqualToView(self.view).heightIs(ScreenHeight*0.1);
}

-(void)configureMyMessageView
{
    [self.view addSubview:self.myMessageDataViewController.myMessageView];
    self.myMessageDataViewController.myMessageView.delegate = self;
    self.myMessageDataViewController.myMessageView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topSpaceToView(self.myMessageDataViewController.customNavigationView,0).bottomEqualToView(self.view);
}

#pragma mark - CustomNavigationViewDelegate
-(void)didSelectedLeftButtonAtCustomNavigationView:(CustomNavigationView *)customNavigationView
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - MyMessageViewDelegate
-(void)didSelectedSubmitButtonWithMyMessageView:(MyMessageView *)myMessageView withMessageContent:(NSString *)messageContent
{
    /**
     *  去掉首尾空格/回车方法
     */
    messageContent = [messageContent stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if (!messageContent || [messageContent isEqualToString:@""])
    {
        [SVProgressHUD showInfoWithStatus:@"留言不能为空"];
    }
    else
    {
        [SVProgressHUD show];
        [self.myMessageDataViewController postMessageToServiceWithAccessCode:AppManagerSingleton.accessCode
                                                              withCommentContent:messageContent
                                                                    withCallback:^(BOOL success, NSError *error, id result)
         {
             [self.view endEditing:YES];
             if (success)
             {
                 [SVProgressHUD showSuccessWithStatus:@"提交成功"];
                 
                  [self.navigationController popViewControllerAnimated:YES];
                 
             }
             else
             {
                 [SVProgressHUD showInfoWithStatus:result];
             }
         }];
    }
    
    
}
@end
