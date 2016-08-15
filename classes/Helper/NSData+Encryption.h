//
//  NSData+Encryption.h
//  一号车库
//
//  Created by eric on 16/8/15.
//  Copyright © 2016年 eric. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSString;

@interface NSData (Encryption)

- (NSData *)aes256_encrypt:(NSString *)key;   //加密

- (NSData *)aes256_decrypt:(NSString *)key;   //解密

- (NSString *)newStringInBase64FromData;            //追加64编码

+ (NSString*)base64encode:(NSString*)str;           //同上64编码

@end
