//
//  RXGradient_LayerColor.h
//  RXExtenstion
//
//  Created by srxboys on 2018/1/30.
//  Copyright © 2018年 https://github.com/srxboys. All rights reserved.
//
//渐变 --- 用 CAGradientLayer

#import <Foundation/Foundation.h>

@interface RXGradient_LayerColor : NSObject
+ (CAGradientLayer *)gradientLayerWithHorizontalStyle;
+ (CAGradientLayer *)gradientLayerWithVerticalStyle;
@end
