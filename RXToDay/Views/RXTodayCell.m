//
//  RXTodayCell.m
//  RXExtenstion
//
//  Created by srx on 16/7/8.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import "RXTodayCell.h"

@interface RXTodayCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end


@implementation RXTodayCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
