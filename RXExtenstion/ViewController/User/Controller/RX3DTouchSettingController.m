//
//  RX3DTouchSettingController.m
//  RXExtenstion
//
//  Created by srx on 16/6/16.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import "RX3DTouchSettingController.h"

@interface RX3DTouchSettingController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray * _souceArray;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation RX3DTouchSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"3D Touch定制";
    [self configUI];
}

- (void)configUI {
    _tableView.tableFooterView = [[UIView alloc] init];
    _souceArray = [[NSMutableArray alloc] init];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _souceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
