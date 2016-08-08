//
//  RXJDButton.m
//  RXExtenstion
//
//  Created by srx on 16/8/8.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import "RXJDButton.h"

@implementation RXJDButton


- (CGFloat)width {
    return _width;
}

- (CGFloat)left {
    return _left;
}


- (void)setAddressName:(NSString *)addressName {
    _addressName = addressName;
    [self setTitle:addressName forState:UIControlStateNormal];

    self.titleLabel.font = [UIFont systemFontOfSize:14];
    [self setTitleColor:UIColorHexStr(@"333333") forState:UIControlStateNormal];
    
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.backgroundColor = [UIColor clearColor];
    
    CGRect rect = self.frame;
    _left = rect.origin.x;

    [self sizeToFit];
    _width = self.bounds.size.width;
    self.frame = CGRectMake(rect.origin.x, rect.origin.y, _width, rect.size.height);
    
}

@end
