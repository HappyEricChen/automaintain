//
//  ModifyPasswordViewController.m
//  automaintain
//
//  Created by eric on 16/7/5.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "ModifyPasswordViewController.h"
#import "ModifyPasswordDataViewController.h"

@interface ModifyPasswordViewController ()<CustomNavigationViewDelegate>

@property (nonatomic, strong) ModifyPasswordDataViewController* modifyPasswordDataViewController;
@end

@implementation ModifyPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.modifyPasswordDataViewController = [[ModifyPasswordDataViewController alloc]init];
    //    self.view.backgroundColor = [UIColor colorWithPatternImage:ImageNamed(@"register_bg")];
    [self configureNavigationView];
        [self configureModifyPasswordView];
}

-(void)configureNavigationView
{
    [self.view addSubview:self.modifyPasswordDataViewController.customNavigationView];
    self.modifyPasswordDataViewController.customNavigationView.delegate = self;
    self.modifyPasswordDataViewController.customNavigationView.translatesAutoresizingMaskIntoConstraints = NO;
    self.modifyPasswordDataViewController.customNavigationView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topEqualToView(self.view).heightIs(ScreenHeight*0.1);
    
}


-(void)configureModifyPasswordView
{
    [self.view addSubview:self.modifyPasswordDataViewController.modifyPasswordView];
    
    self.modifyPasswordDataViewController.modifyPasswordView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topSpaceToView(self.modifyPasswordDataViewController.customNavigationView,0).bottomEqualToView(self.view);
}


-(void)didSelectedLeftButtonAtCustomNavigationView:(CustomNavigationView *)customNavigationView
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
