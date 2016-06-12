//
//  RXSegmentButton.m
//  Test_Menu
//
//  Created by srx on 16/6/6.
//  Copyright © 2016年 srxboys. All rights reserved.
//

#import "RXSegmentButton.h"
#import <objc/message.h>
#define RXMsgSend(...) ((void (*)(void *, SEL, RXSegmentButton *))objc_msgSend)(__VA_ARGS__)
#define RXMsgTarget(target) (__bridge void *)(target)

#define ImageAnimalDuration 0.3

@interface RXSegmentButton ()
{
    UILabel     * _titleLabel;
    UIImageView * _imageView;
    
    BOOL          _selected;
}

@property (nonatomic, weak)   id  rxTarget;
@property (nonatomic, assign) SEL rxAction;

@end

@implementation RXSegmentButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _selected = NO;
        _titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _titleLabel.textColor = [UIColor lightGrayColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
        
        CGFloat width  = 14;
        CGFloat heitht = 8;
        CGFloat left   = frame.size.width - 14 - 2;
        CGFloat top    = (frame.size.height - 8)/2.0;
        
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(left, top, width, heitht)];
        //我的图片是  14*8 //这个换成你的图片、尺寸
        _imageView.image = [UIImage imageNamed:@"pic_arrow_down_deepgrey"];
        [self addSubview:_imageView];
        
        UITapGestureRecognizer * gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageAction)];
        gesture.numberOfTouchesRequired = 1;
        gesture.numberOfTapsRequired = 1;
        [self addGestureRecognizer:gesture];
        
        
        _selected = NO;
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    _titleLabel.text = title;
}



- (void)addTarget:(id)target action:(SEL)action {
    _rxTarget = target;
    _rxAction = action;
}


- (void)imageAction {
    if([_rxTarget respondsToSelector:_rxAction]) {
        self.selected = !_selected;
        RXMsgSend(RXMsgTarget(_rxTarget), _rxAction, self);
    }
}

- (void)setSelected:(BOOL)selected {
    _selected = selected;
    if(!_selected) {
        _titleLabel.textColor = [UIColor lightGrayColor];
    }
    else {
        _titleLabel.textColor = [UIColor magentaColor];
    }
    [self imageViewAnimation];
}


- (void)imageViewAnimation {
    if(_selected) {
        [UIView animateWithDuration:ImageAnimalDuration animations:^{
            _imageView.transform = CGAffineTransformMakeRotation(M_PI);
        } completion:^(BOOL finished) {
            
        }];
    }
    else {
        //1
        [UIView animateWithDuration:ImageAnimalDuration animations:^{
            _imageView.transform = CGAffineTransformMakeRotation(0);
        } completion:^(BOOL finished) {
           
        }];
        
        //2
        //_imageView.transform = CGAffineTransformMakeRotation(0);
    }
}




@end
