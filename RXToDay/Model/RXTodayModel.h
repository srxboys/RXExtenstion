//
//  RXTodayModel.h
//  RXExtenstion
//
//  Created by srx on 16/7/15.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark ----------- [ 参数通用空处理 ] ---------
@interface NSDictionary (TextNullReplace)
- (id)objectForKeyNotNull:(NSString *)key;
@end

@interface NSCoder(txtNullReplace)
- (id)decodeObjectForKeyNotNull:(NSString *)key;
@end

#pragma mark ----------- [ RXToday ] ---------
@interface RXTodayModel : NSObject<NSCoding>
///商品id
@property (nonatomic, copy) NSString *goods_id;
///sku商品编号
@property (nonatomic, copy) NSString *sku;
///商品标题
@property (nonatomic, copy) NSString *name;
///副标题
@property (nonatomic, copy) NSString *sub_title;
///总评论数
@property (nonatomic, copy) NSString *count_comment;
///原价
@property (nonatomic, copy) NSArray *comment_detail;
///名称
@property (nonatomic, copy) NSString *price;
///价格标签
@property (nonatomic, copy) NSString *market_price;
@property (nonatomic, copy) NSString *image;


+ (instancetype)todayModelWithDictionary:(NSDictionary *)dict;
@end


/*
 NScoder  和 NScoding
 
     NScoding 是一个协议，主要有下面两个方法:
 
    1  -(id)initWithCoder:(NSCoder *)coder;
     //从coder中读取数据，保存到相应的变量中，即反序列化数据
 
    2  -(void)encodeWithCoder:(NSCoder *)coder;
     // 读取实例变量，并把这些数据写到coder中去。序列化数据
 
 
 NSCoder 是一个抽象类，抽象类不能被实例话，只能提供一些想让子类继承的方法。
 
    1 NSKeyedUnarchiver   从二进制流读取对象。
     
    2 NSKeyedArchiver     把对象写到二进制流中去。
 
 */