//
//  RXMenuView.m
//  RXExtenstion
//
//  Created by srx on 16/9/5.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import "RXMenuView.h"

#import "RXMenuViewCollectionCell.h"
#import "RXRandom.h"

#import <objc/message.h>


#define DEFAULT_CellWidth 100

// 运行时objc_msgSend -- 根据MJRefresh而来
#define RXMsgSend(...) ((void (*)(void *, SEL, RXMenuView*))objc_msgSend)(__VA_ARGS__)
#define RXMsgTarget(target) (__bridge void *)(target)

@interface RXMenuView ()<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>
{
    UICollectionViewFlowLayout * _flowLayout;
    UICollectionView * _collectionView;
    
    CGFloat _cellWidth;
}

@property (nonatomic, weak)   id  menuTarget;
@property (nonatomic, assign) SEL menuAction;
@end

@implementation RXMenuView

- (instancetype)init {
    return  [self initWithFrame:CGRectMake(0, NavHeight, ScreenWidth, 50)];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        self.backgroundColor = [UIColor whiteColor];
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _flowLayout.minimumInteritemSpacing = 0;
        _flowLayout.minimumLineSpacing = 0;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:_flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.bounces = NO;
        _collectionView.scrollsToTop = NO;
        //        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor yellowColor];
        [_collectionView registerClass:[RXMenuViewCollectionCell class] forCellWithReuseIdentifier:@"RXMenuViewCollectionCell"];
        [self addSubview:_collectionView];
        _pageNumber = 0;
        
        _cellWidth = DEFAULT_CellWidth;
    }
    return self;
}

- (void)setMenuListArray:(NSArray *)menuListArray {
    _menuListArray = menuListArray;
    NSInteger count = menuListArray.count;
    if(count > 0) {
        self.hidden = NO;
        if(_cellWidth < roundf(ScreenWidth / count * 1.0)) {
            _cellWidth = roundf(ScreenWidth / count * 1.0);
        }
        [_collectionView reloadData];
    }
    else {
        self.hidden = YES;
    }
} 

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _menuListArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    RXMenuViewCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RXMenuViewCollectionCell" forIndexPath:indexPath];
    [cell setSeckillMenuCellData:_menuListArray[row] isShowAnimal:row == _pageNumber];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    //0 / count -->特殊处理
    
    return CGSizeMake(_cellWidth, self.bounds.size.height);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    if(_pageNumber == row) return;
    
    [self seckillMenuSelectPageNum:row];
    
    _pageNumber = row;
    if(self.menuTarget) {
        RXMsgSend(RXMsgTarget(_menuTarget), _menuAction, self);
    }

}


#pragma mark - ~~~~~~~~~~~ 外部调用 方法 ~~~~~~~~~~~~~~~
- (void)addTarget:(id)target action:(SEL)action {
    self.menuTarget = target;
    self.menuAction = action;
}

- (void)seckillMenuSelectPageNum:(NSInteger)num {
    [self newPageNumToSelfPageNum:num];
}

- (void)seckillMenuSelectPageAdd {
    [self newPageNumToSelfPageNum:_pageNumber + 1];
}

- (void)seckillMenuSelectPageSub {
    [self newPageNumToSelfPageNum:_pageNumber - 1];
}


- (void)newPageNumToSelfPageNum:(NSInteger)newNum {
    
    if(newNum == _pageNumber) {
        return;
    }
    
    //处理判断条件
    if(newNum < _menuListArray.count) {
        _pageNumber = newNum;
        [self changeCollectionViewCellWithNum:_pageNumber];
    }
}

- (void)changeCollectionViewCellWithNum:(NSInteger)num {
    if(num < _menuListArray.count) {
        
        /*
         //可以打开看看哦！
        NSInteger currentPageNumber = _collectionView.contentOffset.x/_cellWidth;
        if(currentPageNumber +1 < num) {
            NSIndexPath * indexPath = [NSIndexPath indexPathForRow:(num-1) inSection:0];
            [_collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
        }
        else {
            NSIndexPath * indexPath = [NSIndexPath indexPathForRow:(num+1) inSection:0];
            [_collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
        }
        */
        
        NSIndexPath * indexPath = [NSIndexPath indexPathForRow:num inSection:0];
        [_collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        
        [_collectionView reloadData];
    }
}

@end
