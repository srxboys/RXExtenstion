//
//  RXSegmentView.m
//  RXExtenstion
//
//  Created by srx on 2017/12/12.
//  Copyright © 2018年 https://github.com/srxboys. All rights reserved.
//

#import "RXSegment_View.h"


CGFloat const SEGMENT_CONTROL_HEIGHT = 45;

#define POINT_LABEL_HEIGHT 14

@interface SCMControl : UIControl
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * pointCLCountString;
@end


@interface RXSegment_View()

@property (nonatomic, copy) TouchBlock touchBlock;

@property (nonatomic, copy) SCMControl * allNoticeControl;
@property (nonatomic, copy) UIView * verticalLineView;
@property (nonatomic, copy) SCMControl * unreadNoticeControl;
@property (nonatomic, copy) UIView * bottomLineView;

@property (nonatomic, copy) UIView * selectLineView;
@property (nonatomic, copy) UIView * SLbingView;
@end

@implementation RXSegment_View

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect frame = _selectLineView.frame;
    frame.size.width = ceilf(ViewWidth(_SLbingView) * (2/3.0));
    frame.origin.x = ceilf(ViewX(_SLbingView) + (ViewWidth(_SLbingView) * (1/3.0))/2.0);
    frame.origin.y = ViewHeight(self) - 1;
    _selectLineView.frame = frame;
    
    CGFloat HalfOfSelfheight = ViewHeight(self)/2.0;
    CGFloat HalfOfSelfwidth = ViewWidth(self)/2.0;
    _verticalLineView.frame = CGRectMake(HalfOfSelfwidth, SEGMENT_CONTROL_HEIGHT/2.0, 0.5, HalfOfSelfheight);
    
    CGFloat contentHeight = ViewHeight(self)-0.5;
    _bottomLineView.frame = CGRectMake(0, 0, contentHeight, 0.5);
    _allNoticeControl.frame = CGRectMake(0, 0, HalfOfSelfwidth, contentHeight);
    _unreadNoticeControl.frame = CGRectMake(ViewRight(_verticalLineView), 0, HalfOfSelfwidth, contentHeight);
}

- (instancetype)init
{
    self = [super init];
    if (self) {
//        self.layer.borderWidth = 1;
//        self.layer.borderColor = UIColorHexStr(@"64328e").CGColor;
//        self.layer.cornerRadius = 4;
//        self.sd_cornerRadius = @(4);
//        self.clipsToBounds = YES;
        
        _allNoticeControl = [self configControl];
        _allNoticeControl.title = @"全部公告";
        _allNoticeControl.selected = YES;
        
        _verticalLineView = [self configLineView];

        _unreadNoticeControl = [self configControl];
        _unreadNoticeControl.title = @"未读公告";
        _unreadNoticeControl.selected = NO;
        
        _bottomLineView = [self configLineView];
        
        _selectLineView = [self configLineView];
        _selectLineView.backgroundColor = UIColorHexStr(@"64328e");
        _SLbingView = _allNoticeControl;
        
        SET_VIEW_HEIGHT(_selectLineView, 1);
        
    }
    return self;
}

- (UIView *)configLineView {
    UIView * lineView = [UIView new];
    lineView.backgroundColor = [UIColor blueColor];
    [self addSubview:lineView];
    return lineView;
}

