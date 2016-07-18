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


















@implementation NSObject (strNotEmptyValue)
- (NSString *)strNotEmptyValue {
    if ([self isKindOfClass:[NSString class]] && ((NSString *)self).length >0 && [((NSString *)self) isEqualToString:@"<null>"]) {
        return @"";
    }else if (self == nil || self == [NSNull null] || ([self isKindOfClass:[NSString class]] && ((NSString *)self).length == 0)) {
        return @"";
    }else if ([self isKindOfClass:[NSNumber class]] && [((NSString *)self) integerValue]>0)
    {
        return [NSString stringWithFormat:@"%@", (id)self];
    }
    return ((NSString *)self);
}
@end

@implementation NSObject (strBOOL)
- (BOOL)strBOOL {
    if([self isKindOfClass:[NSString class]] && [((NSString *)self) isEqualToString:@"<null>"]) {
        return NO;
    }
    else if([self isKindOfClass:[NSString class]] && ((NSString *)self).length <= 0) {
        return NO;
    }
    else if(![self isKindOfClass:[NSString class]]) {
        return NO;
    }
    return YES;
}

@end


@implementation NSObject (arrBOOL)
- (BOOL)arrBOOL {
    if(![self isKindOfClass:[NSArray class]]) {
        return NO;
    }
    else if(((NSArray *)self).count <= 0) {
        return NO;
    }
    else {
        return YES;
    }
}
@end


@implementation NSObject (arrValue)

- (NSArray *)arrValue {
    if([self isKindOfClass:[NSNull class]]) {
        return @[];
    }
    else if([self isKindOfClass:[NSString class]] && ![self isEqual:@""]) {
        return @[self];
    }
    else if([self isEqual:@""]) {
        return @[];
    }
    else if([self isKindOfClass:[NSDictionary class]]) {
        return @[self];
    }
    else {
        return (NSArray *)self;
    }
}

@end


@implementation NSObject (urlBOOL)
- (BOOL)urlBOOL {
    if([self isKindOfClass:[NSNull class]]) {
        return NO;
    }
    else if([self isKindOfClass:[NSString class]] && [(NSString *)self isEqualToString:@""]){
        return NO;
    }
    else if(![self isKindOfClass:[NSString class]]) {
        return NO;
    }
    else if ([(NSString *)self rangeOfString:@"http://"].location != NSNotFound ) {
        return YES;
    }
    else if ([(NSString *)self rangeOfString:@"https://"].location != NSNotFound ) {
        return YES;
    }
    else {
        return NO;
    }
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












