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
#import "OrderTypeModel.h"
#import "OnlineMessageModel.h"

#define ERRORINFO @"网络异常，请稍后重试"

#ifdef DEBUG
//static NSString* urlPath = @"http://112.64.131.222/NoOne";
static NSString* urlPath = @"http://112.64.131.222/NoOnecar";
/**
 *  内部测试地址
 */
//static NSString* urlPath = @"http://192.168.2.135";

#else
//static NSString* urlPath = @"http://112.64.131.222/NoOne";
static NSString* urlPath = @"http://112.64.131.222/NoOnecar";
#endif

@implementation AutomaintainAPI

#pragma mark - 获取短信验证码
+(void)SMSVerificationCodeWithPhoneNum:(NSString *)phoneNum
                         withIsExisted:(NSString*)IsExisted
                          withCallback:(Callback)callback
{
    NSString* urlStr =[urlPath stringByAppendingString:@"/api/Sms/SendAndGetPhoneValidateCode"];
    NSMutableDictionary* dic = [NSMutableDictionary dictionaryWithDictionary:AppManagerSingleton.parameterDic];
    dic[@"phoneNo"]=phoneNum;
    dic[@"IsExisted"]=IsExisted;
    NSString* resultStr = [AppManagerSingleton generateMD5SignWithparameterDic:dic];//调用MD5加密方法，返回加密后的Str
    dic[@"sign"]=resultStr;
    
    /**
     *  调用封装过的网络请求方法
     */
    [self POSTRequestWith:urlStr withParameters:dic withCallback:^(BOOL success, NSError *error, id result)
     {
         if (success)
         {
             NSDictionary* ReturnObject = [result objectForKey:@"ReturnObject"];
             callback(YES,nil,ReturnObject);
             
         }
         else
         {
             callback(NO,nil,result);
         }
         
     }];
}
#pragma mark - 用户注册
+(void)signupWithUsername:(NSString *)username withPassword:(NSString *)password withCallback:(Callback)callback
{
    NSString* urlStr = [urlPath stringByAppendingString:@"/api/Customer/CustomerRegister"];
    NSMutableDictionary* dic = [NSMutableDictionary dictionaryWithDictionary:AppManagerSingleton.parameterDic];
    
    /**
     *  AES+Base64混合加密
     */
    NSString *passwordAES = [password aes256_encrypt:KEY_ASE];
    
    dic[@"username"]=username;
    dic[@"password"]=passwordAES;
    NSString* resultStr = [AppManagerSingleton generateMD5SignWithparameterDic:dic];//调用MD5加密方法，返回加密后的Str
    dic[@"sign"]=resultStr;
    
    /**
     *  调用封装过的网络请求方法
     */
    [self POSTRequestWith:urlStr withParameters:dic withCallback:^(BOOL success, NSError *error, id result)
     {
         if (success)
         {
             NSDictionary* ReturnObjectDic = [result objectForKey:@"ReturnObject"];
             LoginModel* loginModel = [LoginModel mj_objectWithKeyValues:ReturnObjectDic];
             callback(YES,nil,loginModel);
         }
         else
         {
             callback(NO,nil,result);
         }
         
     }];
}
#pragma mark - 找回密码
+(void)changePasswordWithUsername:(NSString *)username withNewPassword:(NSString *)newPassword withCallback:(Callback)callback
{
    NSString* urlStr = [urlPath stringByAppendingString:@"/api/Customer/FindCustomerPassword"];
    NSMutableDictionary* dic = [NSMutableDictionary dictionaryWithDictionary:AppManagerSingleton.parameterDic];
    
    /**
     *  AES+Base64混合加密
     */
    NSString *passwordAES = [newPassword aes256_encrypt:KEY_ASE];
    
    dic[@"username"]=username;
    dic[@"password"]=passwordAES;
    NSString* resultStr = [AppManagerSingleton generateMD5SignWithparameterDic:dic];//调用MD5加密方法，返回加密后的Str
    dic[@"sign"]=resultStr;
    
    /**
     *  调用封装过的网络请求方法
     */
    [self POSTRequestWith:urlStr withParameters:dic withCallback:^(BOOL success, NSError *error, id result)
     {
         if (success)
         {
             NSString* ReturnObject = [result objectForKey:@"ReturnObject"];
             callback(YES,nil,ReturnObject);
         }
         else
         {
             callback(NO,nil,result);
         }
         
     }];
}