- (SCMControl *)configControl {
    SCMControl * control = [SCMControl new];
    [control addTarget:self action:@selector(controlClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:control];
    return control;
}

- (void)controlClick:(SCMControl *)control {
    if(control == _allNoticeControl) {
        _selectedIndex = 0;
        if(_allNoticeControl.isSelected) {
            return;
        }
        
        _allNoticeControl.selected = YES;
        _unreadNoticeControl.selected = NO;
    }
    else {
       _selectedIndex = 1;
        if(_unreadNoticeControl.isSelected) {
            return;
        }
        _unreadNoticeControl.selected = YES;
        _allNoticeControl.selected = NO;
    }
    
    _SLbingView = control;
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(controlClick:) object:nil];
    CGRect frame = _selectLineView.frame;
    frame.size.width = ceilf(ViewWidth(_SLbingView) * (2/3.0));
    frame.origin.x = ceilf(ViewX(_SLbingView) + (ViewWidth(_SLbingView) * (1/3.0))/2.0);
    frame.origin.y = ViewHeight(self) - 1;
    [UIView animateWithDuration:0.2 animations:^{
        _selectLineView.frame = frame;
    } completion:^(BOOL finished) {
        
    }];
    
    if(self.touchBlock) {
        self.touchBlock(_selectedIndex);
    }
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    if(selectedIndex == 0) {
        [self controlClick:_allNoticeControl];
    }
    else {
        [self controlClick:_unreadNoticeControl];
    }
}

- (void)setSegmentTitle:(NSString *)segmentTitle {
    if(StrBool(segmentTitle)) {
//        _allNoticeControl.title = [NSString stringWithFormat:@"%@%@", Localized(LOCAL_ALL) ,segmentTitle];
//        _unreadNoticeControl.title = [NSString stringWithFormat:@"%@%@", Localized(LOCAL_UNREAD) ,segmentTitle];
        _allNoticeControl.title = [NSString stringWithFormat:@"%@%@", @"全部" ,segmentTitle];
        _unreadNoticeControl.title = [NSString stringWithFormat:@"%@%@", @"未读" ,segmentTitle];
    }
}

- (void)clickAction:(TouchBlock)block {
    self.touchBlock = block;
}

- (void)pointCountString:(NSString *)countString {
    _unreadNoticeControl.pointCLCountString = countString;
}

@end













@implementation SCMControl {
    UILabel * _titleLabel;

    UILabel * _pointLabel;
    CGFloat _cornerRadius;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _titleLabel.frame = self.bounds;
    _pointLabel.frame = CGRectMake(0, 0, POINT_LABEL_HEIGHT, POINT_LABEL_HEIGHT);
    if(_pointLabel.text.length > 0) {
        //        NSString * string = Localized(LOCAL_NOTICE);
        NSString * string = @"公告";
        CGFloat width = [string boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 13) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:_titleLabel.font} context:nil].size.width;
        CGRect frame = _pointLabel.frame;
        frame.size.width = CGFLOAT_MAX;
        CGFloat pointWidth = ceilf([_pointLabel textRectForBounds:frame limitedToNumberOfLines:1].size.width);
        if(pointWidth+3 < POINT_LABEL_HEIGHT) {
            pointWidth = POINT_LABEL_HEIGHT;
        }
        else {
            pointWidth += 10;
        }
        CGPoint point = _titleLabel.center;
        point.x += width + 5 + pointWidth/2.0;
        SET_VIEW_WIDTH(_pointLabel, pointWidth);
        _pointLabel.center = point;
    }
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:13];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = UIColorHexStr(@"#222222");
        [self addSubview:_titleLabel];
        
        _cornerRadius = ceilf((SEGMENT_CONTROL_HEIGHT-0.5)/2.0);
        _pointLabel = [UILabel new];
        _pointLabel.hidden = YES;
        _pointLabel.font = FontBase(12);
        _pointLabel.textAlignment = NSTextAlignmentCenter;
        _pointLabel.textColor = [UIColor whiteColor];
        _pointLabel.backgroundColor = UIColorRGB(250, 76, 33);
        _pointLabel.layer.cornerRadius = POINT_LABEL_HEIGHT/2.0;
        _pointLabel.clipsToBounds = YES;
        [self addSubview:_pointLabel];

    }
    return self;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    _titleLabel.text = title;
}

- (void)setPointCLCountString:(NSString *)pointCLCountString {
    _pointCLCountString = pointCLCountString;
    if(StrBool(pointCLCountString) && pointCLCountString.length > 0) {
        _pointLabel.hidden = NO;
        _pointLabel.text = pointCLCountString;
        [self setNeedsLayout];
    }
    else {
        _pointLabel.text = @"";
        _pointLabel.hidden = YES;
    }
}

@end
