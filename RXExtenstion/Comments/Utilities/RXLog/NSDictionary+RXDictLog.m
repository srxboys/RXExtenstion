//
//  NSDictionary+RXDictLog.m
//  RXExtenstion
//
//  Created by srx on 16/5/26.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//
//打印信息 汉字可以打印出来

#import "NSDictionary+RXDictLog.h"

@implementation NSDictionary (RXDictLog)
-(NSString *)descriptionWithLocale:(id)locale {
    NSArray *allKeys = [self allKeys];
    NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"{\t\n "];
    for (id key in allKeys) {
        id value= self[key];
        id valueType = [self pringIdTypeString:value];
        [str appendFormat:@"\t %@ = %@,\n",[self pringIdTypeString:key], valueType];
    }
    [str appendString:@"}"];
    
    return str;
}

//判断是否为 1、字符串类型 ""  2、数值类型
- (NSString *)pringIdTypeString:(id)string {
    if([string isKindOfClass:[NSNumber class]]) {
        return string;
    }
    else if([string isKindOfClass:[NSString class]]) {
        return [NSString stringWithFormat:@"\"%@\"", string];
    }
    return string;
}

@end
