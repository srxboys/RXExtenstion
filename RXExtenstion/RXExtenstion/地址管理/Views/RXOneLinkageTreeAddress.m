//
//  RXOneLinkageTreeAddress.m
//  RXExtenstion
//
//  Created by srx on 16/8/8.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//
// 1 级 3 动地址

#import "RXOneLinkageTreeAddress.h"
#import "RXGetArea.h"

@interface RXOneLinkageTreeAddress ()<UITableViewDelegate, UITableViewDataSource>
{
    UIView         * _lightView; //背景、灰色
    UIView         * _addressTable; //tableView 头部 详细地址 大View
    
    UITableView    * _table;
    UILabel        * _tableSelectItemLabel; //详细地址 大View 中的label 省市区
    
    NSInteger        _tableIndex; //地址 3级中哪个级别【省、市、区】
    
    NSMutableArray * _arrCityArr;
    
    // 省市区 的 坐标
    NSInteger        _provinceIndex; //省
    NSInteger        _cityIndex; //市
    NSInteger        _areaIndex; //区
    
    NSMutableArray * _tableTempArr; // 省/市/区 这三个中的地址【这个数组的内容不固定】
    
    // 省市区 的 id
    NSString       * _provinceId;
    NSString       * _cityId;
    NSString       * _areaId;
    
    // 省市区 的 名字
    NSString       * _provinceStr;
    NSString       * _cityStr;
    NSString       * _areaStr;
    UILabel        * _showSelectedCityNameLabel;
}
@end

@implementation RXOneLinkageTreeAddress

- (instancetype)init {
    return [self initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self configTableCity];
    }
    return self;
}


- (void)configTableCity {
    _lightView = [[UIView alloc] initWithFrame:self.bounds];
    _lightView.hidden = YES;
    _lightView.backgroundColor = [UIColor lightGrayColor];
    _lightView.alpha = 0.4f;
    UISwipeGestureRecognizer * swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backSuperView:)];
    [_lightView addGestureRecognizer:swipe];
    [self addSubview:_lightView];
    
    
    _addressTable = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth, 0, ScreenWidth - 15, ScreenHeight)];
    [self addSubview:_addressTable];
    
    _tableIndex = 0;
    
    UIColor *color = [UIColor brownColor];
    
    _tableSelectItemLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth - 15, 50)];
    _tableSelectItemLabel.backgroundColor = color;
    _tableSelectItemLabel.textAlignment = NSTextAlignmentCenter;
    [_addressTable addSubview:_tableSelectItemLabel];
    
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, ScreenWidth - 15, ScreenHeight - 50) style:UITableViewStylePlain];
    _table.dataSource = self;
    _table.delegate = self;
    [_addressTable addSubview:_table];
    
    _arrCityArr = [[NSMutableArray alloc] initWithArray:[RXGetArea getAreaArray]];
    _tableTempArr = [[NSMutableArray alloc] init];
  
    RXLog(@"_arrCityArr.count=%zd", _arrCityArr.count);
    
    
    [self firstCityArr];
    
}

