//
//  AutomaintainAPI.m
//  一号车库
//
//  Created by eric on 16/7/11.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "AutomaintainAPI.h"

#ifdef DEBUG
static NSString* urlPath = @"http://112.64.131.222/NoOne/api/";
#else

#endif

@implementation AutomaintainAPI
#pragma mark - 获取短信验证码
+(void)SMSVerificationCodeWithPhoneNum:(NSString *)phoneNum
                          withCallback:(Callback )callback
{
    NSString* urlStr =[urlPath stringByAppendingString:@"Sms/SendAndGetPhoneValidateCode"];
    NSMutableDictionary* dic = [NSMutableDictionary dictionary];
    dic[@"phoneNo"]=phoneNum;
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    
    [manager POST:urlStr parameters:dic progress:^(NSProgress * _Nonnull uploadProgress)
     {
         
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         if ([responseObject isKindOfClass:[NSDictionary class]])
         {
             NSDictionary* tempDic = (NSDictionary*)responseObject;
             
             BOOL IsSuccessed = [[tempDic objectForKey:@"IsSuccessed"]boolValue];
             if (IsSuccessed)
             {
                 NSDictionary* ReturnObject = [tempDic objectForKey:@"ReturnObject"];
                 callback(YES,nil,ReturnObject);
             }
             else
             {
                 NSString* ResultMessage = [tempDic objectForKey:@"ResultMessage"];
                 callback(NO,nil,ResultMessage);
             }
         }
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"error%@",error);
     }];
    
}
#pragma mark - 用户注册
+(void)signupWithUsername:(NSString *)username withPassword:(NSString *)password withCallback:(Callback)callback
{
    NSString* urlStr = [urlPath stringByAppendingString:@"Customer/CustomerRegister"];
    NSMutableDictionary* dic = [NSMutableDictionary dictionary];
    dic[@"username"]=username;
    dic[@"password"]=password;
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];

    [manager POST:urlStr parameters:dic progress:^(NSProgress * _Nonnull uploadProgress)
    {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSDictionary* tempDic = (NSDictionary*)responseObject;
         NSString* ReturnObject = [tempDic objectForKey:@"ReturnObject"];
         
         callback(YES,nil,ReturnObject);
         
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
         NSLog(@"注册error%@",error);
    }];

}
#pragma mark - 找回密码
+(void)changePasswordWithUsername:(NSString *)username withNewPassword:(NSString *)newPassword withCallback:(Callback)callback
{
    NSString* urlStr = [urlPath stringByAppendingString:@"Customer/SetCustomerPassword"];
    NSMutableDictionary* dic = [NSMutableDictionary dictionary];
    dic[@"username"]=username;
    dic[@"password"]=newPassword;
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    
    [manager POST:urlStr parameters:dic progress:^(NSProgress * _Nonnull uploadProgress)
     {
         
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSDictionary* tempDic = (NSDictionary*)responseObject;
         NSString* ReturnObject = [tempDic objectForKey:@"ReturnObject"];
         
         callback(YES,nil,ReturnObject);
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"找回密码error%@",error);
     }];
    
}

#pragma mark - 用户登录
+(void)loginWithUsername:(NSString *)username withpassword:(NSString *)password withCallback:(Callback)callback
{
    NSString* urlStr = [urlPath stringByAppendingString:@"Customer/CustomerLogin"];
    NSMutableDictionary* dic = [NSMutableDictionary dictionary];
    dic[@"username"]=username;
    dic[@"password"]=password;
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    
    [manager POST:urlStr parameters:dic progress:^(NSProgress * _Nonnull uploadProgress)
     {
         
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSDictionary* tempDic = (NSDictionary*)responseObject;
         BOOL IsSuccessed = [responseObject[@"IsSuccessed"] boolValue];
         if (IsSuccessed)
         {
             callback(YES,nil,responseObject);
         }
         else
         {
             NSString* ResultMessage = [tempDic objectForKey:@"ResultMessage"];
             callback(NO,nil,ResultMessage);
         }
         
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"注册error%@",error);
     }];
    
}
@end
