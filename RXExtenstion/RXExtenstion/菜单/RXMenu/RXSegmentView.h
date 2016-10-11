//
//  RXSegmentView.h
//  RXExtenstion
//
//  Created by srx on 16/6/6.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//


#import <UIKit/UIKit.h>

@protocol RXSegmentViewDelegate <NSObject>
@optional
- (void)rxSegmentViewClickIndex:(NSInteger)index;
- (void)rxSegmentViewExpansion:(BOOL)expansion index:(NSInteger)index;
@end

//这个，你也可以写死，没有大的改动
@interface RXSegmentView : UIView
@property (nonatomic, strong) id<RXSegmentViewDelegate>delegate;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, strong) NSArray * titleArray;
@end