#pragma mark - 用户登录
+(void)loginWithUsername:(NSString *)username withpassword:(NSString *)password withCallback:(Callback)callback
{
    NSString* urlStr = [urlPath stringByAppendingString:@"/api/Customer/CustomerLogin"];
    /**
     *  用带着时间戳的字典初始化新字典
     */
    NSMutableDictionary* dic = [NSMutableDictionary dictionaryWithDictionary:AppManagerSingleton.parameterDic];
    
    /**
     *  AES+Base64混合加密
     */
    NSString *passwordAES = [password aes256_encrypt:KEY_ASE];
    
    dic[@"username"]=username;
    dic[@"password"]=passwordAES;
    NSString* resultStr = [AppManagerSingleton generateMD5SignWithparameterDic:dic];//调用MD5加密方法，返回加密后的Str
    dic[@"sign"]=resultStr;
    
    /**
     *  调用封装过的网络请求方法
     */
    [self POSTRequestWith:urlStr withParameters:dic withCallback:^(BOOL success, NSError *error, id result)
     {
         if (success)
         {
             NSDictionary* ReturnObjectDic = [result objectForKey:@"ReturnObject"];
             LoginModel* loginModel = [LoginModel mj_objectWithKeyValues:ReturnObjectDic];
             callback(YES,nil,loginModel);
             
         }
         else
         {
             callback(NO,nil,result);
         }
         
     }];
}
#pragma mark - 会员登出
+(void)logoutWithAccessCode:(NSString *)accessCode withCallback:(Callback)callback
{
    NSString* urlStr = [urlPath stringByAppendingString:@"/api/Customer/CustomerLogout"];
    NSMutableDictionary* dic = [NSMutableDictionary dictionaryWithDictionary:AppManagerSingleton.parameterDic];
    dic[@"accessCode"]=accessCode;
    NSString* resultStr = [AppManagerSingleton generateMD5SignWithparameterDic:dic];//调用MD5加密方法，返回加密后的Str
    dic[@"sign"]=resultStr;
    
    /**
     *  调用封装过的网络请求方法
     */
    [self POSTRequestWith:urlStr withParameters:dic withCallback:^(BOOL success, NSError *error, id result)
     {
         if (success)
         {
             NSString* ReturnObject = [result objectForKey:@"ReturnObject"];
             callback(YES,nil,ReturnObject);
             
         }
         else
         {
             callback(NO,nil,result);
         }
         
     }];
    
}
#pragma mark - 首页轮播图请求
+(void)postListofAdsCarouselWithAccessCode:(NSString *)accessCode withCallback:(Callback)callback
{
    NSString* urlStr = [urlPath stringByAppendingString:@"/api/Ads/GetCarousel"];
    NSMutableDictionary* dic = [NSMutableDictionary dictionaryWithDictionary:AppManagerSingleton.parameterDic];
    dic[@"accessCode"]=accessCode;
    NSString* resultStr = [AppManagerSingleton generateMD5SignWithparameterDic:dic];//调用MD5加密方法，返回加密后的Str
    dic[@"sign"]=resultStr;
    
    /**
     *  调用封装过的网络请求方法
     */
    [self POSTRequestWith:urlStr withParameters:dic withCallback:^(BOOL success, NSError *error, id result)
     {
         if (success)
         {
             NSDictionary* ReturnObjectDic = [result objectForKey:@"ReturnObject"];
             NSArray* adsCarouselModelArr = [AdsCarouselModel mj_objectArrayWithKeyValuesArray:ReturnObjectDic];
             callback(YES,nil,adsCarouselModelArr);
             
         }
         else
         {
             callback(NO,nil,result);
         }
         
     }];
}
#pragma mark - 首页免费便民服务
+(void)postListofConvenienceServiceWithAccessCode:(NSString *)accessCode withCallback:(Callback)callback
{
    NSString* urlStr = [urlPath stringByAppendingString:@"/api/Ads/GetConvenienceService"];
    NSMutableDictionary* dic = [NSMutableDictionary dictionaryWithDictionary:AppManagerSingleton.parameterDic];
    dic[@"accessCode"]=accessCode;
    NSString* resultStr = [AppManagerSingleton generateMD5SignWithparameterDic:dic];//调用MD5加密方法，返回加密后的Str
    dic[@"sign"]=resultStr;
    
    /**
     *  调用封装过的网络请求方法
     */
    [self POSTRequestWith:urlStr withParameters:dic withCallback:^(BOOL success, NSError *error, id result)
     {
         if (success)
         {
             NSDictionary* ReturnObjectDic = [result objectForKey:@"ReturnObject"];
             NSArray* convenienceServiceModelArr = [ConvenienceServiceModel mj_objectArrayWithKeyValuesArray:ReturnObjectDic];
             callback(YES,nil,convenienceServiceModelArr);
             
         }
         else
         {
             callback(NO,nil,result);
         }
         
     }];
}
#pragma mark - 首页底部广告图片
+(void)postListofBottomAdsWithAccessCode:(NSString *)accessCode withCallback:(Callback)callback
{
    NSString* urlStr = [urlPath stringByAppendingString:@"/api/Ads/GetAds"];
    NSMutableDictionary* dic = [NSMutableDictionary dictionaryWithDictionary:AppManagerSingleton.parameterDic];
    dic[@"accessCode"]=accessCode;
    NSString* resultStr = [AppManagerSingleton generateMD5SignWithparameterDic:dic];//调用MD5加密方法，返回加密后的Str
    dic[@"sign"]=resultStr;
    
    /**
     *  调用封装过的网络请求方法
     */
    [self POSTRequestWith:urlStr withParameters:dic withCallback:^(BOOL success, NSError *error, id result)
     {
         if (success)
         {
             NSDictionary* ReturnObjectDic = [result objectForKey:@"ReturnObject"];
             NSArray* bottomAdsModelArr = [BottomAdsModel mj_objectArrayWithKeyValuesArray:ReturnObjectDic];
             callback(YES,nil,bottomAdsModelArr);
         }
         else
         {
             callback(NO,nil,result);
         }
         
     }];
}

