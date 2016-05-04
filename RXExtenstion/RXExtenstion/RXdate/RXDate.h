//
//  RXDate.h
//  RXExtenstion
//
//  Created by srx on 16/5/3.
//  Copyright © 2016年 srxboys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RXDate : NSObject
///时间戳 和 今天比较 【开始 >= 今天  <= 结束】(参数字符串)
+ (NSString *)dateCompareOneDay:(NSString *)start endTime:(NSString *)end;
@end
