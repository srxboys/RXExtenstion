//
//  RXMineInfoViewController.m
//  RXExtenstion
//
//  Created by srx on 16/6/1.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import "RXMineInfoViewController.h"
#import "RXMineCreateAddressController.h"

@interface RXMineInfoViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    NSArray * _dataSouceArray;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation RXMineInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)configUI {
    _tableView.tableFooterView = [[UIView alloc] init];
    
    NSString * title = @"新建地址时 选择地区 样式";
    _dataSouceArray = @[title];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSouceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * identifier = @"mineInfoVC";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.textLabel.text = _dataSouceArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger row = indexPath.row;
    if(row == 0) {
        RXMineCreateAddressController * createAddressController = RXStroyBoard(@"RXMineCreateAddressController", @"RXMineCreateAddressController");
        [self.navigationController pushViewController:createAddressController animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