#pragma mark - 预约洗车/预约维修时间列表

+(void)postListofWashCarPlaceListWithAccessCode:(NSString*)accessCode
                                withCurrentDate:(NSString*)currentDate
                                withSubjectGuid:(NSString*)subjectGuid
                                   withCallback:(Callback )callback
{
    NSString* urlStr = [urlPath stringByAppendingString:@"/api/Appointment/GetCarPlaceAppointmentList"];
    NSMutableDictionary* dic = [NSMutableDictionary dictionaryWithDictionary:AppManagerSingleton.parameterDic];
    dic[@"accessCode"]=accessCode;
    dic[@"subjectGuid"]=subjectGuid;
    dic[@"date"]=currentDate;
    NSString* resultStr = [AppManagerSingleton generateMD5SignWithparameterDic:dic];//调用MD5加密方法，返回加密后的Str
    dic[@"sign"]=resultStr;
    
    /**
     *  调用封装过的网络请求方法
     */
    [self POSTRequestWith:urlStr withParameters:dic withCallback:^(BOOL success, NSError *error, id result)
     {
         if (success)
         {
             NSDictionary* ReturnObjectDic = [result objectForKey:@"ReturnObject"];
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
             callback(NO,nil,result);
         }
         
     }];
}
#pragma mark - 提交预约
+(void)postAppointmentServiceWithAccessCode:(NSString *)accessCode
                   withAppointmentStartTime:(NSString *)appointmentStartTime
                            withSubjectGuid:(NSString *)subjectGuid
                                   withNote:(NSString *)note
                               withCallback:(Callback)callback
{
    NSString* urlStr = [urlPath stringByAppendingString:@"/api/Appointment/AppointmentService"];
    NSMutableDictionary* dic = [NSMutableDictionary dictionaryWithDictionary:AppManagerSingleton.parameterDic];
    dic[@"accessCode"]=accessCode;
    dic[@"subjectGuid"]=subjectGuid;
    dic[@"note"]=note;
    dic[@"appointmentStartTime"]=appointmentStartTime;
    NSString* resultStr = [AppManagerSingleton generateMD5SignWithparameterDic:dic];//调用MD5加密方法，返回加密后的Str
    dic[@"sign"]=resultStr;
    
    /**
     *  调用封装过的网络请求方法
     */
    [self POSTRequestWith:urlStr withParameters:dic withCallback:^(BOOL success, NSError *error, id result)
     {
         if (success)
         {
             NSString* ReturnObject = [result objectForKey:@"ReturnObject"];
             callback(YES,nil,ReturnObject);
             
         }
         else
         {
             callback(NO,nil,result);
         }
         
     }];
}
#pragma mark - 获取预约的评论列表
+(void)postCommentListWithAccessCode:(NSString *)accessCode
                       withPageIndex:(NSString *)pageIndex
                        withCallback:(Callback)callback
{
    NSString* urlStr = [urlPath stringByAppendingString:@"/api/Appointment/GetCommentForAppointment"];
    NSMutableDictionary* dic = [NSMutableDictionary dictionaryWithDictionary:AppManagerSingleton.parameterDic];
    dic[@"accessCode"]=accessCode;
    dic[@"pageIndex"] = pageIndex;
    dic[@"pageSize"] = COMMENT_PAGE_SIZE;
    NSString* resultStr = [AppManagerSingleton generateMD5SignWithparameterDic:dic];//调用MD5加密方法，返回加密后的Str
    dic[@"sign"]=resultStr;
    
    /**
     *  调用封装过的网络请求方法
     */
    [self POSTRequestWith:urlStr withParameters:dic withCallback:^(BOOL success, NSError *error, id result)
     {
         if (success)
         {
             NSDictionary* returnObjectDic = [result objectForKey:@"ReturnObject"];
             /**
              *  评论列表总数存plist
              */
             [[NSUserDefaults standardUserDefaults]setObject:[returnObjectDic objectForKey:@"Total"] forKey:@"commentTotalCount"];
             [[NSUserDefaults standardUserDefaults]synchronize];
             NSArray* ReturnObjectArr = [returnObjectDic objectForKey:@"List"];
             NSArray* userCommentModelArr = [UserCommentModel mj_objectArrayWithKeyValuesArray:ReturnObjectArr];
             callback(YES,nil,userCommentModelArr);
             
         }
         else
         {
             callback(NO,nil,result);
         }
         
     }];
}
#pragma mark - 获取预约类型列表
+(void)postOrderTypeListWithAccessCode:(NSString *)accessCode withCallback:(Callback)callback
{
    NSString* urlStr = [urlPath stringByAppendingString:@"/api/Appointment/GetMaintainSubject"];
    NSMutableDictionary* dic = [NSMutableDictionary dictionaryWithDictionary:AppManagerSingleton.parameterDic];
    dic[@"accessCode"]=accessCode;
    NSString* resultStr = [AppManagerSingleton generateMD5SignWithparameterDic:dic];//调用MD5加密方法，返回加密后的Str
    dic[@"sign"]=resultStr;
    
    /**
     *  调用封装过的网络请求方法
     */
    [self POSTRequestWith:urlStr withParameters:dic withCallback:^(BOOL success, NSError *error, id result)
     {
         if (success)
         {
             NSArray* ReturnObjectArr = [result objectForKey:@"ReturnObject"];
             NSArray* orderTypeModelArr = [OrderTypeModel mj_objectArrayWithKeyValuesArray:ReturnObjectArr];
             callback(YES,nil,orderTypeModelArr);
         }
         else
         {
             callback(NO,nil,result);
         }
         
     }];
}

