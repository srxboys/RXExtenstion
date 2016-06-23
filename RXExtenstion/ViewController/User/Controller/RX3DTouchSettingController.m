//
//  RX3DTouchSettingController.m
//  RXExtenstion
//
//  Created by srx on 16/6/16.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import "RX3DTouchSettingController.h"

@interface RX3DTouchSettingController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation RX3DTouchSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)configUI {
    _tableView.tableFooterView = [[UIView alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
