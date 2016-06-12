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

@interface RXMenuController ()
{
    RXMenu         * _menu;
}
@end

@implementation RXMenuController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configUI];
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
