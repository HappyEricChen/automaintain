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
#import "MyOrderViewController.h"

@interface OrderConfirmViewController ()<CustomNavigationViewDelegate,OrderConfirmViewDelegate>
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
    self.orderConfirmDataViewController.orderConfirmView.delegate = self;
    
    /**
     *  日期和时间中加空格    2016-08-13 09:01
     */
    self.orderTime = [self.orderTime stringByReplacingOccurrencesOfString:@" " withString:@"   "];
    /**
     *  传值布局
     */
    [self.orderConfirmDataViewController.orderConfirmView layoutWithTotalTime:self.timeSegment
                                                                withOrderTime:self.orderTime
                                                             withOrderProject:self.orderProject
                                                                    withPrice:self.price];
    
    self.orderConfirmDataViewController.orderConfirmView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topSpaceToView(self.orderConfirmDataViewController.customNavigationView,0).bottomEqualToView(self.view);
}

#pragma mark - CustomNavigationViewDelegate
-(void)didSelectedLeftButtonAtCustomNavigationView:(CustomNavigationView *)customNavigationView
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 点击预约按钮/取消预约按钮调用 OrderConfirmViewDelegate
/**
 * 点击预约按钮调用
 */
-(void)didClickSubmitButtonWithOrderConfirmView:(OrderConfirmView *)orderConfirmView withMessageContent:(NSString *)messageContent
{
   
    NSString* subTimeStr = [self.orderTime substringFromIndex:13];
    /**
     *  时间比较，当前时间和初始时间比较，选中的时间小于当前时间不能提交预约
     */
    if ([AppManagerSingleton.currentTime compare:subTimeStr options:NSCaseInsensitiveSearch] == NSOrderedDescending)
    {
        [SVProgressHUD showInfoWithStatus:@"已超过可预约时间"];
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
    [SVProgressHUD show];
    [self.orderConfirmDataViewController postAppointmentServiceWithAccessCode:AppManagerSingleton.accessCode
                                                     withAppointmentStartTime:self.orderTime
                                                              withSubjectGuid:self.subjectGuid
                                                                     withNote:messageContent
                                                                 withCallback:^(BOOL success, NSError *error, id result)
     {
         if (success)
         {
             /**
              *  预约成功跳转到预约确认界面
              */
             [SVProgressHUD showSuccessWithStatus:@"提交成功"];
             
             MyOrderViewController* myOrderViewController = [[MyOrderViewController alloc]init];
             [self.navigationController pushViewController:myOrderViewController animated:YES];
             
             /**
              *  重新获取时间预约列表
              */
             //             [self loadDataFromService];
         }
         else
         {
             [SVProgressHUD showInfoWithStatus:result];
         }
     }];
    
}
/**
 * 点击取消预约按钮调用
 */
-(void)didClickCancelButtonWithOrderConfirmView:(OrderConfirmView *)orderConfirmView
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
