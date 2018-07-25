//
//  RXGradient_Graphics.m
//  RXExtenstion
//
//  Created by srxboys on 2018/1/30.
//  Copyright © 2018年 https://github.com/srxboys. All rights reserved.
//
//渐变 --- 用绘制的

#import "RXGradient_Graphics.h"

@implementation RXGradient_Graphics
//线性渐变的开始
+ (UIImage *)imageBgCoreGraphicsWithSize:(CGSize)size {
    return [self imageBgCoreGraphicsWithSize:size isHorizontal:NO];
}
+ (UIImage *)imageBgCoreGraphicsHorizontalStyleWithSize:(CGSize)size {
    return [self imageBgCoreGraphicsWithSize:size isHorizontal:YES];
}
+ (UIImage *)imageBgCoreGraphicsWithSize:(CGSize)size isHorizontal:(BOOL)isHorizontal{
    //创建CGContextRef
    UIGraphicsBeginImageContext(size);
    CGContextRef gc = UIGraphicsGetCurrentContext();
    
    //创建CGMutablePathRef
    CGMutablePathRef path = CGPathCreateMutable();
    
    //绘制Path
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, size.width, 0);
    CGPathAddLineToPoint(path, NULL, size.width, size.height);
    CGPathAddLineToPoint(path, NULL, 0, size.height);
    CGPathCloseSubpath(path);
    
    //绘制渐变
//    UIColor * startColor = UIColorHexStr(@"#D01D66");
//    UIColor * endColor = UIColorHexStr(@"#7F1084");
    UIColor * startColor = [UIColor redColor];
    UIColor * endColor = [UIColor yellowColor];
    [self drawLinearGradient:gc path:path startColor:startColor.CGColor endColor:endColor.CGColor isHorizontal:isHorizontal];
    
    //注意释放CGMutablePathRef
    CGPathRelease(path);
    
    //从Context中获取图像，并显示在界面上
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

+ (void)drawLinearGradient:(CGContextRef)context
                      path:(CGPathRef)path
                startColor:(CGColorRef)startColor
                  endColor:(CGColorRef)endColor
                isHorizontal:(BOOL)isHorizontal
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGFloat locations[] = { 0.0, 1.0 }; //Vertical
    if(isHorizontal) {
        locations[0] = 1.0f;
        locations[1] = 0.0f;
    }
    
    NSArray *colors = @[(__bridge id) startColor, (__bridge id) endColor];
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
    
    
    CGRect pathRect = CGPathGetBoundingBox(path);
    
    //具体方向可根据需求修改 (可以变成你想要的形状)
    CGPoint startPoint = CGPointMake(CGRectGetMidX(pathRect), CGRectGetMinY(pathRect));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(pathRect), CGRectGetMaxY(pathRect));
    if(isHorizontal) {
        startPoint = CGPointMake(0, 0);
        endPoint = CGPointMake(CGRectGetMaxX(pathRect), CGRectGetMaxY(pathRect));
    }
    
    
    CGContextSaveGState(context);
    CGContextAddPath(context, path);
    CGContextClip(context);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGContextRestoreGState(context);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}
@end
