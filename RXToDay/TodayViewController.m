//
//  TodayViewController.m
//  RXToDay
//
//  Created by srx on 16/7/8.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//
// > iOS8

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

#import "RXTodayCell.h"

@interface TodayViewController () <NCWidgetProviding, UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self configUI];
}

- (void)configUI {
    _tableView.tableFooterView = [[UIView alloc] init];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellIndetifi = @"RXTodayCell";
    RXTodayCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndetifi];
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    //执行任何必要的安装程序以更新视图。
    //如果遇到错误，使用NCUpdateresultfailed
    //如果有不需要更新，使用NCUpdateresultnodata
    //如果有更新，使用NCUpdateresultnewdata
    
    [self configUI];

    completionHandler(NCUpdateResultNewData);
}


@end
