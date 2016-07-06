//
//  UIView+RXToast.h
//  RXExtenstion
//
//  Created by srx on 16/7/6.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (RXToast)

+ (void)showToast:(NSString *)message;
+ (void)hiddenToast;

+ (void)showLoading;
+ (void)hiddenLoading;
@end
