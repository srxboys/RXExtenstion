//
//  RXLoadingHUD.h
//  RXExtenstion
//
//  Created by srx on 16/7/6.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/*
 三点 动画
 
 */

const CGFloat _default_hud_widthHeigth = 8;
const CGFloat _default_hud_space = 20;
const CGFloat _default_hudView_width = _default_hud_space * 2 + _default_hud_widthHeigth;


@interface RXLoadingHUD : UIView

@property (nonatomic, strong) UIColor *hudColor;


/** 每个 圆点的大小 默认为=8*/
@property (nonatomic, assign,readonly) CGFloat hud_widthHeight;
/** 每个 圆点的间距(_hud_widthHeight 大小包括在内) 默认=20 */
@property (nonatomic, assign,readonly) CGFloat hud_space;
/** 该动画的宽度 默认=【_hud_space * 2 + _hud_widthHeight】 */
@property (nonatomic, assign, readonly) CGFloat hudView_width;

/** 默认圆圆的大小*/
- (instancetype)initWithFrame:(CGRect)frame;

/** 自定义圆圆的大小*/
- (instancetype)initCustomWithFrame:(CGRect)frame hud_WH:(CGFloat)hud_wh hud_space:(CGFloat)hub_space;

-(void)showAnimated:(BOOL)animated;
-(void)hide;

@end