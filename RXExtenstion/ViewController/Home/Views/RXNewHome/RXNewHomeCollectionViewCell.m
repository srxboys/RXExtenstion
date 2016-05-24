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


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        //初始化内部
        
        UICollectionViewFlowLayout * _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        
        _collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:_flowLayout];
        _collectionView.delegate  = self;
        _collectionView.dataSource = self;
        [self.contentView addSubview:_collectionView];

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
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //上下滑动，告诉父类，就可以改变了
    CGFloat offsetY = scrollView.contentOffset.y;
    if(offsetY < 0) {
        scrollView.contentOffset = CGPointMake(0, 0);
    }
    else {
        if([self.delegate respondsToSelector:@selector(rxNewHomeCollectionViewCellScrollView:)]) {
            [self.delegate rxNewHomeCollectionViewCellScrollView:offsetY];
        }
    }
}
@end
