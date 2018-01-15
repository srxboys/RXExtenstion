//
//  NSError+RXString.m
//  RXSession
//
//  Created by srx on 16/7/20.
//  Copyright © 2016年 srxboys. All rights reserved.
//

#import "NSError+RXString.h"

static NSString * const RXERRORDOMAIN = @"RXExtenstion";

//设计的有问题，code碼 应该根据情况而定的，哎！

@implementation NSError (RXString)
+ (NSError *)errorObjec:(id)object Desc:(NSString *)desc {
    NSString * tempDesc = desc.length > 0 ? desc : @"error";
    
    NSError * error = [[NSError alloc] initWithDomain:RXERRORDOMAIN code:0 userInfo:@{@"错误为":tempDesc}];
    return error;
}

+ (NSError *)errorObjec:(id)object infoDictionary:(NSDictionary *)dict {
    
    NSDictionary * userInfo = dict.allKeys > 0 && dict != nil ? dict : @{@"有错误":@""};
    
    NSError * error = [[NSError alloc] initWithDomain:RXERRORDOMAIN code:0 userInfo:userInfo];
    return error;
}
@end