#pragma mark - 我的预约列表
+(void)postMyOrderListWithAccessCode:(NSString *)accessCode
                       withPageIndex:(NSString *)pageIndex
                        withCallback:(Callback)callback
{
    NSString* urlStr = [urlPath stringByAppendingString:@"/api/Appointment/GetCustomerAppointmentList"];
    NSMutableDictionary* dic = [NSMutableDictionary dictionaryWithDictionary:AppManagerSingleton.parameterDic];
    dic[@"accessCode"]=accessCode;
    dic[@"pageIndex"]=pageIndex;
    dic[@"pageSize"]=COMMENT_PAGE_SIZE;
    NSString* resultStr = [AppManagerSingleton generateMD5SignWithparameterDic:dic];//调用MD5加密方法，返回加密后的Str
    dic[@"sign"]=resultStr;
    
    /**
     *  调用封装过的网络请求方法
     */
    [self POSTRequestWith:urlStr withParameters:dic withCallback:^(BOOL success, NSError *error, id result)
     {
         if (success)
         {
             NSDictionary* returnObjectDic = [result objectForKey:@"ReturnObject"];
             /**
              *  我的预约总数存到plist
              */
             [[NSUserDefaults standardUserDefaults]setObject:[returnObjectDic objectForKey:@"Total"] forKey:@"myOrderTotalCount"];
             [[NSUserDefaults standardUserDefaults]synchronize];
             NSArray* ReturnObjectArr = [returnObjectDic objectForKey:@"List"];
             
             NSArray* myOrderModelArr = [MyOrderModel mj_objectArrayWithKeyValuesArray:ReturnObjectArr];
             callback(YES,nil,myOrderModelArr);
         }
         else
         {
             callback(NO,nil,result);
         }
         
     }];
}

