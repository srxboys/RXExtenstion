//
//  RXTableView.m
//  RXTableView
//
//  Created by srx on 16/9/1.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import "RXTableView.h"

@interface RXTableView ()<UITableViewDelegate, UITableViewDataSource>
{
    UITableView * _tableView;
}
@end

@implementation RXTableView
- (instancetype)init {
    return [self initWithFrame:CGRectZero style:UITableViewStylePlain];
}
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame];
    if(self) {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds style:style];
        _tableView.delegate			= self;
        _tableView.dataSource		= self;
        _tableView.rowHeight        = 40; //默认40的高度
//        _tableView.autoresizingMask	= UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:_tableView];
        _scrollDirection = RXTableViewScrollDirectionVertical;
    }
    return self;
}

- (CGPoint)contentOffset {
    CGPoint offset = _tableView.contentOffset;
    
    if (_scrollDirection == RXTableViewScrollDirectionHorizontal)
        offset = CGPointMake(offset.y, offset.x);
    return offset;
}
- (void)setContentOffset:(CGPoint)offset {
    [self setContentOffset:offset animated:NO];
}

- (void)setContentOffset:(CGPoint)offset animated:(BOOL)animated {
    CGPoint newOffset = (_scrollDirection == RXTableViewScrollDirectionHorizontal) ? CGPointMake(offset.y, offset.x) : offset;
    [_tableView setContentOffset:newOffset animated:animated];
}

- (void)setScrollDirection:(RXTableViewScrollDirection)scrollDirection {
    _scrollDirection = scrollDirection;
    if (!_tableView)
        return;
    
    _tableView.transform	= CGAffineTransformIdentity;
    _tableView.frame		= self.bounds;
    
    if (scrollDirection == RXTableViewScrollDirectionHorizontal) {
        int xOrigin	= (self.bounds.size.width - self.bounds.size.height) / 2.0;
        int yOrigin	= (self.bounds.size.height - self.bounds.size.width) / 2.0;
        
        _tableView.frame		= CGRectMake(xOrigin, yOrigin, self.bounds.size.height, self.bounds.size.width);
        _tableView.transform	= CGAffineTransformMakeRotation(-M_PI/2);
        
        _tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, self.bounds.size.height - 7.0);
    }

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    __weak typeof(self)weakSelf = self;
    if ([weakSelf.delegate respondsToSelector:@selector(numberOfSectionsInRXTableView:)]) {
        return [weakSelf.delegate numberOfSectionsInRXTableView:self];
    }
    return 1;
}

- (void)reload {
    [_tableView reloadData];
}

#pragma mark - Footers and Headers
- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section {
    __weak typeof(self)weakSelf = self;
    if ([weakSelf.delegate respondsToSelector:@selector(RXTableView:viewForHeaderInSection:)]) {
        UIView *headerView = [weakSelf.delegate RXTableView:weakSelf viewForHeaderInSection:section];
        
        if (weakSelf.scrollDirection == RXTableViewScrollDirectionHorizontal)
            return headerView.frame.size.width;
        else
            return headerView.frame.size.height;
    }
    return 0.00001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    __weak typeof(self)weakSelf = self;
    if ([weakSelf.delegate respondsToSelector:@selector(RXTableView:viewForFooterInSection:)]) {
        UIView *footerView = [weakSelf.delegate RXTableView:weakSelf viewForFooterInSection:section];
        
        if (weakSelf.scrollDirection == RXTableViewScrollDirectionHorizontal)
            return footerView.frame.size.width;
        else
            return footerView.frame.size.height;
    }
    return 0.00001;
}

- (UIView *)viewToHoldSectionView:(UIView *)sectionView {
    // Enforce proper section header/footer view height abd origin. This is required because
    // of the way UITableView resizes section views on orientation changes.
    if (self.scrollDirection == RXTableViewScrollDirectionHorizontal)
        sectionView.frame = CGRectMake(0, 0, sectionView.frame.size.width, self.frame.size.height);
    
    UIView *rotatedView = [[UIView alloc] initWithFrame:sectionView.frame];
    
    if (self.scrollDirection == RXTableViewScrollDirectionHorizontal) {
        rotatedView.transform = CGAffineTransformMakeRotation(M_PI/2);
        sectionView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    }
    else {
        sectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    [rotatedView addSubview:sectionView];
    return rotatedView;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    __weak typeof(self)weakSelf = self;
    if ([weakSelf.delegate respondsToSelector:@selector(RXTableView:viewForHeaderInSection:)]) {
        UIView *sectionView = [weakSelf.delegate RXTableView:weakSelf viewForHeaderInSection:section];
        
        return [self viewToHoldSectionView:sectionView];
    }
    return nil;
}
- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    __weak typeof(self)weakSelf = self;
    if ([weakSelf.delegate respondsToSelector:@selector(RXTableView:viewForFooterInSection:)]) {
        UIView *sectionView = [weakSelf.delegate RXTableView:weakSelf viewForFooterInSection:section];
        
        return [self viewToHoldSectionView:sectionView];
    }
    return nil;
}
#pragma mark - TableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(RXTableView:didSelectRowAtIndexPath:)]) {
        [self.delegate RXTableView:self didSelectRowAtIndexPath:indexPath];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(RXTableView:heightOrWidthForCellAtIndexPath:)]) {
        return [self.delegate RXTableView:self heightOrWidthForCellAtIndexPath:indexPath];
    }
    
    return tableView.rowHeight;
}

#pragma mark - TableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.delegate RXTableView:self numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [self.delegate RXTableView:self cellForRowAtIndexPath:indexPath];
    
    // Rotate if needed
    if ((self.scrollDirection == RXTableViewScrollDirectionHorizontal) &&
        CGAffineTransformEqualToTransform(cell.contentView.transform, CGAffineTransformIdentity)) {
        int xOrigin	= (cell.bounds.size.width - cell.bounds.size.height) / 2.0;
        int yOrigin	= (cell.bounds.size.height - cell.bounds.size.width) / 2.0;
        
        cell.contentView.frame		= CGRectMake(xOrigin, yOrigin, cell.bounds.size.height, cell.bounds.size.width);
        cell.contentView.transform	= CGAffineTransformMakeRotation(M_PI/2.0);
    }
    return cell;
}


- (__kindof UITableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier {
    return [_tableView dequeueReusableCellWithIdentifier:identifier];
}


#pragma mark - TableView register
- (void)registerClass:(Class)cellClass forCellReuseIdentifier:(NSString *)identifier {
    [_tableView registerClass:cellClass forCellReuseIdentifier:identifier];
}

- (void)registerNib:(UINib *)nib forCellReuseIdentifier:(NSString *)identifier {
    [_tableView registerNib:nil forCellReuseIdentifier:identifier];
}

#pragma mark - TableView Reload scrollAnimal
- (void)reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    [_tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:animation];
}

- (void)scrollToRowAtIndexPath:(NSIndexPath *)indexPath atScrollPosition:(UITableViewScrollPosition)scrollPosition animated:(BOOL)animated {
    [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:scrollPosition animated:animated];
}

- (void)scrollToNearestSelectedRowAtScrollPosition:(UITableViewScrollPosition)scrollPosition animated:(BOOL)animated {
    [_tableView scrollToNearestSelectedRowAtScrollPosition:scrollPosition animated:animated];
}

@end