- (void)firstCityArr {
    
    if(_tableTempArr.count > 0) {
        [_tableTempArr removeAllObjects];
    }
    __block NSMutableArray * tempMutableArr = [[NSMutableArray alloc] init];
    [_arrCityArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        //        RXLog(@"obj=%@", obj);
        RXLog(@"--- obj[code]=%@  --- name=%@", obj[@"code"], obj[@"name"]);
        NSDictionary * dic = @{@"code":obj[@"code"], @"name":obj[@"name"]};
        [tempMutableArr addObject:dic];
        
    }];
    
    [_tableTempArr addObjectsFromArray:tempMutableArr];
    [_table reloadData];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _tableTempArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellIndentifiter = nil;
    
    NSString * cityTempStr = nil;
    
    //    RXLog(@"\n\nindex=%ld\n",(long)indexPath.row);
    
    cityTempStr = _tableTempArr[indexPath.row][@"name"];
    
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifiter];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifiter];
    }
    
    //    RXLog(@"cityTempStr=%@", cityTempStr);
    
    cell.textLabel.text = cityTempStr;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(_tableIndex == 0) {
        _provinceStr = _tableTempArr[indexPath.row][@"name"];
        _provinceId = _tableTempArr[indexPath.row][@"code"];
        
        _provinceIndex = indexPath.row;
        
        [_tableTempArr removeAllObjects];
        [_tableTempArr addObjectsFromArray:[self getArrWithIndex:indexPath.row]];
        
        //        RXLog(@"%d", (int)_tableTempArr.count);
        //        if(_tableTempArr.count <=0 )
        //        {
        //            [_tableTempArr removeAllObjects];
        //            [_tableTempArr addObjectsFromArray:_provinceArr];
        //
        //        }
        
        [_table reloadData];
        [_table setContentOffset:CGPointMake(0, 0) animated:YES];
        
        _tableSelectItemLabel.text = _provinceStr;
        
        
        
    }
    else if(_tableIndex == 1) {
        _cityStr = _tableTempArr[indexPath.row][@"name"];
        _cityId = _tableTempArr[indexPath.row][@"code"];
        
        _cityIndex = indexPath.row;
        
        [_tableTempArr removeAllObjects];
        [_tableTempArr addObjectsFromArray:[self getArrWithIndex:indexPath.row]];
        
        [_table reloadData];
        [_table setContentOffset:CGPointMake(0, 0) animated:YES];
        
        _tableSelectItemLabel.text = _provinceStr;
        
        _tableSelectItemLabel.text = [NSString stringWithFormat:@"%@ %@", _provinceStr, _cityStr];
        
        
        
    }
    else {
        _areaStr = _tableTempArr[indexPath.row][@"name"];
        _areaId = _tableTempArr[indexPath.row][@"code"];
        [_tableTempArr removeAllObjects];
        [_tableTempArr addObjectsFromArray:[self getArrWithIndex:indexPath.row]];
        
        //self.view over data
        _showSelectedCityNameLabel.text = [NSString stringWithFormat:@" %@ %@ %@", _provinceStr, _cityStr, _areaStr];
        [self firstCityArr];
        [_table reloadData];
        [_table setContentOffset:CGPointMake(0, 0) animated:YES];
        
        _tableSelectItemLabel.text = [NSString stringWithFormat:@"%@ %@ %@", _provinceStr, _cityStr, _areaStr];
        
        _tableIndex = 0;
        [self hideAddressView];
    }
    
    _tableIndex ++;
    
}

- (NSArray *)getArrWithIndex:(NSInteger)index{
    NSArray * arr = nil;
    if(_tableIndex == 0) {
        arr = _arrCityArr[_provinceIndex][@"children"];
    }
    else if(_tableIndex == 1) {
        arr = _arrCityArr[_provinceIndex][@"children"][_cityIndex][@"children"];
    }
    
    RXLog(@"_provinceIndex=%zd, _cityIndex=%zd, _areaIndex=%zd", _provinceIndex, _cityIndex, _areaIndex);
    
    return arr;
}


- (void)backSuperView:(UISwipeGestureRecognizer *)swip {
    [self hideAddressView];
    
}

- (void)hideAddressView {
    [UIView animateWithDuration:1.5f animations:^{
        _addressTable.frame = CGRectMake(ScreenWidth, 0, ScreenWidth - 15, ScreenHeight);
        
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}
- (void)showAddressView {
    
    self.hidden = NO;
    
    [UIView animateWithDuration:1.5f animations:^{
        _addressTable.frame = CGRectMake(15, 0, ScreenWidth - 15, ScreenHeight);
        //        _lightView.alpha = 1.0f;
    } completion:^(BOOL finished) {
        nil;
    }];
}


@end