#pragma mark - 取消预约
+(void)postCancelOrderWithAccessCode:(NSString *)accessCode
                 withAppointmentGuid:(NSString *)appointmentGuid
                        withCallback:(Callback)callback
{
    NSString* urlStr = [urlPath stringByAppendingString:@"/api/Appointment/CancelAppointment"];
    NSMutableDictionary* dic = [NSMutableDictionary dictionaryWithDictionary:AppManagerSingleton.parameterDic];
    dic[@"accessCode"]=accessCode;
    dic[@"appointmentGuid"]=appointmentGuid;
    NSString* resultStr = [AppManagerSingleton generateMD5SignWithparameterDic:dic];//调用MD5加密方法，返回加密后的Str
    dic[@"sign"]=resultStr;
    
    /**
     *  调用封装过的网络请求方法
     */
    [self POSTRequestWith:urlStr withParameters:dic withCallback:^(BOOL success, NSError *error, id result)
     {
         if (success)
         {
             NSString* ResultMessage = [result objectForKey:@"ResultMessage"];
             callback(YES,nil,ResultMessage);
             
         }
         else
         {
             callback(NO,nil,result);
         }
         
     }];
}

#pragma mark - 意见反馈
+(void)postFeedbackWithAccessCode:(NSString *)accessCode
                         withType:(NSString *)type
               withCommentContent:(NSString *)commentContent
                     withCallback:(Callback)callback
{
    NSString* urlStr = [urlPath stringByAppendingString:@"/api/Customer/Feedback"];
    NSMutableDictionary* dic = [NSMutableDictionary dictionaryWithDictionary:AppManagerSingleton.parameterDic];
    dic[@"accessCode"]=accessCode;
    dic[@"type"]=type;
    dic[@"commentContent"]=commentContent;
    NSString* resultStr = [AppManagerSingleton generateMD5SignWithparameterDic:dic];//调用MD5加密方法，返回加密后的Str
    dic[@"sign"]=resultStr;
    
    /**
     *  调用封装过的网络请求方法
     */
    [self POSTRequestWith:urlStr withParameters:dic withCallback:^(BOOL success, NSError *error, id result)
     {
         if (success)
         {
             callback(YES,nil,nil);
             
         }
         else
         {
             callback(NO,nil,result);
         }
         
     }];
}

