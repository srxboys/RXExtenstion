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
#import "RXMineCell.h"

#import "RXMineWebViewController.h"
#import "RXMineInfoViewController.h"

@interface RXMineViewController ()<UITableViewDelegate, UITableViewDataSource, RXMineHeaderDelegate>
{

    UITableView    * _tableView;
    NSMutableArray * _dataSouceArr;
    
    RXUser         * _userModel;
    RXMineHeader   * _header;
    CGFloat          _headerHeight;
}
@end

@implementation RXMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configUI];
}


- (void)configUI {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavHeight, ScreenWidth, ScreenHeight - NavHeight - TabbarHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    [_tableView registerNib:[UINib nibWithNibName:@"RXMineCell" bundle:nil] forCellReuseIdentifier:@"RXMineCell"];
    [self.view addSubview:_tableView];

    _headerHeight = 150;
    _header = [[RXMineHeader alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, _headerHeight)];
//    _header.backgroundColor = [UIColor redColor];
    _header.delegate = self;
    [_tableView addSubview:_header];
    //table 内部向下移动
    _tableView.contentInset = UIEdgeInsetsMake(_headerHeight, 0, 0, 0);
    
    _dataSouceArr = [[NSMutableArray alloc] init];
    [self AddFalseData];
    


    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 70, 20);
    [btn setTitle:@"设置" forState:UIControlStateNormal];
    [btn setTitleColor:UIColorHexStr(@"333333") forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(navRightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    btn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
//    btn.backgroundColor = [UIColor redColor];
    
    UIBarButtonItem * rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:btn];

    self.navigationItem.rightBarButtonItem = rightBarButton;

}

- (void)navRightButtonClick {
    RXMineInfoViewController * mineInfoController = RXMeStroBoard(@"RXMineInfoViewController");
    [self.navigationController pushViewController:mineInfoController animated:YES];
}

- (void)AddFalseData {
    //假数据，以真数据形式赋值

    //header
    NSDictionary * userDic = @{
                               @"user_id"      : IntTranslateStr(1881142),
                               @"user_avater"  : @"Mine_avaster",
                               @"user_backImg" : [RXRandom randomImageURL],
                               @"user_desc"    : @"懂得太少，表现太多；才华太少，锋芒太多"
                               };
    _userModel = [RXUser userWithDict:userDic];
    [_header setHeaderData:_userModel];
    
    
    //cell 假数据
    for(NSInteger i = 0; i < 4; i ++) {
        RXMineModel * model = [[RXMineModel alloc] init];
        if(i == 0) {
            model.title = @"我的github";
            model.webUrl = @"https://github.com/srxboys";
            model.image = @"Mine_github";
        }
        else if(i == 1) {
            model.title = @"我的新浪微博";
            model.webUrl = @"https://weibo.com/srxboys";
            model.image = @"Mine_weibo";
        }
        else if(i == 2) {
            model.title = @"我的百度网盘";
            model.webUrl = @"http://pan.baidu.com/s/1hqH9ZNI";
            model.image = @"Mine_BaiduYun";
        }
        else if(i == 3) {
            model.title = @"我的简书";
            model.webUrl = @"http://www.jianshu.com/users/43c74380397c/timeline";
            model.image = @"Mine_JianShu";
        }
        
        [_dataSouceArr addObject:model];
    }
    [_tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //table 第一次，从顶部显示
    _tableView.contentOffset = CGPointMake(0, -_headerHeight);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSouceArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * identifier = @"RXMineCell";
    RXMineCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    RXMineModel * model = _dataSouceArr[indexPath.row];
    [cell setCellData:model];
    return cell;
}





- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    
   
    CGFloat top = offsetY;
    CGFloat left = 0;
    CGFloat width = ScreenWidth;
    CGFloat height = _headerHeight;
//     RXLog(@"offsetY=%.2f====_headerHeight=%.2f", offsetY, _headerHeight);
    RXLog(@"x=%.2f==y=%2.f==width=%.2f===height=%.2f", left, top, width, height);
    
    if(offsetY <= -_headerHeight) {
        //向下滑动
        left = ceilf(fabs(offsetY) - _headerHeight);
        width = left * 2.0 + ScreenWidth;
        height = left + _headerHeight;
        left = - left;
    }
    else {
        //向上滑动
        top = - ceilf(fabs(offsetY)) + ceilf(fabs(offsetY) - _headerHeight);
    }

    
    _header.frame = CGRectMake(left, top, width, height);
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSInteger row = indexPath.row;
    
    RXMineModel * model = _dataSouceArr[row];
    RXMineWebViewController * webController= [[RXMineWebViewController alloc] init];
    webController.model = model;
    //隐藏 tabBar
    webController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webController animated:YES];
}

- (void)mineHeaderClick {    
    
    RXMineModel * model = [[RXMineModel alloc] init];
    model.webUrl = @"http://blog.csdn.net/srxboys/article/details/50586827";
    model.title = @"我的个人说明";
    RXMineWebViewController * webController= [[RXMineWebViewController alloc] init];
    webController.model = model;
    //隐藏 tabBar
    webController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
