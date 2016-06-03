//
//  RXNewHomeController.m
//  RXExtenstion
//
//  Created by srx on 16/5/23.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

//  coding ~~~~

#import "RXNewHomeController.h"
#import "RXAFNS.h"

#import "RXRandom.h" //用于假数据

#import "RXScrollView.h"
#import "RXNewHomeUserInfoView.h"
#import "RXNewHomeSegmentView.h"
//下面 两个你用那个都行
#import "RXNewHomeCollectionViewCell.h" //cell 里包括collectionView
#import "RXNewHomeTableViewCell.h" //cell 里包括tableView

@interface RXNewHomeController ()<UIScrollViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate,RXNewHomeTableViewCellDelegate>
{
    UIScrollView            * _scrollView;
    
    RXScrollView            * _fouceView;
    RXNewHomeUserInfoView   * _userInforView;
    RXNewHomeSegmentView    * _segmentView;
    
    UICollectionView        * _collectionView;
    CGFloat                   _collectionViewTop;
    CGFloat                   _collectionViewHeigth;
    NSMutableArray          * _dataSouceArr;
    NSMutableArray          * _collectionViewDataSourceArr;
    
}
@end

@implementation RXNewHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //界面初始化
    [self configUI];
    // 初始化 变量
    [self configDataSource];
    //假数据
    [self AddFalseData];
}

- (void)configUI {

    
    CGFloat totalHeigth = 0;
    //轮番图
    CGFloat scrollViewHeight = ActureHeight(210);
    _fouceView = [[RXScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, scrollViewHeight)];
    _fouceView.backgroundColor = [UIColor redColor];
    
    
    totalHeigth += scrollViewHeight;
    //用户信息
    _userInforView = [[RXNewHomeUserInfoView alloc] initWithFrame:CGRectMake(0, totalHeigth, ScreenWidth, 100)];
    _userInforView.backgroundColor = [RXRandom randomColor];
    
    
    totalHeigth += 100;
    //分段控制器
    _segmentView = [[RXNewHomeSegmentView alloc] initWithFrame:CGRectMake(0, totalHeigth, ScreenWidth, 50)];
    _segmentView.backgroundColor = [RXRandom randomColor];
    
    
    totalHeigth += 50;
    _collectionViewTop = totalHeigth;
    
    CGFloat commentHeigth = 50; //聊天的高度
    
    _collectionViewHeigth = ScreenHeight - NavHeight - commentHeigth;
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
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, NavHeight, ScreenWidth, _collectionViewHeigth) collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    //注册 cell //用 cell 里包括 TableView 的
    [_collectionView registerClass:[RXNewHomeTableViewCell class] forCellWithReuseIdentifier:@"cellContentTableView"];
    
    //不允许超出范围
    _collectionView.bounces = NO;
    //分页
    _collectionView.pagingEnabled = YES;
    
    _collectionView.showsHorizontalScrollIndicator = NO;
    
    [self.view addSubview:_collectionView];
    
    [_collectionView addSubview:_fouceView];
    [_collectionView addSubview:_userInforView];
    [_collectionView addSubview:_segmentView];
    
    _collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, _collectionViewTop);


}

- (void)configDataSource {
    _dataSouceArr = [[NSMutableArray alloc] init];
    _collectionViewDataSourceArr = [[NSMutableArray alloc] init];
}

- (void)AddFalseData {
    
    //collection 假数据
    for(NSInteger i = 0; i < 4; i++) {
        [_dataSouceArr addObject:@"1"];
    }
    
    
    for(NSInteger i = 0; i < 10; i++) {
        [_collectionViewDataSourceArr addObject:[NSString stringWithFormat:@"srxboys_%zd", i]];
    }
    
    [_collectionView reloadData];
    
}


//分区
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _dataSouceArr.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

#pragma mark - ~~~~~~~~~~~ Collection 分配资源 ~~~~~~~~~~~~~~~
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellIdifier = @"cellContentTableView";
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    //用 cell 里包括 TableView 的
    RXNewHomeTableViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdifier forIndexPath:indexPath];
    [cell setCellDataArr:_collectionViewDataSourceArr andSection:section];
    cell.delegate = self;
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




#pragma mark - ~~~~~~~~~~~ 子类竖向滑动改变此页面的 CGPoint ~~~~~~~~~~~~~~~
- (void)RXNewHomeTableViewCellScrollView:(CGFloat)offsetY {
    RXLog(@"RXNewHome-offsety=%.2f", offsetY);
    
    offsetY = -_collectionViewTop - offsetY;
    CGFloat offsetX = _collectionView.contentOffset.x;
    //    RXLog(@"offsetY=%.2f===%.2f", offsetY, _collectionViewTop);
    CGFloat totalHeigth = offsetY;
    //轮番图
    CGFloat scrollViewHeight = ActureHeight(210);
    _fouceView.frame = CGRectMake(offsetX, totalHeigth, ScreenWidth, scrollViewHeight);
    
    totalHeigth += scrollViewHeight;
    _userInforView.frame = CGRectMake(offsetX, totalHeigth, ScreenWidth, 100);
    
    totalHeigth += 100;
    _segmentView.frame = CGRectMake(offsetX, totalHeigth, ScreenWidth, 50);
}



#pragma mark - ~~~~~~~~~~~ 横向滚动 ~~~~~~~~~~~~~~~
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    //只是横向滚动 赋值 //竖向滚动需要子cell反馈
    
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat offsetX = scrollView.contentOffset.x;
//    RXLog(@"offsetY=%.2f===%.2f", offsetY, _collectionViewTop);
    CGFloat totalHeigth = offsetY;
    //轮番图
    CGFloat scrollViewHeight = ActureHeight(210);
    _fouceView.frame = CGRectMake(offsetX, totalHeigth, ScreenWidth, scrollViewHeight);
    
    totalHeigth += scrollViewHeight;
    _userInforView.frame = CGRectMake(offsetX, totalHeigth, ScreenWidth, 100);
    
    totalHeigth += 100;
    _segmentView.frame = CGRectMake(offsetX, totalHeigth, ScreenWidth, 50);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
