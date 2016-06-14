//
//  RXAFNS.m
//  RXExtenstion
//
//  Created by srx on 16/4/29.
//  Copyright © 2016年 srxboys. All rights reserved.
//

#import "RXAFNS.h"
#import "RXMJHeader.h"
#import "RXBundle.h"
#import "RXCharacter.h"
#import "AppDelegate.h"

#import "RXPrisonBreak.h"

#define SERVER_URL @"https://github.com/srxboys"
#define CharString(__iPhone) [NSString stringWithFormat:@"iPhone%@", __iPhone]

#define loadingWidthHeight 0



@implementation RXAFNS

+ (NSDictionary *)constructParameters:(NSDictionary *)params
{
    /*
     * 每个接口必传的 字段
     * 1、用户id  没有就传0 
     * 2、版本号 从info.plist里获取
     * 3、设备 是 iOS 、android
     */
    
    
    NSMutableDictionary* newParams = [NSMutableDictionary  dictionaryWithDictionary:params];
    
    
//    NSString * user_id = @"app登录后的 用户id";
    
    //APP 机型 iOS
//    [newParams setObject:user_id forKey:@"user_id"];
    [newParams setObject:@"iOS" forKey:@"device_type"];
    
    // APP版本号
    [newParams setObject:[RXBundle bundleVersion] forKey:@"version"];
    
    //型号
    NSString * device = [RXBundle bundlePhoneModel];
    
    //系统版本
    NSString * system = SYSTEMVERSION; //iOS 几
    
    //是否越狱
    NSString * prisonBreak = [[UserDefaults objectForKey:prisonBreakDefault] boolValue]? @"越狱" : @"非越狱";
    

    //假数据 --- 随机 user_id
    //    NSString *idsss = IntTranslateStr(arc4random() % 10000 + 10);
    //    [newParams setObject:idsss  forKey:@"user_id"];
    return newParams;
}

+ (void)postReqeustWithParams:(NSDictionary*)paramsDict
                 successBlock:(void (^)(Response * responseObject))successBlock
                 failureBlock:(void (^)(NSError * error))failureBlock
                      showHUD:(BOOL)showHUD  loadingInView:(UIView *)view{
    
    RXMJHeader * loadView = [[RXMJHeader alloc] initWithFrame:CGRectMake(0, (ScreenHeight - loadingWidthHeight)/2.0, ScreenWidth, loadingWidthHeight)];
    UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(0, NavHeight, ScreenWidth, ScreenHeight - NavHeight)];
    backView.backgroundColor = [UIColor clearColor];
    [backView addSubview:loadView];
    
    if(view) {
        [view addSubview:loadView];
    }
    else {
        [SharedAppDelegate.window addSubview:loadView];
    }
    __weak RXMJHeader * _loadingView = loadView;
    __weak UIView    * _backView = backView;
    /*-------------【转圈】---------------*/
    if(showHUD) {
        [_loadingView animationStart];
    }
    else {
        [_loadingView removeFromSuperview];
        [_backView removeFromSuperview];
    }
    
    //1、添加默认 用户 和 系统类型
    NSDictionary *newParams = [self constructParameters:paramsDict];
    
    
    NSMutableString * str = [NSMutableString stringWithString:SERVER_URL];
    NSInteger i = 0;
    for(NSString * key in newParams.allKeys) {
        if(i == 0) {
            [str appendFormat:@"?%@=%@", key,  newParams[key]];
        }
        else {
            [str appendFormat:@"&%@=%@", key,newParams[key]];
        }
        i++;
    }
    
    RXLog(@"请求网址=%@", str);
    
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 60;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/html", nil];
    [manager POST:SERVER_URL parameters:newParams progress:^(NSProgress * _Nonnull uploadProgress) {
        //请求、或者 下载、加载速度 做高级等待动画
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        /*---移除 转圈--*/
        if(showHUD) {
            [_loadingView animationStop];
            [_loadingView removeFromSuperview];
            [_backView removeFromSuperview];
        }

        //----------------------
        Response * response = [Response responseWithDict:responseObject];
        successBlock(response);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        /*---移除 转圈--*/
        if(showHUD) {
            [_loadingView animationStop];
            [_loadingView removeFromSuperview];
            [_backView removeFromSuperview];;
        }
        failureBlock(error);
    }];
}


