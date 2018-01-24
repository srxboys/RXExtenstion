//
//  RXTransform.h
//  RXExtenstion
//
//  Created by srxboys on 2018/1/18.
//  Copyright © 2018年 https://github.com/srxboys. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 对象转 NSData
@interface NSObject(RXObjectTransform)
- (NSData *)data;
- (NSData *)dataWithError:(NSError **)error;

- (NSData *)dataWithChar:(char *)chars length:(NSUInteger)length;
@end


/// 字典转 JSON
@interface NSDictionary(RXDicTransform)
- (NSString *)JSON;
@end

/// 数组转字符串
@interface NSArray(RXArrayTransform)
- (NSString *)string;
@end


