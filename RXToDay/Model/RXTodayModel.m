//
//  RXTodayModel.m
//  RXExtenstion
//
//  Created by srx on 16/7/15.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import "RXTodayModel.h"

#pragma mark ----------- [ 参数通用空处理 ] ---------
@implementation NSDictionary (TextNullReplace)

- (id)objectForKeyNotNull:(NSString *)key
{
    if (![[self allKeys] containsObject:key]) return nil;
    
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
         */
        
        NSNumberFormatter * numberFormatter = [[NSNumberFormatter alloc] init];
        return [numberFormatter stringFromNumber:object];
    }
    return nil;
}
@end

@implementation NSCoder (txtNullReplace)
- (id)decodeObjectForKeyNotNull:(NSString *)key {
    
    if (![self containsValueForKey:key]) return nil;
    
    id object = [self decodeObjectForKey:key];
    if ([object isKindOfClass:[NSString class]] ||
        [object isKindOfClass:[NSArray class]] ||
        [object isKindOfClass:[NSDictionary class]])  {
        
        return object;
    }
    else if([object isKindOfClass:[NSNumber class]]) {
        /*
         * 所有 的 NSNumber 都为字符串
         * 保证了 服务器传回来的数据 不会导致app崩溃
         */
        
        NSNumberFormatter * numberFormatter = [[NSNumberFormatter alloc] init];
        return [numberFormatter stringFromNumber:object];
    }
    return nil;
}
@end

#pragma mark ----------- [ RXToday ] ---------
@implementation RXTodayModel
- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        //写这个，会自动到 initWithCoder 方法里去
        self.goods_id = [dict objectForKeyNotNull:@"goods_id"];
        self.sku = [dict objectForKeyNotNull:@"sku"];
        self.name = [dict objectForKeyNotNull:@"name"];
        self.sub_title = [dict objectForKeyNotNull:@"sub_title"];
        self.count_comment = [dict objectForKeyNotNull:@"count_comment"];
        self.comment_detail = [dict objectForKeyNotNull:@"comment_detail"];
        self.price = [dict objectForKeyNotNull:@"price"];
        self.market_price = [dict objectForKeyNotNull:@"market_price"];
        self.image = [dict objectForKeyNotNull:@"image"];

    }
    return self;
}

+ (instancetype)todayModelWithDictionary:(NSDictionary *)dict {
    return [[RXTodayModel alloc] initWithDict:dict];
}

/// 从coder中读取数据，保存到相应的变量中，即反序列化数据
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super init]) {
        self.goods_id = [aDecoder decodeObjectForKeyNotNull:@"goods_id"];
        self.sku = [aDecoder decodeObjectForKeyNotNull:@"sku"];
        self.name = [aDecoder decodeObjectForKeyNotNull:@"name"];
        self.sub_title = [aDecoder decodeObjectForKeyNotNull:@"sub_title"];
        self.image = [aDecoder decodeObjectForKeyNotNull:@"image"];
        self.count_comment = [aDecoder decodeObjectForKeyNotNull:@"count_comment"         ];
        self.comment_detail = [aDecoder decodeObjectForKeyNotNull:@"comment_detail"];
        self.price = [aDecoder decodeObjectForKeyNotNull:@"price"];
    }
    return self;
}

/// 读取实例变量，并把这些数据写到coder中去。序列化
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_goods_id forKey:@"goods_id"];
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeObject:_sku forKey:@"sku"];
    [aCoder encodeObject:_sub_title forKey:@"sub_title"];
    [aCoder encodeObject:_image forKey:@"image"];
    [aCoder encodeObject:_count_comment forKey:@"count_comment"];
    [aCoder encodeObject:_comment_detail forKey:@"comment_detail"];
    [aCoder encodeObject:_price forKey:@"price"   ];
}
@end