#pragma mark - 获取在线留言列表
+(void)postOnlineMessageListWithAccessCode:(NSString *)accessCode
                             withPageIndex:(NSString *)pageIndex
                              withCallback:(Callback)callback
{
    NSString* urlStr = [urlPath stringByAppendingString:@"/api/Customer/GetOnlineComment"];
    NSMutableDictionary* dic = [NSMutableDictionary dictionaryWithDictionary:AppManagerSingleton.parameterDic];
    dic[@"accessCode"]=accessCode;
    dic[@"pageIndex"]=pageIndex;
    dic[@"pageSize"]=MESSAGE_PAGE_SIZE;
    NSString* resultStr = [AppManagerSingleton generateMD5SignWithparameterDic:dic];//调用MD5加密方法，返回加密后的Str
    dic[@"sign"]=resultStr;
    
    /**
     *  调用封装过的网络请求方法
     */
    [self POSTRequestWith:urlStr withParameters:dic withCallback:^(BOOL success, NSError *error, id result)
     {
         if (success)
         {
             NSDictionary* returnObjectDic = [result objectForKey:@"ReturnObject"];
             /**
              *  在线留言总数存plist
              */
             [[NSUserDefaults standardUserDefaults]setObject:[returnObjectDic objectForKey:@"Total"] forKey:@"onlineMessageTotalCount"];
             [[NSUserDefaults standardUserDefaults]synchronize];
             NSArray* ReturnObjectArr = [returnObjectDic objectForKey:@"List"];
             NSArray* onlineMessageModelArr = [OnlineMessageModel mj_objectArrayWithKeyValuesArray:ReturnObjectArr];
             callback(YES,nil,onlineMessageModelArr);
             
         }
         else
         {
             callback(NO,nil,result);
         }
         
     }];
}

#pragma mark - 提交我的留言
+(void)postMessageToServiceWithAccessCode:(NSString *)accessCode
                       withCommentContent:(NSString *)commentContent
                             withCallback:(Callback)callback
{
    NSString* urlStr = [urlPath stringByAppendingString:@"/api/Customer/OnlineComment"];
    NSMutableDictionary* dic = [NSMutableDictionary dictionaryWithDictionary:AppManagerSingleton.parameterDic];
    dic[@"accessCode"]=accessCode;
    dic[@"commentContent"]=commentContent;
    NSString* resultStr = [AppManagerSingleton generateMD5SignWithparameterDic:dic];//调用MD5加密方法，返回加密后的Str
    dic[@"sign"]=resultStr;
    
    /**
     *  调用封装过的网络请求方法
     */
    [self POSTRequestWith:urlStr withParameters:dic withCallback:^(BOOL success, NSError *error, id result)
     {
         if (success)
         {
             callback(YES,nil,nil);
         }
         else
         {
             callback(NO,nil,result);
         }
         
     }];
}

#pragma mark - 提交我的评论
+(void)postCommentToServiceWithAccessCode:(NSString*)accessCode
                                withStars:(NSString*)stars
                          withContentText:(NSString*)ContentText
                  withMaintainSubjectGuid:(NSString*)maintainSubjectGuid
                      withAppointmentGuid:(NSString*)appointmentGuid
                        withPhotoGuidList:(NSString*)photoGuidList
                             withCallback:(Callback )callback
{
    NSString* urlStr = [urlPath stringByAppendingString:@"/api/Appointment/CommentForAppointment"];
    NSMutableDictionary* dic = [NSMutableDictionary dictionaryWithDictionary:AppManagerSingleton.parameterDic];
    dic[@"accessCode"]=accessCode;
    dic[@"Stars"]=stars;
    dic[@"ContentText"]=ContentText;
    dic[@"MaintainSubjectGuid"]=maintainSubjectGuid;
    dic[@"AppointmentGuid"]=appointmentGuid;
    dic[@"photoGuidList"]=photoGuidList;
    NSString* resultStr = [AppManagerSingleton generateMD5SignWithparameterDic:dic];//调用MD5加密方法，返回加密后的Str
    dic[@"sign"]=resultStr;
    
    /**
     *  调用封装过的网络请求方法
     */
    [self POSTRequestWith:urlStr withParameters:dic withCallback:^(BOOL success, NSError *error, id result)
     {
         if (success)
         {
             callback(YES,nil,nil);
         }
         else
         {
             callback(NO,nil,result);
         }
         
     }];
}

