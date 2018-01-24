//
//  RXCharacter.h
//  RXExtenstion
//
//  Created by srx on 16/4/29.
//  Copyright © 2016年 srxboys. All rights reserved.
//
/*
    https://github.com/srxboys
    
    项目基本框架
 
 
    demo 请查看  RXCaCheController.m
 */

///字符处理 、数组、 字典 -> 空处理

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 对请求参数做处理
NSString* NonEmptyString(id obj);

/// 判断字符串是否为空
BOOL StrBool(id obj);


/// 去掉字符串中前后空格
NSString * StrFormatWhiteSpace(id obj);

/// 把字符串 变成 金钱字符串 0.00样式
NSString * StrFormatValue(id obj);


/// 是否是数组
BOOL ArrBool(id obj);

/// 返回【判断后的数组】-- 如果是字典以数组形式返回
NSArray * ArrValue(id obj);


/// 是否是 字典
BOOL DictBool(id obj);


/// 判断字符串是否 为 Url
BOOL UrlBool(id obj);




@interface RXCharacter : NSObject
/*
    多个任意类型的数据拼接成 字符串 ,以nil为结束对象。
 
     不允许出现 YES/NO/ TRUE/FALSE  yes/no  true/false 
*/
+ (NSString *)stringTranWithObject:(id)object, ... NS_REQUIRES_NIL_TERMINATION;
@end


NS_ASSUME_NONNULL_END
