//
//  AutomaintainAPI.m
//  一号车库
//
//  Created by eric on 16/7/11.
//  Copyright © 2016年 eric. All rights reserved.
//

#import "AutomaintainAPI.h"
#import "LoginModel.h"
#import "AdsCarouselModel.h"
#import "ConvenienceServiceModel.h"
#import "BottomAdsModel.h"
#import "WashCarDateListModel.h"
#import "UserCommentModel.h"
#import "MyOrderModel.h"

#ifdef DEBUG
static NSString* urlPath = @"http://112.64.131.222/NoOne";
#else

#endif

@implementation AutomaintainAPI
#pragma mark - 获取短信验证码
+(void)SMSVerificationCodeWithPhoneNum:(NSString *)phoneNum
                         withIsExisted:(NSString*)IsExisted
                          withCallback:(Callback)callback
{
    NSString* urlStr =[urlPath stringByAppendingString:@"/api/Sms/SendAndGetPhoneValidateCode"];
    NSMutableDictionary* dic = [NSMutableDictionary dictionary];
    dic[@"phoneNo"]=phoneNum;
    dic[@"IsExisted"]=IsExisted;
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
    NSString* urlStr = [urlPath stringByAppendingString:@"/api/Customer/CustomerRegister"];
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
    NSString* urlStr = [urlPath stringByAppendingString:@"/api/Customer/SetCustomerPassword"];
    NSMutableDictionary* dic = [NSMutableDictionary dictionary];
    dic[@"username"]=username;
    dic[@"password"]=newPassword;
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    
    [manager POST:urlStr parameters:dic progress:^(NSProgress * _Nonnull uploadProgress)
     {
         
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSDictionary* tempDic = (NSDictionary*)responseObject;
         BOOL IsSuccessed = [[tempDic objectForKey:@"IsSuccessed"]boolValue];
         if (IsSuccessed)
         {
             NSString* ReturnObject = [tempDic objectForKey:@"ReturnObject"];
             
             callback(YES,nil,ReturnObject);
         }
         else
         {
             NSString* ResultMessage = [tempDic objectForKey:@"ResultMessage"];
             callback(NO,nil,ResultMessage);
         }
         
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"找回密码error%@",error);
     }];
    
}

#pragma mark - 用户登录
+(void)loginWithUsername:(NSString *)username withpassword:(NSString *)password withCallback:(Callback)callback
{
    NSString* urlStr = [urlPath stringByAppendingString:@"/api/Customer/CustomerLogin"];
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
             NSDictionary* ReturnObjectDic = [responseObject objectForKey:@"ReturnObject"];
             LoginModel* loginModel = [LoginModel mj_objectWithKeyValues:ReturnObjectDic];
             callback(YES,nil,loginModel);
         }
         else
         {
             NSString* ResultMessage = [tempDic objectForKey:@"ResultMessage"];
             callback(NO,nil,ResultMessage);
         }
         
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"error%@",error);
     }];
    
}
#pragma mark - 首页轮播图请求
+(void)postListofAdsCarouselWithAccessCode:(NSString *)accessCode withCallback:(Callback)callback
{
    NSString* urlStr = [urlPath stringByAppendingString:@"/api/Ads/GetCarousel"];
    NSMutableDictionary* dic = [NSMutableDictionary dictionary];
    dic[@"accessCode"]=accessCode;
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    
    [manager POST:urlStr parameters:dic progress:^(NSProgress * _Nonnull uploadProgress)
     {
         
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSDictionary* tempDic = (NSDictionary*)responseObject;
         BOOL IsSuccessed = [responseObject[@"IsSuccessed"] boolValue];
         if (IsSuccessed)
         {
            NSDictionary* ReturnObjectDic = [responseObject objectForKey:@"ReturnObject"];
             NSArray* adsCarouselModelArr = [AdsCarouselModel mj_objectArrayWithKeyValuesArray:ReturnObjectDic];
             callback(YES,nil,adsCarouselModelArr);
         }
         else
         {
             NSString* ResultMessage = [tempDic objectForKey:@"ResultMessage"];
             callback(NO,nil,ResultMessage);
         }
         
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"error%@",error);
     }];
}
#pragma mark - 首页免费便民服务
+(void)postListofConvenienceServiceWithAccessCode:(NSString *)accessCode withCallback:(Callback)callback
{
    NSString* urlStr = [urlPath stringByAppendingString:@"/api/Ads/GetConvenienceService"];
    NSMutableDictionary* dic = [NSMutableDictionary dictionary];
    dic[@"accessCode"]=accessCode;
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    
    [manager POST:urlStr parameters:dic progress:^(NSProgress * _Nonnull uploadProgress)
     {
         
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSDictionary* tempDic = (NSDictionary*)responseObject;
         BOOL IsSuccessed = [[tempDic objectForKey:@"IsSuccessed"]boolValue];
         if (IsSuccessed)
         {
             NSDictionary* ReturnObjectDic = [responseObject objectForKey:@"ReturnObject"];
             NSArray* convenienceServiceModelArr = [ConvenienceServiceModel mj_objectArrayWithKeyValuesArray:ReturnObjectDic];
             callback(YES,nil,convenienceServiceModelArr);
         }
         else
         {
             NSString* ResultMessage = [tempDic objectForKey:@"ResultMessage"];
             callback(NO,nil,ResultMessage);
         }
         
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"error%@",error);
     }];
}
#pragma mark - 首页底部广告图片
+(void)postListofBottomAdsWithAccessCode:(NSString *)accessCode withCallback:(Callback)callback
{
    NSString* urlStr = [urlPath stringByAppendingString:@"/api/Ads/GetAds"];
    NSMutableDictionary* dic = [NSMutableDictionary dictionary];
    dic[@"accessCode"]=accessCode;
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    
    [manager POST:urlStr parameters:dic progress:^(NSProgress * _Nonnull uploadProgress)
     {
         
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSDictionary* tempDic = (NSDictionary*)responseObject;
         BOOL IsSuccessed = [responseObject[@"IsSuccessed"] boolValue];
         if (IsSuccessed)
         {
             NSDictionary* ReturnObjectDic = [responseObject objectForKey:@"ReturnObject"];
             NSArray* bottomAdsModelArr = [BottomAdsModel mj_objectArrayWithKeyValuesArray:ReturnObjectDic];
             callback(YES,nil,bottomAdsModelArr);
         }
         else
         {
             NSString* ResultMessage = [tempDic objectForKey:@"ResultMessage"];
             callback(NO,nil,ResultMessage);
         }
         
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"error%@",error);
     }];
}

