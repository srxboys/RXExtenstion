//
//  RXNewHomeController.m
//  RXExtenstion
//
//  Created by srx on 16/5/23.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import "RXNewHomeController.h"
#import "RXAFNS.h"

#import "RXRandom.h" //用于假数据

#import "RXScrollView.h"
#import "RXNewHomeUserInfoView.h"
#import "RXNewHomeSegmentView.h"
#import "RXNewHomeCollectionViewCell.h" //cell 里包括collectionView

@interface RXNewHomeController ()<UIScrollViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate>
{
    UIScrollView            * _scrollView;
    
    RXScrollView            * _fouceView;
    RXNewHomeUserInfoView   * _userInforView;
    RXNewHomeSegmentView    * _segmentView;
    
    UICollectionView        * _collectionView;
    CGFloat                   _collectionViewHeigth;
    NSMutableArray          * _dataSouceArr;
    
}
@end

@implementation RXNewHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //界面初始化
    [self configUI];
    //假数据
    [self AddFalseData];
}

- (void)configUI {
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NavHeight, ScreenWidth, ScreenHeight - NavHeight)];
    _scrollView.delegate = self;
    _scrollView.decelerationRate = 0.7;//滑动速度
    [self.view addSubview:_scrollView];
    
    CGFloat totalHeigth = 0;
    //轮番图
    CGFloat scrollViewHeight = ActureHeight(210);
    _fouceView = [[RXScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, scrollViewHeight)];
    _fouceView.backgroundColor = [UIColor redColor];
    [_scrollView addSubview:_fouceView];
    
    totalHeigth += scrollViewHeight;
    //用户信息
    _userInforView = [[RXNewHomeUserInfoView alloc] initWithFrame:CGRectMake(0, totalHeigth, ScreenWidth, 100)];
    _userInforView.backgroundColor = [UIColor redColor];
    [_scrollView addSubview:_userInforView];
    
    totalHeigth += 100;
    //分段控制器
    _segmentView = [[RXNewHomeSegmentView alloc] initWithFrame:CGRectMake(0, totalHeigth, ScreenWidth, 50)];
    _segmentView.backgroundColor = [UIColor redColor];
    [_scrollView addSubview:_segmentView];
    
    totalHeigth += 50;
    
    CGFloat commentHeigth = 50; //聊天的高度
    
    _collectionViewHeigth = ScreenHeight - totalHeigth - NavHeight - commentHeigth;
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //垂直方向
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    //header
    flowLayout.headerReferenceSize = CGSizeMake(0.001, 0.001);
    //footer
    flowLayout.footerReferenceSize = CGSizeMake(0.001, 0.001);
    //横向滑动
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //这个是通配，不需要这个，因为cell高度不一样
    //    flowLayout.itemSize = CGSizeMake(ScreenWidth - 10, 50);
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, totalHeigth, ScreenWidth, _collectionViewHeigth) collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    //注册 cell
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [_scrollView addSubview:_collectionView];


}

- (void)AddFalseData {
    
    //collection 假数据
    for(NSInteger i = 0; i < arc4random() % 100 + 10; i++) {
        [_dataSouceArr addObject:@"1"];
    }
    
    [_collectionView reloadData];
    
}


//分区
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _dataSouceArr.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataSouceArr.count;
}

#pragma mark - ~~~~~~~~~~~ Collection 分配资源 ~~~~~~~~~~~~~~~
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellIdifier = @"cell";
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdifier forIndexPath:indexPath];
    cell.contentView.backgroundColor = [RXRandom randomColor];
    return cell;
}

#pragma mark - ~~~~~~~~~~~ Collection Cell 大小 ~~~~~~~~~~~~~~~
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    return CGSizeMake(ScreenWidth, _collectionViewHeigth);
}

#pragma mark - ~~~~~~~~~~~ Collection Cell 间距 ~~~~~~~~~~~~~~~
//定义每个UICollectionView 的间距（返回UIEdgeInsets：上、左、下、右）
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    UIEdgeInsets edg = UIEdgeInsetsZero;
    edg = UIEdgeInsetsMake(0, 0, 0, 0);
    return edg;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
