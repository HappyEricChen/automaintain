//
//  NSData+Encryption.m
//  一号车库
//
//  Created by eric on 16/8/15.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "NSData+Encryption.h"
#import <CommonCrypto/CommonCrypto.h>

#define AES_IV @"0000000000000000"

static char base64[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

@implementation NSData (Encryption)

- (NSData *)aes256_encrypt:(NSString *)key   //加密
{
    char keyPtr[kCCKeySizeAES256+1];//创建一个长度为33的字节数组keyptr[32+1]
    bzero(keyPtr, sizeof(keyPtr));//将整个字节数组清零
     ;
    NSUInteger dataLength = [self length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding ,
                                          keyPtr, kCCBlockSizeAES128,
                                          [AES_IV UTF8String],
                                          [self bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    free(buffer);
    return nil;
}

- (NSData *)aes256_decrypt:(NSString *)key   //解密
{
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [self length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding ,
                                          keyPtr, kCCBlockSizeAES128,
                                          [AES_IV UTF8String],
                                          [self bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesDecrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
        
    }
    free(buffer);
    return nil;
}

//追加64编码
- (NSString *)newStringInBase64FromData

{
    
    NSMutableString *dest = [[NSMutableString alloc] initWithString:@""];
    
    unsigned char * working = (unsigned char *)[self bytes];
    
    int srcLen = (int)[self length];
    
    for (int i=0; i<srcLen; i += 3) {
        
        for (int nib=0; nib<4; nib++) {
            
            int byt = (nib == 0)?0:nib-1;
            
            int ix = (nib+1)*2;
            
            if (i+byt >= srcLen) break;
            
            unsigned char curr = ((working[i+byt] << (8-ix)) & 0x3F);
            
            if (i+nib < srcLen) curr |= ((working[i+nib] >> ix) & 0x3F);
            
            [dest appendFormat:@"%c", base64[curr]];
            
        }
        
    }
    
    return dest;
    
}



+ (NSString*)base64encode:(NSString*)str

{
    
    if ([str length] == 0)
        
        return @"";
    
    const char *source = [str UTF8String];
    
    int strlength  = (int)strlen(source);
    
    char *characters = malloc(((strlength + 2) / 3) * 4);
    
    if (characters == NULL)
        
        return nil;
    
    NSUInteger length = 0;
    
    NSUInteger i = 0;
    
    while (i < strlength) {
        
        char buffer[3] = {0,0,0};
        
        short bufferLength = 0;
        
        while (bufferLength < 3 && i < strlength)
            
            buffer[bufferLength++] = source[i++];
        
        characters[length++] = base64[(buffer[0] & 0xFC) >> 2];
        
        characters[length++] = base64[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
        
        if (bufferLength > 1)
            
            characters[length++] = base64[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
        
        else characters[length++] = '=';
        
        if (bufferLength > 2)
            
            characters[length++] = base64[buffer[2] & 0x3F];
        
        else characters[length++] = '=';
        
    }
    
    NSString *g = [[NSString alloc] initWithBytesNoCopy:characters length:length encoding:NSASCIIStringEncoding freeWhenDone:YES];
    
    
    return g;
    
}

@end
