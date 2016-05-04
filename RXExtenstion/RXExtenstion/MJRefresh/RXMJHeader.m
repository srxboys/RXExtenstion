//
//  RXMJHeader.m
//  RXExtenstion
//
//  Created by srx on 16/4/29.
//  Copyright © 2016年 srxboys. All rights reserved.
//
/*
 https://github.com/srxboys
 
 项目基本框架
 */

#import "RXMJHeader.h"

@interface RXMJHeader()
@property (weak, nonatomic)UILabel * label;
@property (weak, nonatomic)UIImageView * loading;
@end

@implementation RXMJHeader
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel * label = [[UILabel alloc] init];
        label.frame = CGRectMake((frame.size.width-30)/2.0, 5, 30, 30);
        label.backgroundColor = [UIColor clearColor];
        label.text = @"RX";
        label.textColor = [UIColor darkGrayColor];
        label.font = [UIFont systemFontOfSize:8];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        _label = label;
        
        UIImageView * logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loading_img"]];
        logo.frame = CGRectMake((frame.size.width-30)/2.0, 5, 30, 30);
        [self addSubview:logo];
        self.loading = logo;
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    _label.frame = CGRectMake((frame.size.width-30)/2.0, 5, 30, 30);
    self.loading.frame = CGRectMake((frame.size.width-30)/2.0, 5, 30, 30);
}

- (void)animationStop {
    [self.loading.layer removeAllAnimations];
}

- (void)animationStart {
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: -(M_PI * 2.0) ];
    rotationAnimation.duration = 1.0;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 99;
    
    [self.loading.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

#pragma mark - ~~~~~~~~~~~ setter ~~~~~~~~~~~~~~~
- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    _label.textColor = textColor;
}
@end
