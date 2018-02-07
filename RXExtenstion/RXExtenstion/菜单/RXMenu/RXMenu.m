//
//  RXMenu.m
//  RXExtenstion
//
//  Created by srx on 16/6/6.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//


#import "RXMenu.h"
#import "RXSegmentView.h" //分段控制器
#import "RXSelectView.h" //地址table

#define animalDuration 0.5


@interface RXMenu ()<UITableViewDelegate, UITableViewDataSource, RXSegmentViewDelegate>
{
    //按钮初始化
    CGFloat           _menuHeight;
    CGRect            _menuFrame;
    
    //分段控制器
    RXSegmentView   * _segmentView;
    
    ///城市
    RXSelectView    * _cityView;
    
    //种类
    UITableView     * _typeTableView;
    NSMutableArray  * _typeArray;
    
    //筛选
    UITableView     * _filterTableView;
    NSMutableArray  * _filterArray;
    
}
@end

@implementation RXMenu

- (instancetype)initWithFrame:(CGRect)frame
{
    _menuFrame = frame;
    CGFloat x = frame.origin.x;
    CGFloat y = frame.origin.y;
    CGFloat width = frame.size.width;
    CGFloat height = SegmentHeight;
    _menuHeight = frame.size.height;
    
    //这个只是看效果，真正的要看下面的
//    self = [super initWithFrame:CGRectMake(x, y, width, _menuHeight)];
    
    self = [super initWithFrame:CGRectMake(x, y, width, height)];
    if (self) {
        //tableView初始化
        [self configSegmentView:frame];
        [self configCityView:frame];
       _typeTableView   = [self configTableDataAlloc:_typeTableView frame:frame];
       _filterTableView = [self configTableDataAlloc:_filterTableView frame:frame];
        
        //背景设置
        _typeTableView.backgroundColor = [UIColor lightGrayColor];
        _filterTableView.backgroundColor = [UIColor blueColor];
        
        //tableView数据源初始化
        _typeArray   = [[NSMutableArray alloc] init];
        _filterArray = [[NSMutableArray alloc] init];
        
        
        //剪掉多余的部分
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)configSegmentView:(CGRect)frame {
    CGFloat width = frame.size.width;
    _segmentView = [[RXSegmentView alloc] initWithFrame:CGRectMake(0, 0, width, SegmentHeight)];
    _segmentView.delegate = self;
    [self addSubview:_segmentView];
}


- (void)configCityView:(CGRect)frame {
    CGFloat width = frame.size.width;
    CGFloat height = frame.size.height - SegmentHeight;
    _cityView = [[RXSelectView alloc] initWithFrame:CGRectMake(0, SegmentHeight, width, height)];
    [self addSubview:_cityView];

}
#pragma mark - ~~~~~~~~~~~ Segment Delegate ~~~~~~~~~~~~~~~
- (void)rxSegmentViewClickIndex:(NSInteger)index {
    _cityView.hidden        = YES;
    _typeTableView.hidden   = YES;
    _filterTableView.hidden = YES;
    
    if(index == 0) {
        _cityView.hidden = NO;
    }
    else if(index == 1) {
        _typeTableView.hidden = NO;
    }
    else if(index == 2) {
        _filterTableView.hidden = NO;
    }
    
}

- (void)rxSegmentViewExpansion:(BOOL)expansion index:(NSInteger)index{
    CGFloat height = SegmentHeight;
    if(expansion) {
        height = _menuFrame.size.height;
    }
    
    
    [UIView animateWithDuration:animalDuration animations:^{
        self.frame = CGRectMake(_menuFrame.origin.x, _menuFrame.origin.y, _menuFrame.size.width, height);
    } completion:^(BOOL finished) {
        self.clipsToBounds = YES;
        if(index == 0) {
            if(_menuCityArray.count > 0) {
                [_cityView scrolToTop];
            }
        }
        else if(index == 1) {
            
        }
        else if(index == 2) {
            
        }
    }];
}

#pragma mark - ~~~~~~~~~~~ <# descripe #> ~~~~~~~~~~~~~~~
- (UITableView *)configTableDataAlloc:(UITableView *)tableView frame:(CGRect)frame {
    
    CGFloat width = frame.size.width;
    CGFloat height = frame.size.height - SegmentHeight;
    
    tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, SegmentHeight, width, height) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [[UIView alloc] init];
    [self addSubview:tableView];
    
    tableView.hidden = YES;
    return tableView;
}


#pragma mark - ~~~~~~~~~~~ 初始化数据源 ~~~~~~~~~~~~~~~
- (void)setArray:(NSArray *)array {
    _array = array;
//    [_dataSourceArr addObjectsFromArray:array];
//    [_tableView reloadData];
}

- (void)setMenuSegmentArray:(NSArray *)menuSegmentArray {
    _menuSegmentArray = menuSegmentArray;
    _segmentView.titleArray = menuSegmentArray;
}

- (void)setMenuCityArray:(NSArray *)menuCityArray {
    _menuCityArray = menuCityArray;
    _cityView.array = menuCityArray;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
  if(tableView == _typeTableView) {
        return _typeArray.count;
    }
    else if(tableView == _filterTableView) {
        return _filterArray.count;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * cellIdentifier = @"1";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(tableView == _typeTableView) {
        return 20;
    }
    else if(tableView == _filterTableView) {
        return 30;
    }
    
    return 0;
}

@end
