//
//  RXGradient_Graphics.h
//  RXExtenstion
//
//  Created by srxboys on 2018/1/30.
//  Copyright © 2018年 https://github.com/srxboys. All rights reserved.
//
//渐变 --- 用绘制的

#import <Foundation/Foundation.h>

@interface RXGradient_Graphics : NSObject
+ (UIImage *)imageBgCoreGraphicsWithSize:(CGSize)size;//default  Vertical

+ (UIImage *)imageBgCoreGraphicsHorizontalStyleWithSize:(CGSize)size;
@end
