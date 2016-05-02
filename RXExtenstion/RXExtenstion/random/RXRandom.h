//
//  RXRandom.h
//  RXExtenstion
//
//  Created by srx on 16/4/29.
//  Copyright © 2016年 srxboys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RXRandom : NSObject
/// 随机日期-最近一个月随机
+ (NSString *)randomDateString;
/// 随机日期---- 几个月随机
+ (NSString *)randomDateStringWithinCount:(NSInteger)count;
/// 随机汉字--100 以内
+ (NSString *)randomChinas;
/// 随机汉字--count 以内
+ (NSString *)randomChinasWithinCount:(NSInteger)count;
/// 字符串 -- 不定长
+ (NSString *)randomString;
/// 随机字母 - 26个
+ (NSString *)randomLetter;
+ (NSString *)randomLetterWithInCount:(NSInteger)count;

/// 随机 给出 图片网址
+ (NSString *) randomImageURL;

/// 随机颜色
+ (UIColor *)randomColor;

/// 返回当前日期时间
+ (double)randomNowDate;

/// 随机倒计时日期时间 (前提是大于当前时间)
+ (NSString *)randomTimeCountdown;
@end
