//
//  RXResponse.m
//  RXExtenstion
//
//  Created by srx on 16/7/15.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import "RXResponse.h"

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

























@implementation RXResponse
+ (RXResponse*)responseWithDict:(NSDictionary*)dict {
    RXResponse* response = [[RXResponse alloc] init];
    
    NSDictionary *dataDic = [dict objectForKeyNotNullAFNS:@"data"];
    
    if([dict[@"rsp"] isEqualToString:@"fail"]) {
        NSLog(@"HTTP:error.info=%@", dict[@"res"]);
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












