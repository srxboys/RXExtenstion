//
//  RXMenuController.m
//  RXExtenstion
//
//  Created by srx on 16/6/12.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//
//菜单 -- 点餐客服端常用的

#import "RXMenuController.h"
#import "RXRandom.h"
#import "RXMenu.h"
#import "RXDataModel.h"
#import "RXMenuModel.h"

#import "RXTableView.h"

#import "RXMenuView.h"
#import "RXMenuControllerCell.h"

@interface RXMenuController ()<RXTableViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>
{
    RXMenu         * _menu;
    
    RXTableView    * _tableView;
    
    RXMenuView     * _menuView;
    UICollectionViewFlowLayout * _flowLayout;
    UICollectionView * _collectionView;
    
    NSMutableArray * _menuArray;
    NSMutableArray * _listArray;
}
@end

@implementation RXMenuController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"菜单 选项";
    
    [self configUI];
    [self configTable];
    
    [self configView];
}

//所有控件初始化
- (void)configUI {
    //菜单
    _menu = [[RXMenu alloc] initWithFrame:CGRectMake(10, 80, ScreenWidth - 20, 200)];
    _menu.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_menu];

    
    //假数据
    [self configLocalFalseData];
}


//本地假数据
- (void)configLocalFalseData {
    
    //分段控制器的数据源
    NSArray * titleArray = @[@"全城", @"不分种类", @"筛选"];
    _menu.menuSegmentArray = titleArray;
    
    //city
    NSMutableArray * cityArray = [[NSMutableArray alloc] init];
    for(NSInteger i = 0 ; i < 10; i++) {
        RXMenuCityModel * cityModel = [[RXMenuCityModel alloc] init];
        cityModel.cityName = [RXRandom randomChinasWithinCount:8];
        cityModel.citydistanceModel.array = @[@"1", @"2", @"3", @"4", @"5", @"6"];
        cityModel.citydistanceModel.distanceSelected = NO;
        [cityArray addObject:cityModel];
    }
    _menu.menuCityArray = cityArray;
    
    //type
    for(NSInteger i = 0 ; i < 10; i++) {
        
    }
    
    //filter
    for(NSInteger i = 0 ; i < 10; i++) {
        
    }
    
}


#pragma mark - ~~~~~~~~~~~ 横向菜单 TableView ~~~~~~~~~~~~~~~
- (void)configTable {
    _tableView = [[RXTableView alloc] initWithFrame:CGRectMake(0, 300, ScreenWidth, 60) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.scrollDirection = RXTableViewScrollDirectionHorizontal;
    [self.view addSubview:_tableView];
}
- (NSInteger)RXTableView:(RXTableView *)RXTableView numberOfRowsInSection:(NSInteger)section {
    return 100;//宽度
}

- (UITableViewCell *)RXTableView:(RXTableView *)RXTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellInditifier = @"cell";
    UITableViewCell * cell = [RXTableView dequeueReusableCellWithIdentifier:cellInditifier];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellInditifier];
    }
    cell.contentView.backgroundColor = [RXRandom randomColor];
    cell.textLabel.text = @"tableView";
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    cell.textLabel.textColor = [UIColor blackColor];
    return cell;
}

- (CGFloat)RXTableView:(RXTableView *)RXTableView heightOrWidthForCellAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

#pragma mark - ~~~~~~~~~~~ 横向菜单 自定义View(里面是collectionView) ~~~~~~~~~~~~~~~
- (void)configView {
    //1
//    _menuView = [[RXMenuView alloc] init];
    //2
    _menuView = [[RXMenuView alloc] initWithFrame:CGRectMake(0, 370, ScreenWidth, 50)];
    [_menuView addTarget:self action:@selector(menuAction:)];
    [self.view addSubview:_menuView];
    
    CGFloat top = 370 + 50;
    CGFloat height = ScreenHeight - top;
    
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.minimumInteritemSpacing = 0;
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _flowLayout.itemSize = CGSizeMake(ScreenWidth, height);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, top, ScreenWidth, height) collectionViewLayout:_flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.bounces = NO;
    _collectionView.pagingEnabled = YES;
    _collectionView.scrollsToTop = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:[RXMenuControllerCell class] forCellWithReuseIdentifier:@"RXMenuControllerCell"];
    
    _menuArray = [[NSMutableArray alloc] init];
    _listArray = [[NSMutableArray alloc] init];
    
    [self configCustomLocal];
}


- (void)configCustomLocal {
    for(NSInteger i = 0; i < arc4random() % 100 + 10; i++) {
        RXSeckillMenuMode * menuModel = [[RXSeckillMenuMode alloc] init];
        menuModel.starttime = [[RXRandom randomDateString] longLongValue];
        menuModel.endtime = [RXRandom randomNowDate];
        menuModel.uid = i + 1;
        [_menuArray addObject:menuModel];
    }
    
    //告诉 menu
    _menuView.menuListArray = _menuArray;
    //告诉 reload
    [_collectionView reloadData];

}

- (void)menuAction:(RXMenuView *)menu {
    //    menu.pageNumber
    RXLog(@"menu.pageNumber=%zd", menu.pageNumber);
    
    [_collectionView setContentOffset:CGPointMake(_menuView.pageNumber * ScreenWidth, 0) animated:YES];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _menuArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RXMenuControllerCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RXMenuControllerCell" forIndexPath:indexPath];
    [cell setSeckillMenumodel:_menuArray[indexPath.row]];
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if(scrollView != _collectionView) return;
    
    CGFloat offseyX = scrollView.contentOffset.x;
    [_menuView seckillMenuSelectPageNum:lroundf(offseyX / ScreenWidth)];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
