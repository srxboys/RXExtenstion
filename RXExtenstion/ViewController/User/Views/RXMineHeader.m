//
//  RXMineHeader.m
//  RXExtenstion
//
//  Created by srx on 16/5/27.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import "RXMineHeader.h"
#import "RXCharacter.h"
#import "RXDataModel.h"
#import "UIImageView+fadeInFadeOut.h"


#define AvasterWidthHeight 60

@interface RXMineHeader ()
{
    UIImageView * _backImgView;
    UIImageView * _avasterImgView;
    UILabel     * _descLabel;
}
@end

@implementation RXMineHeader

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        RXLog(@"header_%s=%@", __FUNCTION__, NSStringFromCGRect(frame));
        [self configHeaderAlloc];
        [self setFrame:frame];
    }
    return self;
}

- (void)configHeaderAlloc {
    _backImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self addSubview:_backImgView];
    
    _avasterImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    ViewBorderRadius(_avasterImgView, AvasterWidthHeight / 2.0, 3, [UIColor lightGrayColor]);
    [self addSubview:_avasterImgView];
    
    _descLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _descLabel.textColor = [UIColor grayColor];
    _descLabel.font = [UIFont systemFontOfSize:14];
    _descLabel.textAlignment = NSTextAlignmentCenter;
    _descLabel.shadowOffset = CGSizeMake(0.5, 0.5);
    _descLabel.shadowColor = [UIColor blueColor];
    [self addSubview:_descLabel];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
//    RXLog(@"header_%s", __FUNCTION__);
    CGFloat width = frame.size.width;
    CGFloat height = frame.size.height;
    
    _backImgView.frame = CGRectMake(0, 0, width, height);
    
    CGFloat avasterLeft = (width - AvasterWidthHeight)/2.0;
    CGFloat top  = (height - AvasterWidthHeight - 10 - 21)/2.0;
    _avasterImgView.frame = CGRectMake(avasterLeft, top, AvasterWidthHeight, AvasterWidthHeight);
    
    top += AvasterWidthHeight + 10;
    _descLabel.frame = CGRectMake(0, top, width, 21);
}


- (void)setHeaderData:(RXUser *)userModel {
    [_backImgView sd_setImageFIFOWithURL:[NSURL URLWithString:userModel.user_backImg] placeholderImage:nil];
    
    [_avasterImgView sd_setImageFIFOWithURL:[NSURL URLWithString:userModel.user_avater] placeholderImage:nil];
    
    _descLabel.text = userModel.user_desc;
}



@end
