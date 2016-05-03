//
//  RXHomeController.m
//  RXExtenstion
//
//  Created by srx on 16/5/3.
//  Copyright © 2016年 srxboys. All rights reserved.
//

#import "RXHomeController.h"

@interface RXHomeController ()<UITableViewDataSource, UITableViewDelegate>
{
    NSArray * arr;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation RXHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configUI];
}

- (void)configUI {
    
    _tableView.tableFooterView = [[UIView alloc] init];
    
    arr = @[@"假数据无需手动",
            @"缓存操作",
            @"获取info.plist信息",
            @"MJ header foother"];
    [_tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * cellIdentifier = @"cellIdentifier";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.textLabel.text = arr[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RXLog(@"%ld", (long)indexPath.row);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
