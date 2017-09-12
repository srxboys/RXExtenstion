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

typedef NS_ENUM(NSInteger, MenuLocation) {
    menuLocation_bottom = 0,
    menuLocation_top = 1,
    menuLocation_mind = 2,
    menuLocation_other = 3
};

@interface RXLOLCollectionViewCell ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>
{
    UITableView * _tableView;
    CGFloat _insetTop;
   
    //以下用于扩展
    MenuLocation _outsideLocation;
    MenuLocation _insideLocation;
    
    CGFloat _lastOffsetY;
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
//    return arc4random() % 20 + 5;
    return arc4random() % 20 + 6;
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


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;

    /*
     //扩展项
     
     BOOL NoReturnOffset = NO;
     
    if(offsetY == -100) {
        //置低
        _insideLocation = menuLocation_bottom;
    }
    else if(offsetY== -40) {
        //置顶
        _insideLocation = menuLocation_top;
    }
    else if(offsetY> -100 && offsetY < -40){
        //也是置顶
        _insideLocation = menuLocation_mind;
    }
    else  {
        _insideLocation = menuLocation_other;
    }
    
    RXLog(@"_outsideLocation=%zd   _insideLocation=%zd" , _outsideLocation, _insideLocation);
    
    if(_outsideLocation == menuLocation_bottom) {
        if(_insideLocation != menuLocation_other) {
            NoReturnOffset = YES;
        }
    }
    else if(_outsideLocation == menuLocation_top){
        if(_insideLocation != menuLocation_other) {
            NoReturnOffset = YES;
        }
    }
    else if(_outsideLocation == menuLocation_mind) {
        if(_insideLocation == menuLocation_mind) {
            if(_lastOffsetY > offsetY) {
                if(_contentOffsetY>=offsetY) {
                    NoReturnOffset = YES;
                }
            }
            else {
                if(_contentOffsetY<=offsetY) {
                    NoReturnOffset = YES;
                }
            }
        }
    }
    _lastOffsetY = offsetY;
     */
    
    if(_cellGround == Cellbackground) return;
    
    //扩展项
//    if(!NoReturnOffset) return;
    
    if([_delegate respondsToSelector:@selector(RXLOLScrollY:)]) {
        [_delegate RXLOLScrollY:offsetY];
    }
    //取消 延迟执行方法
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(letSuperCollectionViewReload) object:nil];
    
    //定义 延迟执行方法
    [self performSelector:@selector(letSuperCollectionViewReload) withObject:nil afterDelay:0.1];
}

- (void)letSuperCollectionViewReload {
    if([_delegate respondsToSelector:@selector(RXLOLScrollReload)]) {
        [_delegate RXLOLScrollReload];
    }
}

- (void)setContentOffsetY:(CGFloat)contentOffsetY {
    _contentOffsetY = contentOffsetY;
    RXLog(@"cell contentOffsetY=%.2f ----_contentOffsetY=%.2f cellground=%@", contentOffsetY, _contentOffsetY, _cellGround == 0? @"背景":@"前景");
    CGPoint point =  _tableView.contentOffset;

    _outsideLocation = menuLocation_other;
    if(contentOffsetY <= -100) {
        //置低
        _outsideLocation = menuLocation_bottom;
        point.y = -100;
    }
    else if(contentOffsetY >= -40) {
        //置顶
        point.y = -40;
        _outsideLocation = menuLocation_top;
    }
    else {
        //跟随
    }

    _tableView.contentOffset = point;
}

@end
