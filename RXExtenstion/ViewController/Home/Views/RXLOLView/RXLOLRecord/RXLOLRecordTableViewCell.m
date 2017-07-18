//
//  RXLOLRecordCollectionViewCell.m
//  RXExtenstion
//
//  Created by srx on 2017/7/18.
//  Copyright © 2017年 https://github.com/srxboys. All rights reserved.
//
// LOL 战绩

NSString * const RXLOLRecordCellIdentifier = @"RXLOLRecordCollectionViewCell";

#import "RXLOLRecordTableViewCell.h"

@interface RXLOLRecordTableViewCell()
{
    UILabel * _label;
}
@end

@implementation RXLOLRecordTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        _label = [[UILabel alloc] init];
        _label.backgroundColor = [UIColor redColor];
        _label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_label];
    }
    return self;
}


- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    CGFloat width = frame.size.width - 4;
    CGFloat height = frame.size.height - 4;
    _label.frame = CGRectMake(2, 2, width, height);
}

- (void)setRow:(NSInteger)row {
    _row = row;
    _label.text = [NSString stringWithFormat:@"%zd", row];
}

@end
