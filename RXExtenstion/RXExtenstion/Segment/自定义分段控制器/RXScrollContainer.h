//
//  RXScrollContainer.h
//  RXExtenstion
//
//  Created by srxboys on 2018/3/22.
//  Copyright © 2018年 https://github.com/srxboys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RXScrollContainerProtocol.h"

@class RXScrollContainer;
@protocol RXScrollContainerDelegate <NSObject>

@required
- (NSInteger)numberOfScrollViewInScrollContainer:(RXScrollContainer *)scrollContainer;
- (UIView *)scrollContainer:(RXScrollContainer *)scrollContainer subViewAtIndex:(NSInteger)index;

@optional
- (UIView<RXScrollContainerProtocol> *)tabBarForScrollContainer:(RXScrollContainer *)scrollContainer;
- (void)scrollContainer:(RXScrollContainer *)scrollContainer contentScrollViewDidScroll:(UIScrollView *)scrollView;

@end




@interface RXScrollContainer : UIView
@property (nonatomic, weak) id<RXScrollContainerDelegate> delegate;

@property (nonatomic, assign) BOOL bounces;

- (void)reloadData;
- (void)reloadDataIndex:(NSInteger)index;

- (void)selectIndex:(NSInteger)index animated:(BOOL)animated;

// 如果不存在，返回 NSNotFound
@property (nonatomic, readonly) NSInteger currentPage;


@end
