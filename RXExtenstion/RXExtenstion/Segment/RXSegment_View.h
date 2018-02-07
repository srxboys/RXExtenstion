//
//  RXSegmentView.h
//  RXExtenstion
//
//  Created by srx on 2017/12/12.
//  Copyright © 2018年 https://github.com/srxboys. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN CGFloat const SEGMENT_CONTROL_HEIGHT;

typedef void(^TouchBlock)(NSInteger selectedIndex);

@interface RXSegment_View : UIView
@property (nonatomic, copy) NSString * segmentTitle;//需要自定2个控件标题时，才会用
@property (nonatomic, assign) NSInteger selectedIndex;
- (void)clickAction:(TouchBlock)block;
- (void)pointCountString:(NSString *)countString;
@end
