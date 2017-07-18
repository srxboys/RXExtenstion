//
//  RXLOLCollectionViewCell.m
//  RXExtenstion
//
//  Created by srx on 2017/7/18.
//  Copyright © 2017年 https://github.com/srxboys. All rights reserved.
//
// 横向cell

NSString * const RXLOLCellIdentifier = @"RXLOLCollectionViewCell";

#import "RXLOLCollectionViewCell.h"

#import "RXLOLRecordTableViewCell.h"
#import "RXLOLAbilityTableViewCell.h"
#import "RXLOLAssetsTableViewCell.h"

@interface RXLOLCollectionViewCell ()<UITableViewDelegate, UITableViewDataSource>
{
    UITableView * _tableView;
    CGFloat _insetTop;
}
@end

@implementation RXLOLCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _insetTop = 100;
        CGFloat width = frame.size.width;
        CGFloat height = frame.size.height;
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, width, height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 40;
        [self.contentView addSubview:_tableView];
        _tableView.contentInset = UIEdgeInsetsMake(_insetTop, 0, 0, 0);
        [self registerCell];
    }
    return self;
}

- (void)registerCell {
    [_tableView registerClass:[RXLOLRecordTableViewCell class] forCellReuseIdentifier:RXLOLRecordCellIdentifier];
    [_tableView registerClass:[RXLOLAbilityTableViewCell class] forCellReuseIdentifier:RXLOLAbilityCellIdentifier];
    [_tableView registerClass:[RXLOLAssetsTableViewCell class] forCellReuseIdentifier:RXLOLAssetsCellIdentifier];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    if(_cellType == CellTypeRecord) {
        RXLOLRecordTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:RXLOLRecordCellIdentifier];
        cell.row = row;
        return cell;
    }
    else if(_cellType == CellTypeAbility) {
        RXLOLAbilityTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:RXLOLAbilityCellIdentifier];
        cell.row = row;
        return cell;
    }
    else {
        RXLOLAssetsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:RXLOLAssetsCellIdentifier];
        cell.row = row;
        return cell;
    }
}

@end
