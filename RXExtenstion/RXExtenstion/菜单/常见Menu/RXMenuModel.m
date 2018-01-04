//
//  RXMenuModel.m
//  RXExtenstion
//
//  Created by srx on 16/9/5.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import "RXMenuModel.h"
#import "RXCharacter.h"

@implementation NSDictionary (RXNullReplace)

- (id)objectForKeyNotNull:(NSString *)key
{
    if (![[self allKeys] containsObject:key]) return nil;
    
    id object = [self objectForKey:key];
    if (([object isKindOfClass:[NSString class]] && (![object isEqualToString:@"<null>"])) ||
        [object isKindOfClass:[NSArray class]] ||
        [object isKindOfClass:[NSDictionary class]])  {
        
        return object;
    }
    else if([object isKindOfClass:[NSNumber class]]) {
        NSNumberFormatter * numberFormatter = [[NSNumberFormatter alloc] init];
        return [numberFormatter stringFromNumber:object];
    }
    return nil;
}
@end


@implementation RXSeckillMenuMode
- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if(self) {
        self.starttime = [[dict objectForKeyNotNull:@"starttime"] longLongValue];
        self.endtime = [[dict objectForKeyNotNull:@"endtime"] longLongValue];
        self.uid = [[dict objectForKeyNotNull:@"uid"] integerValue];
        self.scrollOffsetY = 0;
    }
    return self;
}

+ (instancetype)seckillMenuWithDict:(NSDictionary *)dict {
    return [[RXSeckillMenuMode alloc] initWithDict:dict];
}
@end

@implementation RXSeckillListModel
- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if(self) {
        self.name = [dict objectForKeyNotNull:@"name"];
        self.image = [dict objectForKeyNotNull:@"image"];
        self.sku = [dict objectForKeyNotNull:@"sku"];
        self.price = StrFormatValue([dict objectForKeyNotNull:@"price"]);
        self.store = [[dict objectForKeyNotNull:@"store"] boolValue];
    }
    return self;
}

+ (instancetype)seckillListWithDict:(NSDictionary *)dict {
    return [[RXSeckillListModel alloc] initWithDict:dict];
}
@end
