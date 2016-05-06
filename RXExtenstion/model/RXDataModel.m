//
//  RXDataModel.m
//  RXExtenstion
//
//  Created by srx on 16/5/6.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

// 所有的模型，都放到这里

#import "RXDataModel.h"

@implementation NSDictionary (TextNullReplace)

- (id)objectForKeyNotNull:(NSString *)key
{
    id object = [self objectForKey:key];
    if ([object isKindOfClass:[NSString class]] ||
        [object isKindOfClass:[NSArray class]] ||
        [object isKindOfClass:[NSDictionary class]])  {
        
        return object;
    }
    else if([object isKindOfClass:[NSNumber class]]) {
        /*
         * 所有 的 NSNumber 都为字符串
         * 保证了 服务器传回来的数据 不会导致app崩溃
         *
         * 
         */
        
        NSNumberFormatter * numberFormatter = [[NSNumberFormatter alloc] init];
        return [numberFormatter stringFromNumber:object];
    }
    return nil;
}

@end

#pragma mark ----------- [ RXUser ] ---------
@implementation RXUser
- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if(self) {
        self.user_id = [[dict objectForKeyNotNull:@"user_id"] longLongValue];
        self.user_avater = [dict objectForKeyNotNull:@"user_avater"];
    }
    return self;
}

+ (RXUser *)userWithDict:(NSDictionary *)dict {
    return [[RXUser alloc] initWithDict:dict];
}
@end








