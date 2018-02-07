//
//  RXSegmentControl.m
//  RXExtenstion
//
//  Created by srx on 2017/11/3.
//  Copyright © 2018年 https://github.com/srxboys. All rights reserved.
//
//已弃用

#import "RXSegmentControl.h"

/*

#define POINT_WH 8

CGFloat const SEGMENT_CONTROL_HEIGHT = 35;


@interface SCMControl : UIControl
@property (nonatomic, copy) NSString * title;
@property (nonatomic, assign) BOOL isShowPoint;
@end


@interface RXSegmentControl()

@property (nonatomic, copy) TouchBlock touchBlock;

@property (nonatomic, copy) SCMControl * allNoticeControl;
@property (nonatomic, copy) SCMControl * unreadNoticeControl;
@end
 
 */

@implementation RXSegmentControl
/*
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.layer.borderWidth = 1;
        self.layer.borderColor = UIColorHexStr(@"64328e").CGColor;
        self.layer.cornerRadius = 4;
        self.sd_cornerRadius = @(4);
        self.clipsToBounds = YES;
        
        _allNoticeControl = [self configControl];
        _allNoticeControl.title = @"全部公告";
        _allNoticeControl.selected = YES;
        
        _unreadNoticeControl = [self configControl];
        _unreadNoticeControl.title = @"未读公告";
        _unreadNoticeControl.selected = NO;
        
        _allNoticeControl.sd_layout
        .leftEqualToView(self)
        .topEqualToView(self)
        .widthRatioToView(self, 0.5)
        .bottomEqualToView(self);

        _unreadNoticeControl.sd_layout
        .leftSpaceToView(_allNoticeControl, 0)
        .topEqualToView(self)
        .rightEqualToView(self)
        .bottomEqualToView(self);

    }
    return self;
}

- (SCMControl *)configControl {
    SCMControl * control = [SCMControl new];
    [control addTarget:self action:@selector(controlClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:control];
    return control;
}

- (void)controlClick:(SCMControl *)control {
    NSInteger selectedIndex = 0;

    if(control == _allNoticeControl) {
        if(_allNoticeControl.isSelected) {
            return;
        }
        _allNoticeControl.selected = YES;
        _unreadNoticeControl.selected = NO;
    }
    else {
        selectedIndex = 1;
        if(_unreadNoticeControl.isSelected) {
            return;
        }
        _unreadNoticeControl.selected = YES;
        _allNoticeControl.selected = NO;
    }

    if(self.touchBlock) {
        self.touchBlock(selectedIndex);
    }
}

- (void)setSegmentTitle:(NSString *)segmentTitle {
    if(StrBool(segmentTitle)) {
        _allNoticeControl.title = [NSString stringWithFormat:@"%@%@", Localized(LOCAL_ALL) ,segmentTitle];
        _unreadNoticeControl.title = [NSString stringWithFormat:@"%@%@", Localized(LOCAL_UNREAD) ,segmentTitle];
    }
}

- (void)clickAction:(TouchBlock)block {
    self.touchBlock = block;
}

- (void)pointWithShow:(BOOL)isShow {
    _unreadNoticeControl.isShowPoint = isShow;
}

@end













@implementation SCMControl {
    UILabel * _titleLabel;
    UIView * _pointView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //改point
    NSString * string = Localized(LOCAL_NOTICE);
    CGFloat width = [string boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 13) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:_titleLabel.font} context:nil].size.width;
    CGPoint point = _titleLabel.center;
    point.x += width + 5 + POINT_WH/2.0;
    _pointView.center = point;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont systemFontOfSize:13];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
        
        _pointView = [UIView new];
        _pointView.hidden = YES;
        _pointView.sd_cornerRadius = @(POINT_WH/2.0);
        _pointView.backgroundColor = UIColorRGB(250, 76, 33);
        [self addSubview:_pointView];
        
        _titleLabel.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
        
        _pointView.sd_layout
        .leftEqualToView(self)
        .topEqualToView(self)
        .widthIs(POINT_WH)
        .heightEqualToWidth();        
    }
    return self;
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    if(selected) {
        self.backgroundColor = UIColorHexStr(@"#64328e");
        _titleLabel.textColor = [UIColor whiteColor];
    }
    else {
        self.backgroundColor = [UIColor whiteColor];
        _titleLabel.textColor = UIColorHexStr(@"#64328e");
    }
}

- (void)setTitle:(NSString *)title {
    _title = title;
    _titleLabel.text = title;
}

- (void)setIsShowPoint:(BOOL)isShowPoint {
    _isShowPoint = isShowPoint;
    _pointView.hidden = !isShowPoint;
}
*/
@end
