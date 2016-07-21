//
//  NSDictionary+NSStringUTF8.m
//  RXSession
//
//  Created by srx on 16/7/19.
//  Copyright © 2016年 srxboys. All rights reserved.
//

#import "NSDictionary+NSStringUTF8.h"

#pragma mark - ~~~~~~~~~~~ 参数 转 字符串并utf-8 ~~~~~~~~~~~~~~~
@implementation NSDictionary (NSStringUTF8)
- (NSData *)toNSStringUTF8Data {
    
    NSDictionary * dictParams = self;
    
    if(dictParams == nil || dictParams.allKeys <= 0) {
        return nil;
    }
    
    NSMutableString * string = [[NSMutableString alloc] init];
    for (NSString * key in dictParams.allKeys) {
        [string appendString:[NSString stringWithFormat:@"%@=%@&", key, dictParams[key]]];
    }
    
    [string setString:[string substringToIndex:string.length - 1]];
    NSLog(@"参数=%@", string);
    return [string dataUsingEncoding:NSUTF8StringEncoding];
}
@end
