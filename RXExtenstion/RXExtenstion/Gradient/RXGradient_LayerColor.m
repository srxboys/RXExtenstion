//
//  RXGradient_LayerColor.m
//  RXExtenstion
//
//  Created by srxboys on 2018/1/30.
//  Copyright © 2018年 https://github.com/srxboys. All rights reserved.
//

#import "RXGradient_LayerColor.h"

@implementation RXGradient_LayerColor
+ (CAGradientLayer *)gradientLayerWithHorizontalStyle {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    gradientLayer.locations = @[@0,@1];
    return gradientLayer;
}


+ (CAGradientLayer *)gradientLayerWithVerticalStyle {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    gradientLayer.locations = @[@0,@1];
    return gradientLayer;
}
@end
