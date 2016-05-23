//
//  RXNewHomeCollectionView.m
//  RXExtenstion
//
//  Created by srx on 16/5/23.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import "RXNewHomeCollectionViewCell.h"

@interface RXNewHomeCollectionViewCell ()<UICollectionViewDelegate, UICollectionViewDataSource>
{
    UICollectionView * _collectionView;
}
@end

@implementation RXNewHomeCollectionViewCell

- (instancetype)initWithTable:(UICollectionView *)collectionView {
    self = [super init];
    if(self) {
        //创建
        _collectionView = nil;
        _collectionView.delegate  = self;
        _collectionView.dataSource = self;
    }
    return self;
}

- (NSMutableArray *)setDataArr {
    if (_dataArr == nil) {
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
}

- (void)setDataArr:(NSMutableArray *)dataArr {
    _dataArr = [[NSMutableArray alloc] initWithArray:dataArr];
    [_collectionView reloadData];
}


//分区
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _dataArr.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataArr.count;
}

#pragma mark - ~~~~~~~~~~~ Collection 分配资源 ~~~~~~~~~~~~~~~
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellIdifier = nil;
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    return nil;
}

#pragma mark - ~~~~~~~~~~~ Collection Cell 大小 ~~~~~~~~~~~~~~~
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    return CGSizeMake(0, 0);
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}


#pragma mark - ~~~~~~~~~~~ scrollViewDelegate ~~~~~~~~~~~~~~~
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //选择菜单
//    self.topScrollMenu.currentIndex =  scrollView.contentOffset.x/ScreenWidth;
//    self.currentCate = scrollView.contentOffset.x/ScreenWidth;
    scrollView.userInteractionEnabled = YES;
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (decelerate) {
        scrollView.userInteractionEnabled = NO;
    }
}
@end
