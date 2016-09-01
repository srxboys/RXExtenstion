//
//  RXTableView.h
//  RXTableView
//
//  Created by srx on 16/9/1.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, RXTableViewScrollDirection) {
    RXTableViewScrollDirectionVertical = 0,
    RXTableViewScrollDirectionHorizontal
};

@class RXTableView;

@protocol RXTableViewDelegate <NSObject>
- (NSInteger)RXTableView:(RXTableView *)RXTableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)RXTableView:(RXTableView *)RXTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
@optional
- (NSUInteger)numberOfSectionsInRXTableView:(RXTableView*)RXTableView;
- (void)RXTableView:(RXTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (UIView*)RXTableView:(RXTableView*)RXTableView viewForHeaderInSection:(NSInteger)section;
- (UIView*)RXTableView:(RXTableView*)RXTableView viewForFooterInSection:(NSInteger)section;
- (CGFloat)RXTableView:(RXTableView *)RXTableView heightOrWidthForCellAtIndexPath:(NSIndexPath *)indexPath;

@end


@interface RXTableView : UIView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style;
@property (nonatomic, strong) id<RXTableViewDelegate>delegate;
@property (nonatomic, assign) RXTableViewScrollDirection scrollDirection;
@property (nonatomic, assign) CGPoint contentOffset;
- (void)setContentOffset:(CGPoint)offset animated:(BOOL)animated;
- (void)reload;

- (__kindof UITableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier;

///register
- (void)registerNib:(UINib *)nib forCellReuseIdentifier:(NSString *)identifier NS_AVAILABLE_IOS(5_0);;
- (void)registerClass:(Class)cellClass forCellReuseIdentifier:(NSString *)identifier NS_AVAILABLE_IOS(6_0);

///reload scrollAnimal
- (void)reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation;
- (void)scrollToRowAtIndexPath:(NSIndexPath *)indexPath atScrollPosition:(UITableViewScrollPosition)scrollPosition animated:(BOOL)animated;
- (void)scrollToNearestSelectedRowAtScrollPosition:(UITableViewScrollPosition)scrollPosition animated:(BOOL)animated;
@end
