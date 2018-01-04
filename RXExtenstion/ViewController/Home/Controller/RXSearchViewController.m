//
//  RXSearchViewController.m
//  RXExtenstion
//
//  Created by srx on 16/9/30.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

//搜索
//存代码
#import "RXSearchViewController.h"
#import "RXSearchButtonWidthModel.h"
#import "RXRandom.h"

#import "UICollectionViewLeftAlignedLayout.h"

//header
#import "CollectionReusableViewHot.h"
#import "CollectionReusableViewClass.h"
#import "CollectionReusableViewHistory.h"

//cell
#import "CollectionViewCell.h"

@interface RXSearchViewController ()<UICollectionViewDelegateLeftAlignedLayout, UICollectionViewDataSource>
{
    NSMutableArray * _sourceArray;
    UICollectionViewLeftAlignedLayout * _flowLayout;
    UICollectionView * _collectionView;
}


@end

@implementation RXSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"搜索";
    
    [self configUI];
}

- (void)configUI {
    _flowLayout = [[UICollectionViewLeftAlignedLayout alloc] init];
    _flowLayout.minimumLineSpacing = 10;
    _flowLayout.minimumInteritemSpacing = 10;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 90, ScreenWidth, ScreenHeight - 90) collectionViewLayout:_flowLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [self.view addSubview:_collectionView];
    
    if (@available(iOS 11.0, *)) {
        _collectionView.contentInsetAdjustmentBehavior = NO;
    }
    
    //cell
    [_collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"CollectionViewCell"];
    //热搜 header
    [_collectionView registerNib:[UINib nibWithNibName:@"CollectionReusableViewHot" bundle:nil] forSupplementaryViewOfKind:@"UICollectionElementKindSectionHeader" withReuseIdentifier:@"CollectionReusableViewHot"];
    //分类 header
    [_collectionView registerNib:[UINib nibWithNibName:@"CollectionReusableViewClass" bundle:nil] forSupplementaryViewOfKind:@"UICollectionElementKindSectionHeader" withReuseIdentifier:@"CollectionReusableViewClass"];
    //历史记录 header
    [_collectionView registerNib:[UINib nibWithNibName:@"CollectionReusableViewHistory" bundle:nil] forSupplementaryViewOfKind:@"UICollectionElementKindSectionHeader" withReuseIdentifier:@"CollectionReusableViewHistory"];
    
    _sourceArray = [[NSMutableArray alloc] init];
    
    [self configLocalFalseData];

}

- (void)configLocalFalseData {
    NSInteger count = 3;
    for (NSInteger i = 0; i < count; i ++) {
        NSMutableArray * array = [[NSMutableArray alloc] init];
        for(NSInteger j = 0; j < arc4random() % 200 + 1; j ++) {
            NSString * title = [RXRandom randomChinasWithinCount:8];
            RXSearchButtonWidthModel * model = [[RXSearchButtonWidthModel alloc] init];
            model.title = title;
            [array addObject:model];
        }
        
        [_sourceArray addObject:array];
    }
    
    [_collectionView reloadData];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    NSInteger section = _sourceArray.count;
    RXLog(@"section=%zd", section);
    return section;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger count = ((NSArray *)_sourceArray[section]).count;
    RXLog(@"section=%zd--里的元素有=%zd", section, count);
    return count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellIdentifier = @"CollectionViewCell";
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    CollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    [cell setCellModel:_sourceArray[section][row]];
    cell.contentView.backgroundColor = [RXRandom randomColor];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * reuseIdentifier = nil;
    NSInteger section = indexPath.section;
    
    if([kind isEqualToString:@"UICollectionElementKindSectionHeader"]) {
        
        if(section == 0) {
            reuseIdentifier = @"CollectionReusableViewHot";
            CollectionReusableViewHot * header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
            header.backgroundColor= [UIColor redColor];
            return header;
        }
        else if(section == 1) {
            reuseIdentifier = @"CollectionReusableViewClass";
            CollectionReusableViewClass * header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
            header.backgroundColor= [UIColor blueColor];
            return header;
        }
        else if(section == 2) {
            reuseIdentifier = @"CollectionReusableViewHistory";
            CollectionReusableViewHistory * header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
            header.backgroundColor= [UIColor yellowColor];
            return header;
        }
    }
    return nil;
}

//header 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(ScreenWidth, 30);
}

//点击了某个cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    RXLog(@"\n\n----selected----\nsection=%zd,,row=%zd,,,str=%@",section, row ,_sourceArray[section][row]);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    //当前cell的大小
    RXSearchButtonWidthModel * model = _sourceArray[section][row];
    return CGSizeMake(model.width, 40);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    //当前的section里的 整体cell空间 距离上边的seciont0和下边的section1 的【上左下右】的距离
    return UIEdgeInsetsMake(10, 15, 10, 21);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
