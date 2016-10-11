//
//  RXSelectView.m
//  RXExtenstion
//
//  Created by srx on 16/6/6.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//


#import "RXSelectView.h"
#import "RXDataModel.h"

@interface RXSelectView ()<UITableViewDelegate, UITableViewDataSource>
{
    ///城市
    UITableView    * _cityTableView;
    NSMutableArray * _cityArray;
    
    UITableView    * _distanceTableView;
    NSMutableArray * _distanceArray;
    
}
@end

@implementation RXSelectView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //tableView初始化
        _cityTableView     = [self configTableDataAlloc:_cityTableView withCoordinate:0];
        _distanceTableView = [self configTableDataAlloc:_distanceTableView withCoordinate:1];
        
        //背景设置
        _cityTableView.backgroundColor = [UIColor lightGrayColor];
        _distanceTableView.backgroundColor = [UIColor whiteColor];
        
        //注册cell
        [_cityTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"city"];
        [_distanceTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"distance"];
        
        //tableView数据源初始化
        _cityArray      = [[NSMutableArray alloc] init];
        _distanceArray  = [[NSMutableArray alloc] init];
        
        
    }
    return self;
}


- (UITableView *)configTableDataAlloc:(UITableView *)tableView withCoordinate:(NSInteger)coordinate {
    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat width = self.bounds.size.width /2.0;
    CGFloat height = self.bounds.size.height;
    if(coordinate == 1) {
        x = width;
    }
    
    tableView = [[UITableView alloc]initWithFrame:CGRectMake(x, y, width, height) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [[UIView alloc] init];
    [self addSubview:tableView];
    return tableView;
}



- (void)setArray:(NSArray *)array {
    _array = array;
    [_cityArray addObjectsFromArray:array];
    [_cityTableView reloadData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    if(tableView == _cityTableView) {
//        return _cityArray.count;
//    }
//    else {
//        return _distanceArray.count;
//    }
    
    //假数据
    return _cityArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellIdentifier = nil;
    
    RXMenuCityModel * model = _cityArray[indexPath.row];
    NSInteger row = indexPath.row;
    
    if(tableView == _cityTableView) {
        cellIdentifier = @"city";
        
        //我就不自定义了
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        //赋值
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
        cell.textLabel.text = model.cityName;
        
        // >
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        //背景颜色
        cell.backgroundColor = [UIColor clearColor];
        
        //选中颜色
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
        
        return cell;
    }
    else {
        cellIdentifier = @"distance";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        //赋值
        cell.textLabel.text = [NSString stringWithFormat:@"%zd米", row];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        
        //背景颜色
        cell.backgroundColor = [UIColor clearColor];
        
        //选中颜色
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = [UIColor yellowColor];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(tableView == _cityTableView) {
        //选中的置顶
        [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
        
        //右边 tableView的选择
        NSIndexPath * distancePath = [NSIndexPath indexPathForRow:0 inSection:0];
        [_distanceTableView selectRowAtIndexPath:distancePath animated:YES scrollPosition:UITableViewScrollPositionTop];
        //如果想记住_distanceTableView上次的点击 第几个 可以根据 RXMenuCitydistanceModel 来做处理
        
        
    }
    else {
        //这里不做操作
        //只做 记录数据
    }
}

//返回顶部
- (void)scrolToTop {
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    if(_cityArray.count > 0) {
        [_cityTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionTop];
    }
    
    if(_distanceArray.count > 0) {
        [_distanceTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionTop];
    }
}
@end
