//
//  RXTodayCell.m
//  RXExtenstion
//
//  Created by srx on 16/7/8.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import "RXTodayCell.h"
#import "RXTodayModel.h"
#import "RXResponse.h"
#import "UIImageView+OnlineImage.h"

#define UIColorRGB(r, g, b)     [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0f]
#define UIColorRandom UIColorRGB(arc4random_uniform(256), \
arc4random_uniform(256), \
arc4random_uniform(256))

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

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
//        _imgView.backgroundColor = UIColorRandom;
    }
    return self;
}

- (void)clearAllText {
    _imgView.image = [[UIImage alloc] init];
    _titleLabel.text = @"";
    _priceLabel.text = @"";
}


- (void)setCellData:(RXTodayModel *)model {
    [self clearAllText];
    
    if(model == nil) return;
//    NSURL * url = [NSURL URLWithString:model.image];
//    NSData *data = [NSData dataWithContentsOfURL:url];
//    UIImage *image = [[UIImage alloc] initWithData:data];
//    _imgView.image = image;
    //下面的 现在崩溃
    [_imgView setOnlineImage:[model.image strNotEmptyValue]];
    
    
    _titleLabel.text = model.name;
    _priceLabel.text = model.price;
}

@end
