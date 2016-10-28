//
//  RXMineInfoViewController.m
//  RXExtenstion
//
//  Created by srx on 16/6/1.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import "RXMineInfoViewController.h"
#import "RXMineCreateAddressController.h"
#import "RXMineCreateDateController.h"
#import "RX3DTouchSettingController.h"
#import "RXWebKitViewController.h"
#import "RXNew3DTouchSettingController.h"

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
    self.title = @"设置";
    [self configUI];
}

- (void)configUI {
    _tableView.tableFooterView = [[UIView alloc] init];
    
    _dataSouceArray = @[@"新建地址时 选择地区 样式", @"日期、时间 选择 样式",@"3D Touch定制",@"WKWebKit",@"自定义可拖拽cell"];
    
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
        RXMineCreateAddressController * createAddressController = RXMeStroBoard(@"RXMineCreateAddressController");
        [self.navigationController pushViewController:createAddressController animated:YES];
    }
    else if(row == 1) {
        RXMineCreateDateController * dateController = RXMeStroBoard(@"RXMineCreateDateController");
        [self.navigationController pushViewController:dateController animated:YES];
    }
    else if(row == 2) {
        RX3DTouchSettingController * DTouchController = RXMeStroBoard(@"RX3DTouchSettingController");
        [self.navigationController pushViewController:DTouchController animated:YES];
    }
    else if (row == 3) {
        RXWebKitViewController * wxWebKit = [[RXWebKitViewController alloc] init];
        [self.navigationController pushViewController:wxWebKit animated:YES];
    }else if (row == 4) {
        RXNew3DTouchSettingController *rxNew3DTouchVC = [[RXNew3DTouchSettingController alloc] init];
        [self.navigationController pushViewController:rxNew3DTouchVC animated:YES];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
