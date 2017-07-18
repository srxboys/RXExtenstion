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
#import "RXLOLCollectionViewCell.h"
#import "MJRefresh.h"

@interface RXLoLInfoViewController ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    UICollectionViewFlowLayout * _flowLayout;
    UICollectionView * _collectionView;
}
@end

@implementation RXLoLInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configUI];
}

- (void)configUI {
    
    CGFloat height = ScreenHeight - NavHeight;
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.sectionInset = UIEdgeInsetsZero;
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.minimumInteritemSpacing = 0;
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _flowLayout.itemSize = CGSizeMake(ScreenWidth, height);
    
    //如果你单前的页面是 cell ，(反正就是滚动屏幕的一块)
    BOOL currentPageIsCell = NO; /** 很重要 */
    
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NavHeight, ScreenWidth, height)];
    scrollView.pagingEnabled = YES;
    if(currentPageIsCell) {
        [self.view addSubview:scrollView];
        scrollView.contentSize = CGSizeMake(ScreenWidth * 4, height);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, height) collectionViewLayout:_flowLayout];
    }
    else {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, NavHeight, ScreenWidth, height) collectionViewLayout:_flowLayout];
    }
    
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.pagingEnabled = YES;
    if(currentPageIsCell) {
        [scrollView addSubview:_collectionView];
    }
    else {
        [self.view addSubview:_collectionView];
    }
    
    
    //注册cell
    [_collectionView registerClass:[RXLOLCollectionViewCell class] forCellWithReuseIdentifier:RXLOLCellIdentifier];

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RXLOLCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:RXLOLCellIdentifier forIndexPath:indexPath];
    cell.cellType = indexPath.item;
    return cell;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
