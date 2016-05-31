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
    NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"%lu {\t\n ", allKeys.count];
     for (NSString *key in allKeys) {
             id value= self[key];
             [str appendFormat:@"\t \"%@\" = %@,\n",key, value];
         }
     [str appendString:@"}"];

    return str;
}
@end
