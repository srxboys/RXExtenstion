//
//  RXNewHomeUserInfoView.m
//  RXExtenstion
//
//  Created by srx on 16/5/23.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import "RXNewHomeUserInfoView.h"
#import "RXDataModel.h"
#import "RXCharacter.h"

#import "UIImageView+fadeInFadeOut.h"


@interface RXNewHomeUserInfoView ()
{
    UIImageView * _genderImgView; //性别
    UILabel     * _nameLabel;  //名字
    UIButton    * _loveButton; //关注
    UILabel     * _infoMessageLabel; //简介
    
    UIButton    * _isLoveButton; //被关注数
    UIButton    * _isfansButton; // 粉丝数
}
@end

@implementation RXNewHomeUserInfoView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        //初始化 
    }
    return self;
}

- (void)setUserInfoData:(RXUser *)userModel {
    
}

@end
