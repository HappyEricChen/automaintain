//
//  ModeHUD.m
//  mode
//
//  Created by cloud on 9/20/16.
//  Copyright © 2016 Yedao Inc. All rights reserved.
//

#import "ModeHUD.h"
//#import "CircleImageView.h"
//#import "CustomImageView.h"
//#import "LoadingAnimationView.h"
//#import "CircleLoadingView.h"
//#import "TickAnimationView.h"
@implementation ModeHUD
+(ModeHUD*)sharedHUD
{
    static ModeHUD *sharedInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedInstance = [[self alloc] init];
//        sharedInstance.mode = MBProgressHUDModeCustomView;
        sharedInstance.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        sharedInstance.bezelView.backgroundColor = [UIColor clearColor];
        sharedInstance.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
        sharedInstance.backgroundView.backgroundColor = [UIColor clearColor];
        sharedInstance.animationType = MBProgressHUDAnimationZoomIn;
        sharedInstance.removeFromSuperViewOnHide = YES;
    });
    return sharedInstance;
}
-(ModeHUD*(^)())md_customView
{
    return ^(UIView* view)
    {
        self.customView = view;
        return self;
    };
}
-(ModeHUD*(^)())md_superview
{
    return ^(UIView* view)
    {
        if (view == nil)
        {
            view = [UIApplication sharedApplication].keyWindow;
        }
        if (self.superview)
        {
            [self removeFromSuperview];
        }
        self.frame = view.bounds;
        [view addSubview:self];
        return self;
    };
}
//-(ModeHUD*(^)())md_showMessage
//{
//    return ^(NSString*message)
//    {
//        self.md_hideHUD();
//        if (DISTINCT_STRING(message) && message.length>0)
//        {
//            [[TipView tipView]setTipContext:message];
//        }
//        return self;
//    };
//}
-(ModeHUD*(^)())md_hideHUD
{
    return ^()
    {
        if (self.superview)
        {
            self.customView = nil;
            [self hideAnimated:YES
                    afterDelay:0];
        }
        return self;
    };
}
//-(ModeHUD*(^)())md_showTickAnimationView
//{
//    return ^()
//    {
//        if (self.customView && [self.customView isKindOfClass:[TickAnimationView class]])
//        {
//            self.md_show();
//            TickAnimationView* tickAnimationView = (TickAnimationView*)self.customView;
//            [tickAnimationView doSuccessStep2];
//        }
//        else
//        {
//            self.customView = [[TickAnimationView alloc]init];
//            self.md_show();
//            TickAnimationView* tickAnimationView = (TickAnimationView*)self.customView;
//            [tickAnimationView doSuccessStep2];
//        }
//        return self;
//    };
//}
//-(ModeHUD*(^)())md_showLoadingView
//{
//    return ^()
//    {
//        if (self.customView && [self.customView isKindOfClass:[NormalLoadingView class]])
//        {
//            self.md_show();
//        }
//        else
//        {
//            self.customView = [[NormalLoadingView alloc]init];
//            self.md_show();
//        }
//        return self;
//    };
//}
-(ModeHUD*(^)())md_show
{
    return ^()
    {
        if (self.superview == nil)
        {
            self.md_superview(nil);
        }
        [self showAnimated:YES];
        return self;
    };
}
@end
