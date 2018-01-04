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
 */

///字符处理 、数组、 字典 -> 空处理

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

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
