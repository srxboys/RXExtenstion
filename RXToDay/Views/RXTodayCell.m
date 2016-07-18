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
        
    }
    return self;
}

- (void)setCellData:(RXTodayModel *)model {
//    NSData *data = [NSData dataWithContentsOfURL:url];
//    UIImage *image = [[UIImage alloc] initWithData:data];
//    _imgView.image = image;
    
    [_imgView setOnlineImage:[model.image strNotEmptyValue]];
    
    
    _titleLabel.text = model.time;
    _priceLabel.text = model.comment_count;
}

@end
