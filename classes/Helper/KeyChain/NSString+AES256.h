//
//  NSString+AES256.h
//  一号车库
//
//  Created by eric on 16/8/15.
//  Copyright © 2016年 eric. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (AES256)

//加密
-(NSString *) aes256_encrypt:(NSString *)key;

//解密
-(NSString *) aes256_decrypt:(NSString *)key;
@end
