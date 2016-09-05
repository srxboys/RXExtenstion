//
//  RXMenuControllerCell.m
//  RXExtenstion
//
//  Created by srx on 16/9/5.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import "RXMenuControllerCell.h"
#import "RXCollectionDetailListCell.h"
#import "RXMenuModel.h"
#import "RXAFNS.h"
#import "RXRandom.h"

@interface RXMenuControllerCell ()<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>
{
    UICollectionViewFlowLayout * _flowLayout;
    UICollectionView * _collectionView;
    
    NSMutableArray * _seckilList;
}
@end

@implementation RXMenuControllerCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self isAlloc];
        [self isCreateView];
    }
    return self;
}

- (void)isAlloc {
    [self removeView:_flowLayout];
    [self removeView:_collectionView];
    if(!_seckilList) {
        [_seckilList removeAllObjects];
        _seckilList = nil;
    }
}

- (void)removeView:(id)view {
    if(view) {
        [view removeFromSuperview];
        view = nil;
        RXLog(@"error seckill %s", __FUNCTION__);
    }
}

- (void)isCreateView {
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _flowLayout.itemSize = CGSizeMake(width, height);
    _flowLayout.sectionInset = UIEdgeInsetsZero;
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.minimumInteritemSpacing = 0;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:_flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.scrollsToTop = YES;
    _collectionView.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:_collectionView];
    
    [_collectionView registerClass:[RXCollectionDetailListCell class] forCellWithReuseIdentifier:@"RXCollectionDetailListCell"];
    
    _seckilList = [[NSMutableArray alloc] init];
}

- (void)setSeckillMenumodel:(RXSeckillMenuMode *)seckillMenumodel {
    _seckillMenumodel = seckillMenumodel;
    
    if(_seckilList.count <= 0) {
        //处理
        //    [self requestSeckillList];
        
        [self configLocalFalseData];
    }
    _collectionView.contentOffset = CGPointMake(0, seckillMenumodel.scrollOffsetY);
}

- (void)configLocalFalseData {
    for(NSInteger i = 0; i < arc4random() % 100 + 1; i ++) {
        RXSeckillListModel * model = [[RXSeckillListModel alloc] init];
        model.name = [RXRandom randomChinasWithinCount:10];
        model.image = [RXRandom randomImageURL];
        model.sku = [RXRandom randomLetter];
        model.price = [NSString stringWithFormat:@"%zd.00", arc4random() % 1000 + 10];
        NSInteger bool_int = arc4random() % 2;
        if(bool_int > 1) {
            RXLog(@"error seckillList falseData bool_int>1  =%zd", bool_int);
            bool_int = 1;
        }
        model.store = bool_int;
        [_seckilList addObject:model];
    }
    
    [_collectionView reloadData];
    
    
    
}

- (void)requestSeckillList {
    __weak typeof(self)weakSelf = self;
    NSDictionary * dictionary = @{};
    
    [RXAFNS postReqeustWithParams:dictionary successBlock:^(Response *responseObject) {
        if(!responseObject.status) {
            //失败
            return ;
        }
        RXLog(@"seckillList=\n%@", responseObject.returndata);

    } failureBlock:^(NSError *error) {
        //失败
    } showHUD:NO loadingInView:nil];
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _seckilList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RXCollectionDetailListCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RXCollectionDetailListCell" forIndexPath:indexPath];
    [cell setModel:_seckilList[indexPath.row]];
    cell.contentView.backgroundColor = [RXRandom randomColor];
    return cell;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    _seckillMenumodel.scrollOffsetY = offsetY;
}
@end