+ (void)UploadDIYRequestWithParams:(NSDictionary *)paramsDict uploadParamsDIY:(void (^)(id <AFMultipartFormData> formData))uploadParamsDIY successBlock:(void (^)(Response *))successBlock failureBlock:(void (^)(NSError *))failureBlock showHUD:(BOOL)showHUD  loadingInView:(UIView *)view{
    
    RXMJHeader * loadView = [[RXMJHeader alloc] initWithFrame:CGRectMake(0, (ScreenHeight - loadingWidthHeight)/2.0, ScreenWidth, loadingWidthHeight)];
    UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(0, NavHeight, ScreenWidth, ScreenHeight - NavHeight)];
    backView.backgroundColor = [UIColor clearColor];
    [backView addSubview:loadView];
    
    if(view) {
        [view addSubview:loadView];
    }
    else {
        [SharedAppDelegate.window addSubview:loadView];
    }
    __weak RXMJHeader * _loadingView = loadView;
    __weak UIView    * _backView = backView;
    /*-------------【转圈】---------------*/
    if(showHUD) {
        [_loadingView animationStart];
    }
    else {
        [_loadingView removeFromSuperview];
        [_backView removeFromSuperview];
    }
    
    //1、添加默认 用户 和 系统类型
    NSDictionary *newParams = [self constructParameters:paramsDict];
    
    

    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 60;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/html", nil];
    
    
    
    [manager POST:SERVER_URL parameters:newParams constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        uploadParamsDIY(formData);
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //请求、或者 下载、加载速度 做高级等待动画
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        /*---移除 转圈--*/
        if(showHUD) {
            [_loadingView animationStop];
            [_loadingView removeFromSuperview];
            [_backView removeFromSuperview];
        }
        Response * response = [Response responseWithDict:responseObject];
        successBlock(response);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        /*---移除 转圈--*/
        if(showHUD) {
            [_loadingView animationStop];
            [_loadingView removeFromSuperview];
            [_backView removeFromSuperview];
        }
        failureBlock(error);
    }];
}

//移除请求
+ (void)removeRequestWithParams:(NSDictionary *)paramsDict {
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager DELETE:SERVER_URL parameters:paramsDict success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        RXLog(@"移除 请求成功");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        RXLog(@"移除 请求失败");
    }];
    
}







//监听网络状态 -- 为以后用
+ (void)startMonitoring
{
    // 1.获得网络监控的管理者
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    // 2.设置网络状态改变后的处理
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态改变了, 就会调用这个block
        switch (status)
        {
            case AFNetworkReachabilityStatusUnknown: // 未知网络
                //"未知网络"
//                _httpAPIClient.networkError = NO;
                break;
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
//                _httpAPIClient.networkError = YES;
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
                //手机自带网络"//
//                _httpAPIClient.networkError = NO;
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                //"WIFI"
//                _httpAPIClient.networkError = NO;
                break;
        }
    }];
    [mgr startMonitoring];
}

@end


#pragma mark ---------------------请求回来的JSON数据参数 处理--------------------
@interface NSDictionary (TextNullReplaceAFNS)
- (id)objectForKeyNotNullAFNS:(NSString *)key;
@end

@implementation NSDictionary (TextNullReplaceAFNS)

- (id)objectForKeyNotNullAFNS:(NSString *)key
{
    id object = [self objectForKey:key];
    if ([object isKindOfClass:[NSNumber class]] ||
        [object isKindOfClass:[NSString class]] ||
        [object isKindOfClass:[NSArray class]] ||
        [object isKindOfClass:[NSDictionary class]])
    {
        return object;
    }
    return nil;
}

@end

@implementation Response

/*
    处理返回数据 格式模型
    
    JSON
 
    // 情况1
    {
        "data" : {
            "message" : "请求成功",
            "status"  : "YES"
            "returndata" :
               NSString / NSArray / NSDictionary -> NSArray (是字典、字符串也转换成数组)
 
        },
        "rsp" : "succ" / "fail" //fail服务器错误
    }
 
 
     // 情况2
     {
         "data" : {
             "message" : "请求失败",
             "status"  : "NO"
         },
         "rsp" : "succ" / "fail"  //fail服务器错误
     }
 
 */

+ (Response*)responseWithDict:(NSDictionary*)dict {
    Response* response = [[Response alloc] init];
    
    NSDictionary *dataDic = [dict objectForKeyNotNullAFNS:@"data"];
    
    if([dict[@"rsp"] isEqualToString:@"fail"]) {
        RXLog(@"HTTP:error.info=%@", dict[@"res"]);
    }
    
    if ([[dict objectForKeyNotNullAFNS:@"data"] isKindOfClass:[NSArray class]])
    {
        if ([dict[@"rsp"] isEqualToString:@"succ"])
        {
            response.status = YES;
        }else
        {
            response.status = NO;
        }
        return response;
    }
    
    if ([[dict objectForKey:@"data"] isKindOfClass:[NSDictionary class]])
    {
        //会把字典变数组
        response.message = [dataDic objectForKeyNotNullAFNS:@"message"];
        response.status = [[dataDic objectForKeyNotNullAFNS:@"status"] boolValue];
        response.returndata = [[dataDic objectForKeyNotNullAFNS:@"returndata"] arrValue];
        return response;
    }else
    {
        response.message = @"网络请求失败";
        response.status = NO;
        return response;
    }
}
@end
