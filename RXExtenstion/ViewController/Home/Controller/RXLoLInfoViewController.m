//
//  RXLoLInfoViewController.m
//  RXExtenstion
//
//  Created by srx on 16/6/1.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

//  coding ~~~~

/*
    掌上联盟 我 页面的展示效果
 */


#import "RXLoLInfoViewController.h"

@interface RXLoLInfoViewController ()<UIScrollViewDelegate>
{
    UIScrollView * _scrollView;
    UIView       * _mineInfoView;
    UIScrollView * _segmengScrollView;
    
    CGFloat        _commentHeigth;
    CGFloat        _mineInfoViewHeight;
    
    UITableView  * _tableViewOne;
    UITableView  * _tableViewTwo;
}
@end

@implementation RXLoLInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configUI];
}

- (void)configUI {
    _commentHeigth = 50;
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NavHeight, ScreenWidth, ScreenHeight - NavHeight - _commentHeigth)];
    //允许滑动的方向
    _scrollView.alwaysBounceVertical = YES;
    //滑动的速度
    _scrollView.decelerationRate = 0.5;
    [self.view addSubview:_scrollView];
    
    _mineInfoViewHeight = ActureHeight(210);
    _mineInfoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, _mineInfoViewHeight)];
    _mineInfoView.backgroundColor = [UIColor redColor];
    [_scrollView addSubview:_mineInfoView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
