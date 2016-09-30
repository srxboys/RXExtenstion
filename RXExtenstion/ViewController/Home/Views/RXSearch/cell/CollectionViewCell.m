//
//  CollectionViewCell.m
//  RXExtenstion
//
//  Created by srx on 16/9/30.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import "CollectionViewCell.h"
#import "RXSearchButtonWidthModel.h"

@interface CollectionViewCell ()
{
    UILabel * _textLabel;
}
@end

@implementation CollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        self.contentView.layer.cornerRadius = 4;
        self.contentView.clipsToBounds = YES;
        _textLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_textLabel];
    }
    return self;
}

- (void)setCellModel:(RXSearchButtonWidthModel *)model {
    _textLabel.text = model.title;
}

@end
