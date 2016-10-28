//
//  RXNew3DTouchSettingController.m
//  RXExtenstion
//
//  Created by zhouzheng on 16/10/28.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import "RXNew3DTouchSettingController.h"
#import "ZZDragCollectionView.h"
#import "RXDragCell.h"

@interface RXNew3DTouchSettingController ()<ZZDragCollectionViewDataSource, ZZDragCollectionViewDelegate, UICollectionViewDelegateFlowLayout>
{
    ZZDragCollectionView *_zzCollectionView;
    NSArray *_dataArray;
    NSArray *_data;
}

@end

@implementation RXNew3DTouchSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _dataArray = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10"];
    _data = [NSArray arrayWithObject:_dataArray];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(ScreenWidth, 44);
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    _zzCollectionView = [[ZZDragCollectionView alloc] initWithFrame:CGRectMake(0, NavHeight, ScreenWidth, ScreenHeight-NavHeight) collectionViewLayout:flowLayout];
    _zzCollectionView.backgroundColor = [UIColor whiteColor];
    _zzCollectionView.delegate = self;
    _zzCollectionView.dataSource = self;
    [_zzCollectionView registerNib:[UINib nibWithNibName:@"RXDragCell" bundle:nil] forCellWithReuseIdentifier:@"CELL"];
    [self.view addSubview:_zzCollectionView];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CELL_ID = @"CELL";
    RXDragCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELL_ID forIndexPath:indexPath];
    cell.titleLabel.text = _data[indexPath.section][indexPath.item];
    
    return cell;
}

- (NSArray *)dataSourceArrayOfCollectionView:(ZZDragCollectionView *)collectionView {
    return _data;
}

- (void)dragCellCollectionView:(ZZDragCollectionView *)collectionView newDataArrayAfterMove:(NSArray *)newDataArray {
    _data = newDataArray;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