#pragma mark - 修改密码/POST 请求
+(void)postChangePasswordWithAccessCode:(NSString *)accessCode
                        withOldPassword:(NSString *)OldPassword
                        withNewPassword:(NSString *)NewPassword
                           withCallback:(Callback)callback
{
    NSString* urlStr = [urlPath stringByAppendingString:@"/api/Customer/SetCustomerPassword"];
    NSMutableDictionary* dic = [NSMutableDictionary dictionaryWithDictionary:AppManagerSingleton.parameterDic];
    
    /**
     *  AES+Base64混合加密
     */
    NSString *OldPasswordAES = [OldPassword aes256_encrypt:KEY_ASE];
    NSString *NewPasswordAES = [NewPassword aes256_encrypt:KEY_ASE];
    
    
    dic[@"accessCode"] = accessCode;
    dic[@"OldPassword"] = OldPasswordAES;
    dic[@"NewPassword"] = NewPasswordAES;
    NSString* resultStr = [AppManagerSingleton generateMD5SignWithparameterDic:dic];//调用MD5加密方法，返回加密后的Str
    dic[@"sign"]=resultStr;
    
    /**
     *  调用封装过的网络请求方法
     */
    [self POSTRequestWith:urlStr withParameters:dic withCallback:^(BOOL success, NSError *error, id result)
     {
         if (success)
         {
             callback(YES,nil,nil);
         }
         else
         {
             callback(NO,nil,result);
         }
         
     }];
}

#pragma mark - 更新会员头像/POST 请求
+(void)postUpdateCustomerAvatarWithAccessCode:(NSString *)accessCode withPhotoGuid:(NSString *)photoGuid withCallback:(Callback)callback
{
    NSString* urlStr = [urlPath stringByAppendingString:@"/api/Customer/UpdateCustomerAvatar"];
    NSMutableDictionary* dic = [NSMutableDictionary dictionaryWithDictionary:AppManagerSingleton.parameterDic];
    dic[@"accessCode"] = accessCode;
    dic[@"photoGuid"] = photoGuid;
    NSString* resultStr = [AppManagerSingleton generateMD5SignWithparameterDic:dic];//调用MD5加密方法，返回加密后的Str
    dic[@"sign"]=resultStr;
    
    /**
     *  调用封装过的网络请求方法
     */
    [self POSTRequestWith:urlStr withParameters:dic withCallback:^(BOOL success, NSError *error, id result)
     {
         if (success)
         {
             NSString* returnObject = [result objectForKey:@"ReturnObject"];
             callback(YES,nil,returnObject);
         }
         else
         {
             callback(NO,nil,result);
         }
         
     }];
}

