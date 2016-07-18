//
//  AppManager.m
//  一号车库
//
//  Created by eric on 16/7/14.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "AppManager.h"

@implementation AppManager

+(AppManager *)sharedManager
{
    static AppManager * sharedInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

-(NSString *)accessCode
{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"accessCode"];
}

-(NSString *)currentDate
{
    NSDate * currentDate = [NSDate date];
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString* dateString = [dateFormatter stringFromDate:currentDate];
    
    return dateString;
}
@end
