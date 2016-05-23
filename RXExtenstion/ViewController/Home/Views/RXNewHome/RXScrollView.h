//
//  RXScrollView.h
//  RXExtenstion
//
//  Created by srx on 16/5/23.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

// 滚动图、焦点图

#import <UIKit/UIKit.h>


@protocol RXScrollViewDelegate <NSObject>

@optional
- (void)rxScrollViewClickIngeter:(NSInteger)num;
@end

@interface RXScrollView : UIView

@property (nonatomic, strong) id<RXScrollViewDelegate>delegate;
- (void)setScrollViewDataArr:(NSArray *)array;

@end
