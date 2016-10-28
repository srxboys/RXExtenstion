//
//  RXMineCell.m
//  RXExtenstion
//
//  Created by srx on 16/6/3.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import "RXMineCell.h"
#import "RXDataModel.h"

@interface RXMineCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end


@implementation RXMineCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellData:(RXMineModel *)model {
    self.imageView.image = [UIImage imageNamed:model.image];
    self.titleLabel.text = model.title;
}

@end
