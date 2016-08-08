//
//  RXPost.m
//  RXExtenstion
//
//  Created by srx on 16/7/14.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//
//系统 原生 请求
#import "RXPost.h"


#import "RXBundle.h"
//#import "RXCharacter.h"
#import "RXConstant.h"
#import "RXTodayModel.h"

//afn 请求用到的
//#import "RXAFNS.h"

//系统原生请求用到的
#import "RXResponse.h"

//  沙盒
#define UserDefaults  [NSUserDefaults standardUserDefaults]
// 接口
#define Method        @"talent.talent2.get_coup_list"
//操作系统版本
#define SYSTEMVERSION [UIDevice currentDevice].systemVersion

#define Today_userdefault @"todayData"

typedef void(^httpCompletion)(NSArray * array, BOOL isError);


@interface RXPost()
{
    NSURLSessionDataTask * _dataTask;
}
@property (nonatomic, copy) httpCompletion httpCompletion;
@end


@implementation RXPost

#pragma mark - ~~~~~~~~~~~ 请求网络数据 ~~~~~~~~~~~~~~~
//系统原生请求
- (void)postReqeustCompletion:(void (^)(NSArray *, BOOL))completion {
    
    
    
    NSURL * url = [NSURL URLWithString:@"http://app.ghs.net/index.php/api"];
    
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
    if(request == nil) {
        NSLog(@"Post invalid request");
        completion (nil, YES);
        return;
    }
    
    [request setHTTPMethod:@"POST"];
    
    //头文件，不好配置啊
    //    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //    [request setValue:@"text/html" forHTTPHeaderField:@"Content-Type"];
    //    [request setAllHTTPHeaderFields:headers];
    
    NSError * error = nil;
    
    //1、body 为 字符串 --> ut8
    NSData * data = [self paramsDataUTF8];
    
    //2、body 为 字典 --> json Data    【4003错误，估计是要转码吧】
    //    NSDictionary * dict = [self network];
    //    NSData * data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    if(error) {
        completion (nil, YES);
        NSLog(@"Post paramsDict error=%@", error.description);
        return;
    }
    [request setHTTPBody:data];
    
    //    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    //    NSURLSession * session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSession * session = [NSURLSession sharedSession];
    
    _dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"\n\nPost 请求结束\n------\n\n");
        if(error) {
            NSLog(@"Post dataTaskWithReques error =%@", error.description);\
            completion (nil, YES);
            return ;
        }
        else {
            if([response isKindOfClass:[NSURLResponse class]]) {
                NSLog(@"response=%@",(NSURLResponse *)response);
            }
        }
        
        NSError * jsonError = nil;
        NSDictionary * jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
        if(jsonError) {
            NSLog(@"Post jsonError error=%@", jsonError);
            completion (nil, YES);
        }
        else {
            NSLog(@"结果为=%@", jsonDict);
            RXResponse * responseObject = [RXResponse responseWithDict:jsonDict];
            if(!responseObject.status) {
                NSLog(@"error=%@", responseObject.message);
                completion(nil, YES);
                return ;
            }
            
            NSLog(@"请求下来的数据=%@", responseObject.returndata);
            
            if([responseObject.returndata arrBOOL]) {
                
                //获取数据
                NSArray * childrenArr = [responseObject.returndata[0] objectForKeyNotNull:@"children"];
                //总分页
                NSInteger totalePage = [[responseObject.returndata[0] objectForKeyNotNull:@"total_page"] integerValue];
                
                if([childrenArr arrBOOL]) {
                    NSMutableArray * array = [[NSMutableArray alloc] init];
                    for(NSDictionary * dict in childrenArr) {
                        RXTodayModel * coupModel = [RXTodayModel todayModelWithDictionary:dict];
                        [array addObject:coupModel];
                    }
                    [self setArrayToUserDefault:array];
                    completion(array, NO);
                }
                else {
                    completion(nil, YES);
                }
                
            }
            else {
                completion(nil, YES);
            }
            
        }
        
        
    }];
    
    [_dataTask resume];
    _httpCompletion = completion;
}


- (void)setArrayToUserDefault:(NSArray *)tempArray {
    @autoreleasepool {
        if (tempArray == nil)
        {
            [UserDefaults removeObjectForKey:Today_userdefault];
            [UserDefaults synchronize];
            return;
        }
        
        //NSKeyedArchiver     把对象写到二进制流中去。
        NSData *newData = [NSKeyedArchiver archivedDataWithRootObject:tempArray];
        [UserDefaults setObject:newData forKey:Today_userdefault];
        [UserDefaults synchronize];
    }
}


