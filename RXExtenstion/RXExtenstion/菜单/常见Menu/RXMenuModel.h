//
//  RXMenuModel.h
//  RXExtenstion
//
//  Created by srx on 16/9/5.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (RXNullReplace)

- (id)objectForKeyNotNull:(NSString *)key;

@end

@interface RXSeckillMenuMode : NSObject
@property (nonatomic, assign) long long starttime;
@property (nonatomic, assign) long long endtime;
@property (nonatomic, assign) NSInteger  uid;
@property (nonatomic, assign) BOOL isReload;
@property (nonatomic, assign) CGFloat  scrollOffsetY;
+ (instancetype)seckillMenuWithDict:(NSDictionary *)dict;
@end

@interface RXSeckillListModel : NSObject
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * image;
@property (nonatomic, copy) NSString * sku;
@property (nonatomic, copy) NSString * price;//价格
@property (nonatomic, assign) BOOL     store;//是否有库存
+ (instancetype)seckillListWithDict:(NSDictionary *)dict;
@end