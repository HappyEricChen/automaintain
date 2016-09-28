//
//  ModeHUD.h
//  mode
//
//  Created by cloud on 9/20/16.
//  Copyright © 2016 Yedao Inc. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface ModeHUD : MBProgressHUD
#pragma mark singleton instance
+(ModeHUD*)sharedHUD;
#pragma mark -- use chainable synx to configure HUD
/**
 * configure customView
 */
-(ModeHUD*(^)())md_customView;
/**
 * configure superview
 */
-(ModeHUD*(^)())md_superview;
/**
 * this method will hide hud, and use TipView show message
 */
//-(ModeHUD*(^)())md_showMessage;
/**
 * hide and remove hud from superview
 */
-(ModeHUD*(^)())md_hideHUD;
/**
 * show tick animation view
 */
//-(ModeHUD*(^)())md_showTickAnimationView;
/**
 * show loading view
 */
//-(ModeHUD*(^)())md_showLoadingView;
/**
 * show hud by manual
 */
-(ModeHUD*(^)())md_show;
@end