#pragma mark - 预约洗车时间列表

+(void)postListofWashCarPlaceListWithAccessCode:(NSString*)accessCode
                                withCurrentDate:(NSString*)currentDate
                                withSubjectGuid:(NSString*)subjectGuid
                                   withCallback:(Callback )callback
{
    NSString* urlStr = [urlPath stringByAppendingString:@"/api/Appointment/GetCarPlaceAppointmentList"];
    NSMutableDictionary* dic = [NSMutableDictionary dictionary];
    dic[@"accessCode"]=accessCode;
    dic[@"subjectGuid"]=subjectGuid;
    dic[@"date"]=currentDate;
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    
    [manager POST:urlStr parameters:dic progress:^(NSProgress * _Nonnull uploadProgress)
     {
         
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSDictionary* tempDic = (NSDictionary*)responseObject;
         BOOL IsSuccessed = [responseObject[@"IsSuccessed"] boolValue];
         if (IsSuccessed)
         {
             NSDictionary* ReturnObjectDic = [responseObject objectForKey:@"ReturnObject"];
             [WashCarDateListModel mj_setupObjectClassInArray:^NSDictionary *{
                 return @{
                          @"Schedule" : @"ScheduleListModel"
                          };
             }];
             WashCarDateListModel* washCarDateListModel = [WashCarDateListModel mj_objectWithKeyValues:ReturnObjectDic];
             callback(YES,nil,washCarDateListModel);
               
         }
         
         else
         {
             NSString* ResultMessage = [tempDic objectForKey:@"ResultMessage"];
             callback(NO,nil,ResultMessage);
         }
         
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"error%@",error);
     }];
}
#pragma mark - 提交预约
+(void)postAppointmentServiceWithAccessCode:(NSString *)accessCode withAppointmentStartTime:(NSString *)appointmentStartTime withSubjectGuid:(NSString *)subjectGuid withCallback:(Callback)callback
{
    NSString* urlStr = [urlPath stringByAppendingString:@"/api/Appointment/AppointmentService"];
    NSMutableDictionary* dic = [NSMutableDictionary dictionary];
    dic[@"accessCode"]=accessCode;
    dic[@"subjectGuid"]=subjectGuid;
    dic[@"appointmentStartTime"]=appointmentStartTime;
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    
    [manager POST:urlStr parameters:dic progress:^(NSProgress * _Nonnull uploadProgress)
     {
         
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSDictionary* tempDic = (NSDictionary*)responseObject;
         BOOL IsSuccessed = [responseObject[@"IsSuccessed"] boolValue];
         if (IsSuccessed)
         {
             NSString* ReturnObject = [responseObject objectForKey:@"ReturnObject"];
             
             callback(YES,nil,ReturnObject);
             
         }
         
         else
         {
             NSString* ResultMessage = [tempDic objectForKey:@"ResultMessage"];
             callback(NO,nil,ResultMessage);
         }
         
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"error%@",error);
     }];

}
#pragma mark - 获取预约的评论列表
+(void)postCommentListWithAccessCode:(NSString *)accessCode withMaintianSubjectGuid:(NSString *)maintianSubjectGuid withCallback:(Callback)callback
{
    NSString* urlStr = [urlPath stringByAppendingString:@"/api/Appointment/GetCommentForAppointment"];
    NSMutableDictionary* dic = [NSMutableDictionary dictionary];
    dic[@"accessCode"]=accessCode;
    dic[@"MaintianSubjectGuid"]=maintianSubjectGuid;
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    
    [manager POST:urlStr parameters:dic progress:^(NSProgress * _Nonnull uploadProgress)
     {
         
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSDictionary* tempDic = (NSDictionary*)responseObject;
         BOOL IsSuccessed = [responseObject[@"IsSuccessed"] boolValue];
         if (IsSuccessed)
         {
             NSArray* ReturnObjectArr = [responseObject objectForKey:@"ReturnObject"];
             NSArray* userCommentModelArr = [UserCommentModel mj_objectArrayWithKeyValuesArray:ReturnObjectArr];
             callback(YES,nil,userCommentModelArr);
             
         }
         
         else
         {
             NSString* ResultMessage = [tempDic objectForKey:@"ResultMessage"];
             callback(NO,nil,ResultMessage);
         }
         
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"error%@",error);
     }];
}
#pragma mark - 获取预约类型列表
+(void)postOrderTypeListWithAccessCode:(NSString *)accessCode withCallback:(Callback)callback
{
    NSString* urlStr = [urlPath stringByAppendingString:@"/api/Appointment/GetMaintainSubject"];
    NSMutableDictionary* dic = [NSMutableDictionary dictionary];
    dic[@"accessCode"]=accessCode;
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    
    [manager POST:urlStr parameters:dic progress:^(NSProgress * _Nonnull uploadProgress)
     {
         
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSDictionary* tempDic = (NSDictionary*)responseObject;
         BOOL IsSuccessed = [responseObject[@"IsSuccessed"] boolValue];
         if (IsSuccessed)
         {
             NSArray* ReturnObjectArr = [responseObject objectForKey:@"ReturnObject"];
             NSArray* userCommentModelArr = [UserCommentModel mj_objectArrayWithKeyValuesArray:ReturnObjectArr];
             callback(YES,nil,userCommentModelArr);
             
         }
         
         else
         {
             NSString* ResultMessage = [tempDic objectForKey:@"ResultMessage"];
             callback(NO,nil,ResultMessage);
         }
         
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"error%@",error);
     }];

}

