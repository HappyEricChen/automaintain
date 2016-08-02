//
//  UUID.m
//  一号车库
//
//  Created by eric on 16/8/2.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "UUID.h"
#import "KeyChainStore.h"

@implementation UUID

+(NSString *)getUUID
{
    NSString * strUUID = (NSString *)[KeyChainStore load:@"com.company.app.uuid"];
    
    //首次执行该方法时，uuid为空
    if ([strUUID isEqualToString:@""] || !strUUID)
    {
        //生成一个uuid的方法
        CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
        
        strUUID = (NSString *)CFBridgingRelease(CFUUIDCreateString (kCFAllocatorDefault,uuidRef));
        
        //将该uuid保存到keychain
        [KeyChainStore save:KEY_UUID data:strUUID];
        
    }
    return strUUID;
}
@end
