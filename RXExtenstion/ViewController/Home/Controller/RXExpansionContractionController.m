//
//  RXExpansionContractionController.m
//  RXExtenstion
//
//  Created by srx on 16/6/3.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//
// 存代码
#import "RXRandom.h"
#import "RXDataModel.h" //Json数据模型
#import "RXExpanCCellHeightModel.h" //计算cell高度
#import "RXExpansionContractionCell.h" //自定义cell

#import "RXExpansionContractionController.h"

@interface RXExpansionContractionController ()<UITableViewDelegate, UITableViewDataSource, RXExpansionContractionCellDelegate>
{
    UITableView    * _tableView;
    NSMutableArray * _dataSourceArr;
}

@end

@implementation RXExpansionContractionController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}

- (void)configUI {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavHeight + 10, ScreenWidth, ScreenHeight - NavHeight - 10)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _tableView.tableFooterView = [[UIView alloc] init];
    
    [_tableView registerClass:[RXExpansionContractionCell class] forCellReuseIdentifier:@"customCell"];
    [self.view addSubview:_tableView];
    
    _tableView.estimatedRowHeight = 0;
    _tableView.estimatedSectionFooterHeight = 0;
    _tableView.estimatedSectionHeaderHeight = 0;
    
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = NO;
    }
    
    _dataSourceArr = [[NSMutableArray alloc] init];
    
    [self configFalseLocalData];
}

//本地假数据
- (void)configFalseLocalData {
    for(NSInteger i = 0; i < 5; i ++) {
        RXExpansionContractionModel * model = [[RXExpansionContractionModel alloc] init];
        
        if(i == 0) {
            model.title = @"最高学历：";
        }
        else if(i == 1) {
            model.title = @"教育背景：";
        }
        else if(i == 2) {
            model.title = @"职业经历：";
        }
        else if(i == 3) {
            model.title = @"专业奖项：";
        }
        else if(i == 4) {
            model.title = @"个人介绍：";
        }
        
        //100 以内的汉字
        model.text = [RXRandom randomChinasWithinCount:130];
        
        //交个计算高度的cell
        RXExpanCCellHeightModel * cellModel = [[RXExpanCCellHeightModel alloc] init];
        cellModel.model = model;
        
        [_dataSourceArr addObject:cellModel];
    }
    
    [_tableView reloadData];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSourceArr.count;;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellIdentifier = @"customCell";
    RXExpansionContractionCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.delegate = self;
    NSInteger row = indexPath.row;
    
    [cell setCellData:_dataSourceArr[row] andRow:row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RXExpanCCellHeightModel * model = _dataSourceArr[indexPath.row];
    if(model.isShowHigh) {
        return model.cellHighHeight;
    }
    
    return model.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


//cell中 展开和收缩 按钮的点击
- (void)pansionCCellClick:(NSInteger)row  {
    RXExpanCCellHeightModel * model = _dataSourceArr[row];
    model.isShowHigh = !model.isShowHigh;
    
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    //刷新动画
    [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
