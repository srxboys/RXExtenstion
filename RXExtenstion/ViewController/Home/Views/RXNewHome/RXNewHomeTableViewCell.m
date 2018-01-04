//
//  RXNewHomeTableViewCell.m
//  RXExtenstion
//
//  Created by srx on 16/5/24.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import "RXNewHomeTableViewCell.h"
#import "RXDataModel.h"
#import "RXCharacter.h"

#import "UIImageView+fadeInFadeOut.h"

@interface RXNewHomeTableViewCell ()<UITableViewDelegate, UITableViewDataSource>
{
    UITableView    * _tableView;
    NSArray        * _dataSourceArr;
    
    CGFloat          _tempSection;
}
@end

@implementation RXNewHomeTableViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"TableCell"];
        [self.contentView addSubview:_tableView];
        
    }
    return self;
}



- (void)setCellDataArr:(NSArray *)array andSection:(NSInteger)section{
    
    _tempSection = section;
    
    if(_dataSourceArr == array || !ArrBool(array)) {
        return;
    }

    
    _dataSourceArr = array;
    
    [_tableView reloadData];
}

#pragma mark - ~~~~~~~~~~~ tableView Delegate DataSource ~~~~~~~~~~~~~~~
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSourceArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellInditifer = @"TableCell";

    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellInditifer];
    cell.textLabel.text = _dataSourceArr[indexPath.row];
    cell.textLabel.textColor = GHS_666_COLOR;
    cell.textLabel.backgroundColor = [UIColor yellowColor];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}


#pragma mark - ~~~~~~~~~~~ scrollViewDelegate ~~~~~~~~~~~~~~~
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //上下滑动，告诉父类，就可以改变了
    CGFloat offsetY = scrollView.contentOffset.y;
    if(offsetY < 0) {
        scrollView.contentOffset = CGPointMake(0, 0);
    }
    else {
        if([self.delegate respondsToSelector:@selector(RXNewHomeTableViewCellScrollView:)]) {
            [self.delegate RXNewHomeTableViewCellScrollView:offsetY];
        }
    }
}
@end
