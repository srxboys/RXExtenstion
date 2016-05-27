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
        RXLog(@"header_%s=", __FUNCTION__);
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
     RXLog(@"header_%s==%@", __FUNCTION__, NSStringFromCGRect(frame));
    CGFloat width = frame.size.width;
    CGFloat height = frame.size.height;
    
    _backImgView.frame = self.contentView.bounds;
    
    CGFloat avasterLeft = (width - AvasterWidthHeight)/2.0;
    CGFloat top  = 30;
    _avasterImgView.frame = CGRectMake(avasterLeft, top, AvasterWidthHeight, AvasterWidthHeight);
    
    top += AvasterWidthHeight + 10;
    _descLabel.frame = CGRectMake(0, top, width, 21);
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if(self) {
        RXLog(@"header_%s===frame=%@", __FUNCTION__, NSStringFromCGRect(self.contentView.frame));
        
        _backImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_backImgView];
        
        _avasterImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _avasterImgView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _avasterImgView.layer.borderWidth = 3;
        _avasterImgView.layer.cornerRadius = AvasterWidthHeight / 2.0;
//        _avasterImgView.clipsToBounds = YES;
        _avasterImgView.layer.masksToBounds = YES;
        [self.contentView addSubview:_avasterImgView];
        
        _descLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _descLabel.textColor = [UIColor grayColor];
        _descLabel.font = [UIFont systemFontOfSize:14];
        _descLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_descLabel];
    }
    return self;
}


- (void)setHeaderData:(RXUser *)userModel {
    [_backImgView sd_setImageFIFOWithURL:[NSURL URLWithString:userModel.user_backImg] placeholderImage:nil];
    
    [_avasterImgView sd_setImageFIFOWithURL:[NSURL URLWithString:userModel.user_avater] placeholderImage:nil];
    
    _descLabel.text = userModel.user_desc;
    
}

- (void)changeHeaderFrame:(CGRect)frame {
    
}



@end
