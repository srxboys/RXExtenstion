//
//  NSArray+RXArrLog.m
//  RXExtenstion
//
//  Created by srx on 16/5/26.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//
//打印信息 汉字可以打印出来


#import "NSArray+RXArrLog.h"

@implementation NSArray (RXArrLog)
- (NSString *)descriptionWithLocale:(id)locale {
    NSMutableString *str = [NSMutableString stringWithFormat:@"%lu (\n", (unsigned long)self.count];
    
    for (id obj in self) {
        [str appendFormat:@"\t%@, \n", obj];
    }
    
    [str appendString:@")"];
    
    return str;
}
@end
