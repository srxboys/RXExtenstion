//
//  RXMenuController.m
//  RXExtenstion
//
//  Created by srx on 16/6/12.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//
//菜单 -- 点餐客服端常用的

#import "RXMenuController.h"
#import "RXRandom.h"
#import "RXMenu.h"
#import "RXDataModel.h"


#import "RXTableView.h"

@interface RXMenuController ()<RXTableViewDelegate>
{
    RXMenu         * _menu;
    
    RXTableView    * _tableView;
}
@end

@implementation RXMenuController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configUI];
    [self configTable];
}

//所有控件初始化
- (void)configUI {
    //菜单
    _menu = [[RXMenu alloc] initWithFrame:CGRectMake(10, 80, ScreenWidth - 20, 200)];
    _menu.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_menu];

    
    //假数据
    [self configLocalFalseData];
}


//本地假数据
- (void)configLocalFalseData {
    
    //分段控制器的数据源
    NSArray * titleArray = @[@"全城", @"不分种类", @"筛选"];
    _menu.menuSegmentArray = titleArray;
    
    //city
    NSMutableArray * cityArray = [[NSMutableArray alloc] init];
    for(NSInteger i = 0 ; i < 10; i++) {
        RXMenuCityModel * cityModel = [[RXMenuCityModel alloc] init];
        cityModel.cityName = [RXRandom randomChinasWithinCount:8];
        cityModel.citydistanceModel.array = @[@"1", @"2", @"3", @"4", @"5", @"6"];
        cityModel.citydistanceModel.distanceSelected = NO;
        [cityArray addObject:cityModel];
    }
    _menu.menuCityArray = cityArray;
    
    //type
    for(NSInteger i = 0 ; i < 10; i++) {
        
    }
    
    //filter
    for(NSInteger i = 0 ; i < 10; i++) {
        
    }
    
}



- (void)configTable {
    _tableView = [[RXTableView alloc] initWithFrame:CGRectMake(0, 300, ScreenWidth, 350) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.scrollDirection = RXTableViewScrollDirectionHorizontal;
    [self.view addSubview:_tableView];
}
- (NSInteger)RXTableView:(RXTableView *)RXTableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)RXTableView:(RXTableView *)RXTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellInditifier = @"cell";
    UITableViewCell * cell = [RXTableView dequeueReusableCellWithIdentifier:cellInditifier];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellInditifier];
    }
    cell.contentView.backgroundColor = [RXRandom randomColor];
    return cell;
}

- (CGFloat)RXTableView:(RXTableView *)RXTableView heightOrWidthForCellAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
