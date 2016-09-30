//
//  RXSearchButtonWidthModel.m
//  RXExtenstion
//
//  Created by srx on 16/9/30.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import "RXSearchButtonWidthModel.h"
#import <UIKit/UIKit.h>

@implementation RXSearchButtonWidthModel
- (void)setTitle:(NSString *)title {
    _title = title;
    UILabel * label = [[UILabel alloc] init];
    label.text = title;
    label.font = [UIFont systemFontOfSize:14];
    CGRect frame = CGRectMake(0, 0, CGFLOAT_MAX, 15);
    label.frame = frame;
    _width = [label textRectForBounds:frame limitedToNumberOfLines:1].size.width + 50;
}
@end
