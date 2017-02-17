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
    //如果没有key 就返回nil//防止崩溃
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

#pragma mark ----------- [ RXUser ] ---------
@implementation RXUser
- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if(self) {
        self.user_id      = [dict objectForKeyNotNull:@"user_id"     ];
        self.user_avater  = [dict objectForKeyNotNull:@"user_avater" ];
        self.user_backImg = [dict objectForKeyNotNull:@"user_backImg"];
        self.user_desc    = [dict objectForKeyNotNull:@"user_desc"   ];
    }
    return self;
}

+ (RXUser *)userWithDict:(NSDictionary *)dict {
    return [[RXUser alloc] initWithDict:dict];
}
@end

#pragma mark ----------- [ 轮播图、焦点图 ] ---------
@implementation RXFouceModel
- (RXFouceModel *)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if(self) {
        self.fouce_id = [dict objectForKeyNotNull:@"fouce_id"];
        self.type     = [dict objectForKeyNotNull:@"type"    ];
        self.title    = [dict objectForKeyNotNull:@"title"   ];
        self.image    = [dict objectForKeyNotNull:@"image"   ];
    }
    return self;
}

+ (RXFouceModel *)fouceModelWithDict:(NSDictionary *)dict {
    return [[RXFouceModel alloc] initWithDict:dict];
}
@end

#pragma mark ----------- [ 我的 ] ---------
@implementation RXMineModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    if(self = [super init]) {
        self.title  = [dict objectForKeyNotNull:@"title"];
        self.webUrl = [dict objectForKeyNotNull:@"webUrl"];
        self.image  = [dict objectForKeyNotNull:@"image"];
    }
    return self;
}

+ (RXMineModel *)mineModelWithDict:(NSDictionary *)dict {
    return [[RXMineModel alloc] initWithDict:dict];
}

@end


#pragma mark ----------- [ 展开和收缩 ] ---------
@implementation RXExpansionContractionModel
- (instancetype)initWithDict:(NSDictionary *)dict {
    if(self = [super init]) {
        self.title = [dict objectForKeyNotNull:@"title"];
        self.text  = [dict objectForKeyNotNull:@"text"];
    }
    return self;
}

+ (RXExpansionContractionModel *)mineModelWithDict:(NSDictionary *)dict {
    return [[RXExpansionContractionModel alloc] initWithDict:dict];
}
@end


@implementation RXMenuCitydistanceModel

@end


@implementation RXMenuCityModel

@end


@implementation RXMenuTypeModel

@end


#pragma mark ----------- [ 1个xib里多个cell ] ---------
@implementation RXXibModel
- (void)setContent:(RXXibModel *)content {
    _content = content;
    self.object = content.object;
    self.selecter = content.selecter;
    self.modelTag = content.modelTag;
    self.cellIditifier = content.cellIditifier;
    self.modelSection = content.modelSection;
    
    self.cellHeight = content.cellHeight;
    
}
@end

@implementation OneXibModel
@end

@implementation TwoXibModel
@end



