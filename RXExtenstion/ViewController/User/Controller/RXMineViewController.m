//
//  RXMineViewController.m
//  RXExtenstion
//
//  Created by srx on 16/5/27.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import "RXMineViewController.h"
#import "RXDataModel.h"
#import "RXConstant.h"
#import "RXRandom.h"

#import "RXMineHeader.h"
#define imageString @"https://avatars3.githubusercontent.com/u/16399242?v=3&amp.png"

@interface RXMineViewController ()<UITableViewDelegate, UITableViewDataSource>
{

    UITableView    * _tableView;
    NSMutableArray * _dataSouceArr;
    RXUser         * _userModel;
}
@end

@implementation RXMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configUI];
}


- (void)configUI {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavHeight, ScreenWidth, ScreenHeight - NavHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [_tableView registerClass:[RXMineHeader class] forHeaderFooterViewReuseIdentifier:@"header"];
    [self.view addSubview:_tableView];
    
    _dataSouceArr = [[NSMutableArray alloc] init];
    [self AddFalseData];
}

- (void)AddFalseData {
    //假数据，以真数据形式赋值

    NSDictionary * userDic = @{
                               @"user_id"      : IntTranslateStr(1881142),
                               @"user_avater"  : imageString,
                               @"user_backImg" : [RXRandom randomImageURL],
                               @"user_desc"    : @"懂得太少，表现太多；才华太少，锋芒太多"
                               };
    _userModel = [RXUser userWithDict:userDic];
    [_tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return _dataSouceArr.count;
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * identifier = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    return cell;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    static NSString * identifier = @"header";
    RXMineHeader * header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    if(_userModel) {
        [header setHeaderData:_userModel];
    }
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 150;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 10;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