#pragma mark - 上传头像照片****和其他的请求方式不同
+(void)postUploadPhotoFileWithBinaryPhoto:(UIImage *)binaryPhoto withCallback:(Callback)callback
{
    NSString* urlStr = [urlPath stringByAppendingString:@"/api/File/UploadPhotoFile"];
    NSMutableDictionary* dic = [NSMutableDictionary dictionaryWithDictionary:AppManagerSingleton.parameterDic];
    dic[@"accessCode"] = AppManagerSingleton.accessCode;
    NSString* resultStr = [AppManagerSingleton generateMD5SignWithparameterDic:dic];//调用MD5加密方法，返回加密后的Str
    dic[@"sign"]=resultStr;
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    
    [manager POST:urlStr parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
     
     {
         /**
          *  压缩图片上传
          */
         NSData *imageData = UIImageJPEGRepresentation(binaryPhoto, 0.1);
         if (imageData != nil)
         {
             
             [formData appendPartWithFileData:imageData name:@"filedata" fileName:@"test.jpg"mimeType:@"image/jpeg"]; //multipart/form-data
         }
     }
         progress:^(NSProgress * _Nonnull uploadProgress)
     {
         
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSDictionary* tempDic = (NSDictionary*)responseObject;
         BOOL IsSuccessed = [responseObject[@"IsSuccessed"] boolValue];
         if (IsSuccessed)
         {
             NSString* returnObject = [tempDic objectForKey:@"ReturnObject"];
             callback(YES,nil,returnObject);
         }
         
         else
         {
             NSString* ResultMessage = [tempDic objectForKey:@"ResultMessage"];
             callback(NO,nil,ResultMessage);
         }
         
     }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         callback(NO,nil,ERRORINFO);
     }];
}

#pragma mark -上传多张评论照片****和其他的请求方式不同

+ (NSURLSessionUploadTask*)uploadTaskWithImage:(UIImage*)image
                                    completion:(void (^)(NSURLResponse *response, id responseObject, NSError *error))completionBlock
{
    NSString* urlStr = [urlPath stringByAppendingString:@"/api/File/UploadPhotoFile"];
    NSMutableDictionary* dic = [NSMutableDictionary dictionaryWithDictionary:AppManagerSingleton.parameterDic];
    dic[@"accessCode"] = AppManagerSingleton.accessCode;
    NSString* resultStr = [AppManagerSingleton generateMD5SignWithparameterDic:dic];//调用MD5加密方法，返回加密后的Str
    dic[@"sign"]=resultStr;
    
    // 构造 NSURLRequest
    NSError* error = NULL;
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST"
                                                                                              URLString:urlStr
                                                                                             parameters:dic
                                                                              constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
                                    {
                                        /**
                                         *  将图片尺寸压缩成（屏幕宽度*屏幕宽度）
                                         */
                                        UIImage* tempImage = [image imageByScalingAndCroppingForSize:CGSizeMake(ScreenWidth, ScreenWidth)];
                                        /**
                                         *  将图片容量大小压缩
                                         */
                                        NSData* imageData = UIImageJPEGRepresentation(tempImage, 0.8);
                                        [formData appendPartWithFileData:imageData
                                                                    name:@"file"
                                                                fileName:@"test.jpg"
                                                                mimeType:@"image/jpeg"];
                                    }
                                                                                                  error:&error];
    
    // 可在此处配置验证信息
    // 将 NSURLRequest 与 completionBlock 包装为 NSURLSessionUploadTask
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request
                                                                       progress:^(NSProgress * _Nonnull uploadProgress)
                                          {
                                          }
                                                              completionHandler:completionBlock];
    
    return uploadTask;
}

#pragma mark - 基础的post网络请求方法，所有网络请求的公共方法

+(void)POSTRequestWith:(NSString*)urlStr withParameters:(NSDictionary*)parametersDic withCallback:(Callback)callback
{
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    
    [manager POST:urlStr parameters:parametersDic progress:^(NSProgress * _Nonnull uploadProgress)
     {
         
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSDictionary* tempDic = (NSDictionary*)responseObject;
         BOOL IsSuccessed = [tempDic[@"IsSuccessed"] boolValue];
         if (IsSuccessed)
         {
             callback(YES,nil,responseObject);
         }
         else
         {
             NSString* ResultMessage = [tempDic objectForKey:@"ResultMessage"];
             
             if ([ResultMessage containsString:@"Access code已过期!"])
             {
                 /**
                  *  AccessCode过期发送通知，退出登录
                  */
                 [[NSNotificationCenter defaultCenter]postNotificationName:kNotify_AccessCode_Overdue object:nil];
                 
             }
             else
             {
                 callback(NO,nil,ResultMessage);
             }
             
         }
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         callback(NO,nil,ERRORINFO);
     }];
    
}
@end
