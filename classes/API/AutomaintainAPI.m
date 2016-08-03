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
         BOOL IsSuccessed = [[tempDic objectForKey:@"IsSuccessed"]boolValue];
         
         if (IsSuccessed)
         {
             NSDictionary* ReturnObjectDic = [tempDic objectForKey:@"ReturnObject"];
             
             LoginModel* loginModel = [LoginModel mj_objectWithKeyValues:ReturnObjectDic];
             callback(YES,nil,loginModel);
         }
         else
         {
             NSString* returnMessage = [tempDic objectForKey:@"ResultMessage"];
             callback(NO,nil,returnMessage);
         }
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"注册error%@",error);
     }];

}
#pragma mark - 找回密码
+(void)changePasswordWithUsername:(NSString *)username withNewPassword:(NSString *)newPassword withCallback:(Callback)callback
{
    NSString* urlStr = [urlPath stringByAppendingString:@"/api/Customer/FindCustomerPassword"];
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
#pragma mark - 会员登出
+(void)logoutWithAccessCode:(NSString *)accessCode withCallback:(Callback)callback
{
    NSString* urlStr = [urlPath stringByAppendingString:@"/api/Customer/CustomerLogout"];
    NSMutableDictionary* dic = [NSMutableDictionary dictionary];
    dic[@"accessCode"]=accessCode;
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    
    [manager POST:urlStr parameters:dic progress:^(NSProgress * _Nonnull uploadProgress)
     {
         
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSDictionary* tempDic = (NSDictionary*)responseObject;
         BOOL IsSuccessed = [tempDic[@"IsSuccessed"] boolValue];
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

#pragma mark - 预约洗车/预约维修时间列表

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
+(void)postCommentListWithAccessCode:(NSString *)accessCode
                       withPageIndex:(NSString *)pageIndex
                        withCallback:(Callback)callback
{
    NSString* urlStr = [urlPath stringByAppendingString:@"/api/Appointment/GetCommentForAppointment"];
    NSMutableDictionary* dic = [NSMutableDictionary dictionary];
    dic[@"accessCode"]=accessCode;
    dic[@"pageIndex"] = pageIndex;
    dic[@"pageSize"] = @"10";
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    
    [manager POST:urlStr parameters:dic progress:^(NSProgress * _Nonnull uploadProgress)
     {
         
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSDictionary* tempDic = (NSDictionary*)responseObject;
         BOOL IsSuccessed = [responseObject[@"IsSuccessed"] boolValue];
         if (IsSuccessed)
         {
             NSDictionary* returnObjectDic = [responseObject objectForKey:@"ReturnObject"];
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
             NSArray* orderTypeModelArr = [OrderTypeModel mj_objectArrayWithKeyValuesArray:ReturnObjectArr];
             callback(YES,nil,orderTypeModelArr);
             
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

#pragma mark - 我的预约列表
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
             NSDictionary* returnObjectDic = [responseObject objectForKey:@"ReturnObject"];
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
             NSString* ResultMessage = [tempDic objectForKey:@"ResultMessage"];
             callback(NO,nil,ResultMessage);
         }
         
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         callback(NO,nil,[error localizedDescription]);
     }];
    
}

#pragma mark - 取消预约
+(void)postCancelOrderWithAccessCode:(NSString *)accessCode
                 withAppointmentGuid:(NSString *)appointmentGuid
                        withCallback:(Callback)callback
{
    NSString* urlStr = [urlPath stringByAppendingString:@"/api/Appointment/CancelAppointment"];
    NSMutableDictionary* dic = [NSMutableDictionary dictionary];
    dic[@"accessCode"]=accessCode;
    dic[@"appointmentGuid"]=appointmentGuid;
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    
    [manager POST:urlStr parameters:dic progress:^(NSProgress * _Nonnull uploadProgress)
     {
         
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSDictionary* tempDic = (NSDictionary*)responseObject;
         BOOL IsSuccessed = [responseObject[@"IsSuccessed"] boolValue];
         if (IsSuccessed)
         {
             NSString* ResultMessage = [tempDic objectForKey:@"ResultMessage"];
             callback(YES,nil,ResultMessage);
             
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
#pragma mark - 意见反馈
+(void)postFeedbackWithAccessCode:(NSString *)accessCode
                         withType:(NSString *)type
               withCommentContent:(NSString *)commentContent
                     withCallback:(Callback)callback
{
    NSString* urlStr = [urlPath stringByAppendingString:@"/api/Customer/Feedback"];
    NSMutableDictionary* dic = [NSMutableDictionary dictionary];
    dic[@"accessCode"]=accessCode;
    dic[@"type"]=type;
    dic[@"commentContent"]=commentContent;
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    
    [manager POST:urlStr parameters:dic progress:^(NSProgress * _Nonnull uploadProgress)
     {
         
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSDictionary* tempDic = (NSDictionary*)responseObject;
         BOOL IsSuccessed = [tempDic[@"IsSuccessed"] boolValue];
         if (IsSuccessed)
         {
             callback(YES,nil,nil);
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

#pragma mark - 获取在线留言列表
+(void)postOnlineMessageListWithAccessCode:(NSString *)accessCode
                             withPageIndex:(NSString *)pageIndex
                              withCallback:(Callback)callback
{
    NSString* urlStr = [urlPath stringByAppendingString:@"/api/Customer/GetOnlineComment"];
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
             NSDictionary* returnObjectDic = [responseObject objectForKey:@"ReturnObject"];
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
             NSString* ResultMessage = [tempDic objectForKey:@"ResultMessage"];
             callback(NO,nil,ResultMessage);
         }
         
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"error%@",error);
     }];
    
}
#pragma mark - 提交我的留言
+(void)postMessageToServiceWithAccessCode:(NSString *)accessCode
                       withCommentContent:(NSString *)commentContent
                             withCallback:(Callback)callback
{
    NSString* urlStr = [urlPath stringByAppendingString:@"/api/Customer/OnlineComment"];
    NSMutableDictionary* dic = [NSMutableDictionary dictionary];
    dic[@"accessCode"]=accessCode;
    dic[@"commentContent"]=commentContent;
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    
    [manager POST:urlStr parameters:dic progress:^(NSProgress * _Nonnull uploadProgress)
     {
         
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSDictionary* tempDic = (NSDictionary*)responseObject;
         BOOL IsSuccessed = [responseObject[@"IsSuccessed"] boolValue];
         if (IsSuccessed)
         {
             callback(YES,nil,nil);
             
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

#pragma mark - 提交我的评论
+(void)postCommentToServiceWithAccessCode:(NSString*)accessCode
                                withStars:(NSString*)stars
                          withContentText:(NSString*)ContentText
                  withMaintainSubjectGuid:(NSString*)maintainSubjectGuid
                      withAppointmentGuid:(NSString*)appointmentGuid
                        withPhotoGuidList:(NSArray*)photoGuidList
                             withCallback:(Callback )callback
{
    NSString* urlStr = [urlPath stringByAppendingString:@"/api/Appointment/CommentForAppointment"];
    NSMutableDictionary* dic = [NSMutableDictionary dictionary];
    dic[@"accessCode"]=accessCode;
    dic[@"Stars"]=stars;
    dic[@"ContentText"]=ContentText;
    dic[@"MaintainSubjectGuid"]=maintainSubjectGuid;
    dic[@"AppointmentGuid"]=appointmentGuid;
    dic[@"photoGuidList"]=photoGuidList;
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    
    [manager POST:urlStr parameters:dic progress:^(NSProgress * _Nonnull uploadProgress)
     {
         
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSDictionary* tempDic = (NSDictionary*)responseObject;
         BOOL IsSuccessed = [responseObject[@"IsSuccessed"] boolValue];
         if (IsSuccessed)
         {
             callback(YES,nil,nil);
             
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

#pragma mark - 上传评论照片****和其他的请求方式不同
+(void)postUploadPhotoFileWithBinaryPhoto:(UIImage *)binaryPhoto withCallback:(Callback)callback
{
//    NSString* urlStr = @"http://192.168.2.137/ErpWebApi/api/File/UploadPhotoFile";
    NSString* urlStr = [urlPath stringByAppendingString:@"/api/File/UploadPhotoFile"];
    NSMutableDictionary* dic = [NSMutableDictionary dictionary];
    dic[@"accessCode"] = AppManagerSingleton.accessCode;
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    
    [manager POST:urlStr parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData)
     
     {
         NSData *imageData = UIImageJPEGRepresentation(binaryPhoto, 0.5);
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
         NSLog(@"error%@",error);
     }];
}

#pragma mark - 修改密码/POST 请求
+(void)postChangePasswordWithAccessCode:(NSString *)accessCode
                        withOldPassword:(NSString *)OldPassword
                        withNewPassword:(NSString *)NewPassword
                           withCallback:(Callback)callback
{
    NSString* urlStr = [urlPath stringByAppendingString:@"/api/Customer/SetCustomerPassword"];
    NSMutableDictionary* dic = [NSMutableDictionary dictionary];
    dic[@"accessCode"] = accessCode;
    dic[@"OldPassword"] = OldPassword;
    dic[@"NewPassword"] = NewPassword;
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    
    [manager POST:urlStr parameters:dic progress:^(NSProgress * _Nonnull uploadProgress)
     {
         
     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSDictionary* tempDic = (NSDictionary*)responseObject;
         BOOL IsSuccessed = [responseObject[@"IsSuccessed"] boolValue];
         if (IsSuccessed)
         {
             callback(YES,nil,nil);
             
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

#pragma mark - 更新会员头像/POST 请求
+(void)postUpdateCustomerAvatarWithAccessCode:(NSString *)accessCode withPhotoGuid:(NSString *)photoGuid withCallback:(Callback)callback
{
    NSString* urlStr = [urlPath stringByAppendingString:@"/api/Customer/UpdateCustomerAvatar"];
    NSMutableDictionary* dic = [NSMutableDictionary dictionary];
    dic[@"accessCode"] = accessCode;
    dic[@"photoGuid"] = photoGuid;
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    
    [manager POST:urlStr parameters:dic progress:^(NSProgress * _Nonnull uploadProgress)
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
         
         
     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         NSLog(@"error%@",error);
     }];

}
@end
