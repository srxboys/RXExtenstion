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
        self.talent_id     = [dict objectForKeyNotNull:@"talent_id"    ];
        self.coup_id       = [dict objectForKeyNotNull:@"coup_id"      ];
        self.talent_image  = [dict objectForKeyNotNull:@"talent_image" ];
        self.image         = [dict objectForKeyNotNull:@"image"        ];
        self.time          = [dict objectForKeyNotNull:@"time"         ];
        self.comment_count = [dict objectForKeyNotNull:@"comment_count"];
        self.view_count    = [dict objectForKeyNotNull:@"view_count"   ];

    }
    return self;
}

+ (instancetype)todayModelWithDictionary:(NSDictionary *)dict {
    return [[RXTodayModel alloc] initWithDict:dict];
}

/// 从coder中读取数据，保存到相应的变量中，即反序列化数据
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super init]) {
        self.talent_id     = [aDecoder decodeObjectForKeyNotNull:@"talent_id"    ];
        self.coup_id       = [aDecoder decodeObjectForKeyNotNull:@"coup_id"      ];
        self.talent_image  = [aDecoder decodeObjectForKeyNotNull:@"talent_image" ];
        self.image         = [aDecoder decodeObjectForKeyNotNull:@"image"        ];
        self.time          = [aDecoder decodeObjectForKeyNotNull:@"time"         ];
        self.comment_count = [aDecoder decodeObjectForKeyNotNull:@"comment_count"];
        self.view_count    = [aDecoder decodeObjectForKeyNotNull:@"view_count"   ];
    }
    return self;
}

/// 读取实例变量，并把这些数据写到coder中去。序列化
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_talent_image  forKey:@"talent_id"    ];
    [aCoder encodeObject:_coup_id       forKey:@"coup_id"      ];
    [aCoder encodeObject:_talent_image  forKey:@"talent_image" ];
    [aCoder encodeObject:_image         forKey:@"image"        ];
    [aCoder encodeObject:_time          forKey:@"time"         ];
    [aCoder encodeObject:_comment_count forKey:@"comment_count"];
    [aCoder encodeObject:_view_count    forKey:@"view_count"   ];
}
@end
