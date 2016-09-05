//
//  RXCollectionDetailListCell.m
//  RXExtenstion
//
//  Created by srx on 16/9/5.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import "RXCollectionDetailListCell.h"
#import "RXMenuModel.h"
#import "UIImageView+fadeInFadeOut.h"
#import "RXCharacter.h"

@interface RXCollectionDetailListCell ()
{
    UIImageView * _imgView;
    UILabel * _nameLabel;
    UILabel * _priceNameLabel;
    UILabel * _priceLabel;
}
@end


@implementation RXCollectionDetailListCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self isAlloc];
        [self isCreateView];
    }
    return self;
}

- (void)isAlloc {
    [self removeView:_imgView];
    [self removeView:_nameLabel];
    [self removeView:_priceNameLabel];
    [self removeView:_priceLabel];
}

- (void)removeView:(id)view {
    if(view) {
        [view removeFromSuperview];
        view = nil;
        RXLog(@"error GHSSeckillDetailListCell %s", __FUNCTION__);
    }
}
- (void)isCreateView {
    CGFloat left = 40;
    CGFloat top = 40;
    
    CGFloat width = self.bounds.size.width - (left * 2);
    CGFloat height = self.bounds.size.height - (top * 2);
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(left, top, width, height)];
    _imgView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_imgView];
}

- (void)setModel:(RXSeckillListModel *)model {
    _model = model;
    
    if(model != nil && [model.name strBOOL]) {
        NSURL * url = [NSURL URLWithString:model.image];
        [_imgView sd_setImageFIFOWithURL:url placeholderImage:[UIImage imageNamed:@"Image750_750_gray"]];
    }
}
@end