#pragma mark - 获取我的预约列表
+(void)postMyOrderListWithAccessCode:(NSString *)accessCode
                       withPageIndex:(NSString *)pageIndex
                        withCallback:(Callback)callback
{
    NSString* urlStr = [urlPath stringByAppendingString:@"/api/Appointment/GetCustomerAppointmentList"];
    NSMutableDictionary* dic = [NSMutableDictionary dictionary];
    dic[@"accessCode"]=accessCode;
    dic[@"pageIndex"]=pageIndex;
    dic[@"pageSize"]=@"10";
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    
    [manager POST:urlStr parameters:dic progress:^(NSProgress * _Nonnull uploadProgress)
     {
         
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSDictionary* tempDic = (NSDictionary*)responseObject;
         BOOL IsSuccessed = [responseObject[@"IsSuccessed"] boolValue];
         if (IsSuccessed)
         {
             NSArray* ReturnObjectArr = [responseObject objectForKey:@"ReturnObject"];
             NSArray* myOrderModelArr = [MyOrderModel mj_objectArrayWithKeyValuesArray:ReturnObjectArr];
             callback(YES,nil,myOrderModelArr);
             
         }
         
         else
         {
             NSString* ResultMessage = [tempDic objectForKey:@"ResultMessage"];
             callback(NO,nil,ResultMessage);
         }
         
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"error%@",error);
     }];

}
@end
