//
//  RXMineDIYItemView.m
//  RXExtenstion
//
//  Created by srxboys on 2018/2/7.
//  Copyright © 2018年 https://github.com/srxboys. All rights reserved.
//

#import "RXMineDIYItemView.h"

@implementation RXMineDIYItem
@end

@implementation RXMineDIYItemView

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width = ViewWidth(self);
    CGFloat space = 10;
    CGFloat padding = 15;
    CGFloat halfWifth = (width-space-padding*2)/2.0;
    _titleLabel.frame = CGRectMake(padding, 0, halfWifth, RXMineDIYItemView_height);
    
    if(StrBool(_value)) {
        CGFloat ratio = StrBool(_subValue)?2.0:1.0;
        _valueLabel.frame = CGRectMake(padding+halfWifth, 0, halfWifth, RXMineDIYItemView_height/ratio);
        
        if(StrBool(_subValue)) {
            _subValueLabel.frame = CGRectMake(padding+halfWifth, RXMineDIYItemView_height/ratio, halfWifth, RXMineDIYItemView_height/ratio);
        }
    }
    else if(StrBool(_subValue)) {
        _subValueLabel.frame = CGRectMake(padding+halfWifth, 0, halfWifth, RXMineDIYItemView_height);
    }
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self configUI];
    }
    return self;
}

void removeAlloc(UIView * view) {
    if(!view) return;
    [view removeFromSuperview];
    view = nil;
}

- (void)configUI {
    self.backgroundColor = [UIColor clearColor];
    removeAlloc(_titleLabel);
    removeAlloc(_valueLabel);
    removeAlloc(_subValueLabel);
    
    _titleLabel = [self configLeftLabel];
    _valueLabel = [self configRightLabel];
    _subValueLabel = [self configRightLabel];
}



- (UILabel *)configLabel {
    UILabel * label = [UILabel new];
    label.backgroundColor = [UIColor clearColor];
    label.font = FontBase(14);
    [self addSubview:label];
    return label;
}

- (UILabel *)configLeftLabel {
    UILabel * label = [self configLabel];
    label.textAlignment = NSTextAlignmentLeft;
    return label;
}

- (UILabel *)configRightLabel {
    UILabel * label = [self configLabel];
    label.font = FontBase(12);
    label.textAlignment = NSTextAlignmentRight;
    label.textColor = [UIColor lightGrayColor];
    return label;
}

- (void)setKey:(NSString *)key {
    _key = key;
    _titleLabel.text = key;
}

- (void)setValue:(NSString *)value {
    _value = value;
    _valueLabel.text = value;
}

- (void)setSubValue:(NSString *)subValue {
    _subValue = subValue;
    _subValueLabel.text = subValue;
}

- (void)setValueColor:(UIColor *)valueColor {
    _valueColor = valueColor;
    _valueLabel.textColor = valueColor;
}


- (void)setSubValueColor:(UIColor *)subValueColor {
    _subValueColor = subValueColor;
    _subValueLabel.textColor = subValueColor;
}
@end
