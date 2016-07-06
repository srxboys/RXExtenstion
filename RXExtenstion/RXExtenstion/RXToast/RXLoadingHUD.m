//
//  RXLoadingHUD.m
//  RXExtenstion
//
//  Created by srx on 16/7/6.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import "RXLoadingHUD.h"

#define kShowHideAnimateDuration 0.2

@implementation RXLoadingHUD {
    CGFloat        hudHeight;
    NSMutableArray *hudRects;
}

- (CGFloat)getViewhud_WH:(CGFloat)hud_wh hud_space:(CGFloat)hub_space  {
    hudHeight = self.frame.size.height;
    _hud_widthHeight = hud_wh;
    _hud_space = hub_space;
    return hub_space * 2 + hud_wh;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //默认大小
        _hudView_width = [self getViewhud_WH:_default_hud_widthHeigth  hud_space:_default_hud_space];
        
        [self configUI];
        self.userInteractionEnabled = NO;
        self.alpha = 0;
    }
    return self;
}

- (instancetype)initCustomWithFrame:(CGRect)frame hud_WH:(CGFloat)hud_wh hud_space:(CGFloat)hub_space {
    self = [super initWithFrame:frame];
    if(self) {
        _hudView_width = [self getViewhud_WH:hud_wh hud_space:hub_space];
        [self configUI];
        self.userInteractionEnabled = NO;
        self.alpha = 0;
        
    }
    return self;
}

#pragma mark - config UI

- (void)configUI {
    self.backgroundColor = [UIColor clearColor];
    
    CGFloat left = 0;
    CGFloat width = self.frame.size.width;
    
    CGFloat hud_width = _hud_space * 2 + _hud_widthHeight;
    
    if(width > hud_width) {
        left =(width - hud_width)/2.0;
    }
    
    UIView *rect1 = [self drawRectAtPosition:CGPointMake(left+0, 0)];
    UIView *rect2 = [self drawRectAtPosition:CGPointMake(left+_hud_space, 0)];
    UIView *rect3 = [self drawRectAtPosition:CGPointMake(left+_hud_space * 2, 0)];
    
    [self addSubview:rect1];
    [self addSubview:rect2];
    [self addSubview:rect3];
    
    [self doAnimateCycleWithRects:@[rect1, rect2, rect3]];
}

#pragma mark - animation

- (void)doAnimateCycleWithRects:(NSArray *)rects {
    __weak typeof(self) wSelf = self;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (0.25 * 0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [wSelf animateRect:rects[0] withDuration:0.25];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (0.25 * 0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [wSelf animateRect:rects[1] withDuration:0.25];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (0.25 * 0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [wSelf animateRect:rects[2] withDuration:0.25];
            });
        });
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (0.75 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [wSelf doAnimateCycleWithRects:rects];
    });
}

- (void)animateRect:(UIView *)rect withDuration:(NSTimeInterval)duration {
    [rect setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    
    [UIView animateWithDuration:duration
                     animations:^{
                         rect.alpha = 1;
                         rect.transform = CGAffineTransformMakeScale(1.3, 1.3);
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:duration
                                          animations:^{
                                              rect.alpha = 0.5;
                                              rect.transform = CGAffineTransformMakeScale(1, 1);
                                          } completion:^(BOOL f) {
                                          }];
                     }];
}

#pragma mark - drawing

- (UIView *)drawRectAtPosition:(CGPoint)positionPoint {
    UIView *rect = [[UIView alloc] init];
    CGRect rectFrame;
    rectFrame.size.width = _hud_widthHeight;
    rectFrame.size.height = _hud_widthHeight;
    rectFrame.origin.x = positionPoint.x;
    rectFrame.origin.y = (hudHeight - _hud_widthHeight)/2.0;;
    rect.frame = rectFrame;
    rect.backgroundColor = [UIColor whiteColor];
    rect.alpha = 0.5;
    rect.layer.cornerRadius = _hud_widthHeight / 2.0;
    
    if (hudRects == nil) {
        hudRects = [[NSMutableArray alloc] init];
    }
    [hudRects addObject:rect];
    
    return rect;
}

#pragma mark - Setters

- (void)setHudColor:(UIColor *)hudColor {
    for (UIView *rect in hudRects) {
        rect.backgroundColor = hudColor;
    }
}

#pragma mark -
#pragma mark - show / hide

- (void)hide {
    [UIView animateWithDuration:kShowHideAnimateDuration animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        //        [self removeFromSuperview];
    }];
}

- (void)showAnimated:(BOOL)animated {
    if (animated) {
        //渐变成
        [UIView animateWithDuration:kShowHideAnimateDuration animations:^{
            self.alpha = 1;
        }];
    } else {
        //不渐变
        self.alpha = 1;
    }
}

- (void)dealloc {
    hudRects = nil;
}

@end