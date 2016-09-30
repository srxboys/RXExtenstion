//
//  RXRandom.m
//  RXExtenstion
//
//  Created by srx on 16/4/29.
//  Copyright © 2016年 srxboys. All rights reserved.
//

#import "RXRandom.h"

@implementation RXRandom
//随机时间
+ (NSString *)randomDateString{
    //随机 一个月
    return [self randomDateStringWithinCount:1];
}
//随机日期---- 几个月随机
+ (NSString *)randomDateStringWithinCount:(NSInteger)count {
    
    count = count ? count : 1;
    
    double timeStamp = ceil([[NSDate date] timeIntervalSince1970]);
    // （60 * 24表示一天   * 30表示 一个月随机，【表示秒】）  * 60变成总时间【表示小时】
    double timeStamp2 = timeStamp - ((60 * 24) * (arc4random() % (count * 30)) * 60);
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setGeneratesDecimalNumbers:false];
    NSNumber *timeNumber = [NSNumber numberWithDouble:timeStamp2];
    NSString *timeString = [formatter stringFromNumber:timeNumber];
    // NSTimeInterval is defined as double
    //    return [NSNumber numberWithLongLong:[timeString longLongValue]];
    return timeString;
}


/*
 以下，都是百度搜索结果
 */


//随机生成汉字
///随机汉字--100以内
+ (NSString *)randomChinasWithinCount:(NSInteger)count {
    count = count ? count : 1;
    NSStringEncoding gbkEncoding =
    CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    
    NSMutableData * dataStr = [[NSMutableData alloc] init];
    //随机100以内的汉字
    for (NSInteger i = 0; i < arc4random() % count + count/2 + 1; i++) {
        NSInteger randomH = 0xA1 + arc4random() % (0xFE - 0xA1 + 1);
        
        NSInteger randomL = 0xB0 + arc4random() % (0xF7 - 0xB0 + 1);
        
        NSInteger number = (randomH << 8) + randomL;
        [dataStr appendBytes:&number length:2];
    }
    
    
    NSString* string = [[NSString alloc] initWithData:dataStr encoding:gbkEncoding];
    
    return string;
    
}

+ (NSString *)randomChinas {
    // http://blog.sina.com.cn/s/blog_916e0cff0102vh7j.html
    return [self randomChinasWithinCount:100];
}

//随机生成字符串
+ (NSString*)randomString {
    NSString* string = [[NSString alloc] init];
    //                                      + 1 确保有数据
    for (int i = 0; i < arc4random() % 100 + 5; i++) {
        int number = arc4random() % 36;
        
        if (number < 10) {
            int figure = arc4random() % 10;
            
            NSString* tempString = [NSString stringWithFormat:@"%d", figure];
            
            string = [string stringByAppendingString:tempString];
            
        } else {
            int figure = (arc4random() % 26) + 97;
            
            char character = figure;
            
            NSString* tempString = [NSString stringWithFormat:@"%c", character];
            
            string = [string stringByAppendingString:tempString];
        }
    }
    
    return string;
}



//随机字母 -- 26位的字符串

+ (NSString *)randomLetter {
    return [self randomLetterWithInCount:26];
}

+ (NSString *)randomLetterWithInCount:(NSInteger)count {
    count = count ? count : 1;
    
    NSMutableArray * shuffledAlphabet = [NSMutableArray arrayWithArray:@[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"]];
    NSMutableArray * resultArr = [[NSMutableArray alloc] init];
    for (NSUInteger i = 0; i < count; ++i) {
        // Select a random element between i and end of array to swap with.
        
        NSInteger index = arc4random() % shuffledAlphabet.count;
        
        [resultArr addObject:shuffledAlphabet[index]];
    }
    
    NSString* string = [[NSString alloc] init];
    
    for (NSString* letter in resultArr) {
        string = [NSString stringWithFormat:@"%@%@", string, letter];
    }
    
    return string;
}

//随机 给出 图片网址
+ (NSString *) randomImageURL {    
    NSString * string = @"https://raw.githubusercontent.com/srxboys/RXExtenstion/master/RXExtenstion/images";
    NSInteger randomInt = arc4random() % 6;
    NSString * imageUrl = [NSString stringWithFormat:@"%@/psb_%zd.jpeg", string,randomInt];
    
    return imageUrl;
}

//随机颜色
+ (UIColor *)randomColor {
    CGFloat r = arc4random() % 256;
    CGFloat g = arc4random() % 256;
    CGFloat b = arc4random() % 256;
    return [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0f];
    
    ////转换网址 http://www.atool.org/colorpicker.php //用于UI给出颜色
}

/// 返回当前日期时间
+ (double)randomNowDate {
    double timeNow = ceil([[NSDate date] timeIntervalSince1970]);
    return timeNow;
}


/// 随机倒计时时间
+ (NSString *)randomTimeCountdown {
    double timeStamp = ceil([[NSDate date] timeIntervalSince1970]);
    // （60 * 24表示一天   * 30表示 一个月随机，【表示秒】）  * 60变成总时间【表示小时】
    double timeStamp2 = timeStamp + ((arc4random()% 60 + 1) * 24);
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setGeneratesDecimalNumbers:false];
    NSNumber *timeNumber = [NSNumber numberWithDouble:timeStamp2];
    NSString *timeString = [formatter stringFromNumber:timeNumber];
    // NSTimeInterval is defined as double
    //    return [NSNumber numberWithLongLong:[timeString longLongValue]];
    return timeString;
}
@end
