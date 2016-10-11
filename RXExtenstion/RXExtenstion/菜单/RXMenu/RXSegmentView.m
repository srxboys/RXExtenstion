//
//  RXSegmentView.m
//  RXExtenstion
//
//  Created by srx on 16/6/6.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//


#import "RXSegmentView.h"
#import "RXSegmentButton.h"
#import "RXRandom.h"

@interface RXSegmentView ()
{
    RXSegmentButton * _tempButton;
    BOOL              _viewExpansion;
}
@end

@implementation RXSegmentView


- (void)setTitleArray:(NSArray *)titleArray {
    _titleArray = titleArray;
    _viewExpansion = NO;
    
    NSInteger count = titleArray.count;
    
    CGFloat width = self.bounds.size.width / count;
    CGFloat height = self.bounds.size.height;
    
    for(NSInteger i = 0; i < count; i ++) {
        RXSegmentButton * button = [[RXSegmentButton alloc] initWithFrame:CGRectMake(i * width, 0, width, height)];
        button.backgroundColor = [RXRandom randomColor];
        button.title = titleArray[i];
        button.rxTag = i;
        [button addTarget:self action:@selector(segmentButtonClick:)];
        [self addSubview:button];
        
        ////图片设置
        
        if(i == 0 || i == count) {
            //没有中间的竖线
        }
        else {
            //有中间的竖线
        }
    }
}

- (void)segmentButtonClick:(RXSegmentButton *)button {
    if(button.rxTag != _tempButton.rxTag) {
        _tempButton.selected = NO;
        _tempButton = button;
        if(!_viewExpansion) {
            _viewExpansion = YES;
//            RXLog(@"---展开2222---");
            [self segmentViewExpansion:_viewExpansion];
        }
    }
    else if(!_viewExpansion){
        //展开
//        RXLog(@"---展开---");
        _tempButton = button;
        _viewExpansion = YES;
        [self segmentViewExpansion:YES];
        return;
    }
    else {
        //收缩
//        RXLog(@"---收缩---");
        _tempButton.selected = NO;
        _viewExpansion = NO;
        [self segmentViewExpansion:_viewExpansion];
    }
    
//    RXLog(@"method=%s----button.tag=%zd", __FUNCTION__, button.rxTag);
    if([self.delegate respondsToSelector:@selector(rxSegmentViewClickIndex:)]) {
        [self.delegate rxSegmentViewClickIndex:button.rxTag];
    }
}

- (void)segmentViewExpansion:(BOOL)expansion {
//    RXLog(@"method=%s----", __FUNCTION__);
    if([self.delegate respondsToSelector:@selector(rxSegmentViewExpansion: index:)]) {
        [self.delegate rxSegmentViewExpansion:expansion index:_tempButton.rxTag];
    }
}

@end
