//
//  RXHttp.m
//  RXExtenstion
//
//  Created by srx on 16/7/21.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import "RXHttp.h"
#import "NSDictionary+NSStringUTF8.h"

@implementation RXHttp
+ (void)postWithURLString:(NSString *)urlString params:(NSDictionary *)params completion:(void (^)(id, NSString *))completion {
    
    if(urlString.length <= 0) {
        completion(nil, @"url错误");
    }
    
    NSURL * url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    if(request == nil) {
        RXLog(@"Post invalid request");
        completion (nil, @"Post invalid request");
        return;
    }
    
    [request setHTTPMethod:@"POST"];
    
    //头文件，不好配置啊
    //    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //    [request setValue:@"text/html" forHTTPHeaderField:@"Content-Type"];
    //    [request setAllHTTPHeaderFields:headers];
    
    //1、body 为 字符串 --> utf8
    NSData * data = [params toNSStringUTF8Data];
    [request setHTTPBody:data];
    
    
    NSURLSession * session = [NSURLSession sharedSession];
    
    
    NSURLSessionDataTask * _dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if(error) {
            completion(nil, error.description);
            return ;
        }
        
        //处理...
        
    }];
    
    
    
    //开始请求
    [_dataTask resume];
}

@end