#pragma mark - ~~~~~~~~~~~ 获取本地数据 ~~~~~~~~~~~~~~~
- (NSArray *)getDataFromeLocalPost {
    
    NSData *oldData = [[NSUserDefaults standardUserDefaults] objectForKey:Today_userdefault] ;
    NSMutableArray * array = nil;
    if (oldData!=nil)
    {
        array = [NSKeyedUnarchiver unarchiveObjectWithData:oldData];
#if DEBUG
        
        NSLog(@"Post Have error data num = %lu",(unsigned long)[array count]);
#endif
    }
    NSMutableArray *errorLogArray = [[NSMutableArray alloc] init];
    if ([array count]>0)
    {
        NSInteger i = 0;
        //确保字典 key 一定是存在，否则崩溃
        for(RXTodayModel * todayModel in array)
        {
            NSMutableDictionary * paramsDict = [[NSMutableDictionary alloc] init];
            [paramsDict setObject:todayModel.talent_id     forKey:@"talent_id"    ];
            [paramsDict setObject:todayModel.coup_id       forKey:@"coup_id"      ];
            [paramsDict setObject:todayModel.talent_image  forKey:@"talent_image" ];
            [paramsDict setObject:todayModel.image         forKey:@"image"        ];
            [paramsDict setObject:todayModel.time          forKey:@"time"         ];
            [paramsDict setObject:todayModel.comment_count forKey:@"comment_count"];
            [paramsDict setObject:todayModel.view_count    forKey:@"view_count"   ];
            if(i == 3) {
                break;
            }
            i++;
        }
    }
    return errorLogArray;
}

- (NSDictionary *)network {
    
    
    //分页 0-7 //确保每次 定格到当前位置刷新得到新数据
    NSInteger page = arc4random() % 8;
    
    
    NSDictionary * paramsDict = @{@"method"   : Method,
                                  @"page_no"  : @1};
    
    
    
    NSMutableDictionary* newParams = [NSMutableDictionary  dictionaryWithDictionary:paramsDict];
    
    [newParams setObject:@"56874" forKey:@"member_id"];
    
    //APP 机型 iOS
    [newParams setObject:@"827384" forKey:@"device_type"];
    
    // APP版本号
    [newParams setObject:@"2.0.2" forKey:@"version"];
    
    
    
    
    
    [newParams setValue:@"226993C3C541A89BB72B2D312022A9AE" forKey:@"sign"];
    
    //用系统请求方法
    
    NSLog(@"请求参数=%@", newParams);
    return newParams;
    
}

- (NSData *)paramsDataUTF8{
    
    NSDictionary * dictParams = [self network];
    NSMutableString * string = [[NSMutableString alloc] init];
    for (NSString * key in dictParams.allKeys) {
        [string appendString:[NSString stringWithFormat:@"%@=%@&", key, dictParams[key]]];
    }
    
    [string setString:[string substringToIndex:string.length - 1]];
    NSLog(@"参数=%@", string);
    return [string dataUsingEncoding:NSUTF8StringEncoding];
}


//afn  不行啊
/*
 - (void)postReqeustCompletion:(void (^)(NSArray *, BOOL))completion {
 
 NSDictionary * paramsDict = [self network];
 
 [RXAFNS postReqeustWithParams:paramsDict successBlock:^(Response *responseObject) {
 
 if(!responseObject.status) {
 NSLog(@"error=%@", responseObject.message);
 completion(nil, YES);
 return ;
 }
 
 if([responseObject.returndata arrBOOL]) {
 
 //获取数据
 NSArray * childrenArr = [responseObject.returndata[0] objectForKeyNotNull:@"children"];
 //总分页
 NSInteger totalePage = [[responseObject.returndata[0] objectForKeyNotNull:@"total_page"] integerValue];
 
 if([childrenArr arrBOOL]) {
 NSMutableArray * array = [[NSMutableArray alloc] init];
 for(NSDictionary * dict in childrenArr) {
 RXTodayModel * coupModel = [RXTodayModel todayModelWithDictionary:dict];
 [array addObject:coupModel];
 }
 [self setArrayToUserDefault:array];
 completion(array, NO);
 }
 else {
 completion(nil, YES);
 }
 
 }
 else {
 completion(nil, YES);
 }
 
 } failureBlock:^(NSError *error) {
 NSLog(@"error=%@", error.description);
 completion(nil, YES);
 } showHUD:NO loadingInView:nil];
 
 }
 */


@end
