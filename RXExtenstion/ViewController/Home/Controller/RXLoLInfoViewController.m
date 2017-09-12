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

@interface RXLoLInfoViewController ()<
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout,
UIScrollViewDelegate,
RXLOLCollectionDelegate
>
{
    UIView * _topView;
    UICollectionViewFlowLayout * _flowLayout;
    UICollectionView * _collectionView;
    
    NSIndexPath * _lastIndexPath;
    CGFloat _subCellInsetY;
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
    _lastIndexPath = nil;
    _subCellInsetY = -100;
    _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
    _topView.backgroundColor = [UIColor purpleColor];
    
    UILabel * label = [[UILabel alloc] initWithFrame:_topView.bounds];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"srxboys";
    label.textColor = [UIColor whiteColor];
    [_topView addSubview:label];
    [_topView addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.sectionInset = UIEdgeInsetsZero;
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.minimumInteritemSpacing = 0;
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _flowLayout.itemSize = CGSizeMake(ScreenWidth, height);
    
    //如果你当前的页面是 cell ，(YES = 是菜单里面的页面)
    BOOL currentPageIsCell = YES; /** 很重要 开关控制 */
    
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
    
    [_collectionView addSubview:_topView];
    
    if(currentPageIsCell) {
        [scrollView addSubview:_collectionView];
    }
    else {
        [self.view addSubview:_collectionView];
    }
    
    
    //注册cell
    NSString * identifier = [RXLOLCellIdentifier stringByAppendingString:@"0"];
    [_collectionView registerClass:[RXLOLCollectionViewCell class] forCellWithReuseIdentifier:identifier];
    identifier = [RXLOLCellIdentifier stringByAppendingString:@"1"];
    [_collectionView registerClass:[RXLOLCollectionViewCell class] forCellWithReuseIdentifier:identifier];
    
    identifier = [RXLOLCellIdentifier stringByAppendingString:@"2"];
    [_collectionView registerClass:[RXLOLCollectionViewCell class] forCellWithReuseIdentifier:identifier];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    RXLOLCollectionViewCell * cell = [self getCellAtIndexPath:indexPath];
    cell.contentOffsetY = _subCellInsetY;
    return cell;
}

- (void)setCurrentIndexPath:(NSIndexPath *)indexPath {
    if(_lastIndexPath != indexPath) {
        if(indexPath) {
            RXLOLCollectionViewCell * currentCell = (RXLOLCollectionViewCell *)[_collectionView.subviews objectAtIndex:indexPath.item];
            if(currentCell) {
                currentCell.cellGround = CellForeground;
                currentCell.contentOffsetY = _subCellInsetY;
            }
        }
        
        if(_lastIndexPath) {
            RXLOLCollectionViewCell * lastCell = (RXLOLCollectionViewCell *)[_collectionView.subviews objectAtIndex:_lastIndexPath.item];
            if(lastCell) {
                lastCell.cellGround = Cellbackground;
                lastCell.contentOffsetY = _subCellInsetY;
            }
            
            RXLog(@"row=%zd= background, row=%zd= foreground", _lastIndexPath.item, indexPath.item);
        }
        else {
            RXLog(@"row=%zd= foreground", indexPath.item);
        }
        
        _lastIndexPath = indexPath;
    }
    
}

- (void)setCellScrollWithIndexPath:(NSIndexPath *)indexPath isForeground:(BOOL)isForeground {
    if(isForeground) {
        [self setCurrentIndexPath:indexPath];
    }
    else {
        if(indexPath) {
            RXLOLCollectionViewCell * currentCell = (RXLOLCollectionViewCell *)[_collectionView.subviews objectAtIndex:indexPath.item];
            if(currentCell) {
                currentCell.cellGround = Cellbackground;
                currentCell.contentOffsetY = _subCellInsetY;
            }
        }
    }
}

- (RXLOLCollectionViewCell *)getCellAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.item % 3;
    static NSString * identifier = nil;
    identifier = [NSString stringWithFormat:@"%@%zd", RXLOLCellIdentifier,row];
    RXLOLCollectionViewCell * cell = [_collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.cellType = row;
    cell.delegate = self;
    if(!_lastIndexPath) {
        cell.cellGround = CellForeground;
    }
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetX = scrollView.contentOffset.x;
    CGRect frame = _topView.frame;
    frame.origin.x = offsetX;
    _topView.frame = frame;
    
    NSInteger row = offsetX/_collectionView.bounds.size.width;
    NSIndexPath * currentIndexPath = [NSIndexPath indexPathForRow:row inSection:0];
    BOOL isCellEnd = lrintf(offsetX) % lrintf(_collectionView.bounds.size.width) == 0;
    NSLog(@"offsetX=%.2f isCellEnd=%@", offsetX, isCellEnd?@"cell整屏了":@"cell不整屏");
    if(isCellEnd) {
        [self setCurrentIndexPath:currentIndexPath];
    }
    else {
        [self setCellScrollWithIndexPath:currentIndexPath isForeground:NO];
    }
    
}

- (void)RXLOLScrollY:(CGFloat)y {
//    RXLog(@"RXLOLScrollX=%.2f", x);
    _subCellInsetY = y;
    CGRect frame = _topView.frame;
    CGFloat topViewY = -(frame.size.height + y);
    CGFloat top = frame.size.height - 40;
    //RXLog(@"RXLOLScrollY=%.2f  topViewY=%.2f top=%.2f", y, topViewY, top);
    
    if(topViewY >= 0) {
        //置低
        frame.origin.y = 0;
    }
    else if(topViewY <= -top) {
        //置顶
        frame.origin.y = -top;
    }
    else {
        //跟随
        frame.origin.y = topViewY;
    }
    
    _topView.frame = frame;
}

- (void)RXLOLScrollReload {
    return;
    RXLog(@"RXLOLScrollReload");    
    for(NSInteger i = 0; i < _collectionView.subviews.count; i++) {
        UIView * view = _collectionView.subviews[i];
        if([view isKindOfClass:[RXLOLCollectionViewCell class]]) {
            RXLOLCollectionViewCell * customCell = (RXLOLCollectionViewCell *)view;
            if(customCell.frame.origin.x != _collectionView.contentOffset.x) {
                //RXLog(@"customCell=%@", customCell);
                if(customCell.contentOffsetY != _subCellInsetY) {
                    customCell.contentOffsetY = _subCellInsetY;
                }
                customCell.cellGround = Cellbackground;
            }
            else {
                customCell.cellGround = CellForeground;
            }
            
        }
    }
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    // 当 _topView 有多个子控件的处理
    if(object == _topView) {
        for(UIView * view in _topView.subviews) {
            if([view isKindOfClass:[UIView class]] && view) {
                CGRect frame = _topView.frame;
                CGFloat height = frame.size.height;
                CGFloat y = frame.origin.y;
                CGRect labelFrame = view.frame;
                if(y >= 0) {
                    labelFrame.origin.y = 0;
                    labelFrame.size.height = height;
                }
                else if(y >= -(height - 40)){
                    labelFrame.origin.y = -y;
                    labelFrame.size.height = height+y;
                }
                else {
                    labelFrame.origin.y = height - 40;
                    labelFrame.size.height = 40;
                }
            
                view.frame = labelFrame;
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
