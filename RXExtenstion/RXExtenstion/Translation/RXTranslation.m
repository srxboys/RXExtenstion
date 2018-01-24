//
//  RXTransform.m
//  RXExtenstion
//
//  Created by srxboys on 2018/1/18.
//  Copyright © 2018年 https://github.com/srxboys. All rights reserved.
//

#import "RXTransform.h"


#pragma mark --- 对象转 NSData
@implementation NSObject(RXObjectTransform)
- (NSData *)data {
    return [self dataWithError:nil];
}

- (NSData *)dataWithError:(NSError **)error {
    if(!self || [self isKindOfClass:[NSNull class]]) return nil;
    if([self isKindOfClass:[NSString class]]) {
        if(((NSString *)self).length > 0)
            return [(NSString *)self dataUsingEncoding:NSUTF8StringEncoding];
        return nil;
    }
    NSData * data = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:error];
    return data;
}

- (NSData *)dataWithChar:(char *)chars length:(NSUInteger)length {
    // 根据情况而定 移步看 #include "RXCacheC.c" 文件
    if(chars == NULL) return nil;
    if(strlen(chars) == 0) return nil;
    return [NSData dataWithBytes:chars length:length];
}
@end



#pragma mark --- 字典转 JSON
@implementation NSDictionary(RXDicTransform)
- (NSString *)JSON {
    NSData * data = [self data];
    if(data == nil) return nil;
    NSString * json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    json = [json stringByReplacingOccurrencesOfString:@" " withString:@""];
    json = [json stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return json;
}
@end


#pragma mark --- 数组转字符串
@implementation NSArray(RXArrayTransform)
- (NSString *)string {
    if(!self || [self isKindOfClass:[NSNull class]]) return nil;
    if(self.count == 0) return nil;
    return [self componentsJoinedByString:@""];
}
@end
