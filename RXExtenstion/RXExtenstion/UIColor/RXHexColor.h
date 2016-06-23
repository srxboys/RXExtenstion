//
//  RXHexColor.h
//  RXExtenstion
//
//  Created by srx on 16/4/29.
//  Copyright © 2016年 srxboys. All rights reserved.
//
//十六进制颜色 转 color
#import <UIKit/UIKit.h>

@interface RXHexColor : UIColor
//RGB color 转换
+ (UIColor *) colorWithRGB:(CGFloat)r G:(CGFloat)g B:(CGFloat)b;

///16进制颜色必须长度为6
+ (UIColor *) colorWithHexString: (NSString *)color;
///16进制颜色必须长度为6
+ (UIColor *) colorWithHexString: (NSString *)color alpha:(float)opacity;

/// 把颜色转换成图片
+ (UIImage *) colorBecomeImage:(UIColor *)color;
@end
