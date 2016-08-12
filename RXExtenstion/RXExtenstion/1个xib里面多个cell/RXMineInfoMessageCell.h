//
//  MineInfoCell.h
//  Test_数组里存cell
//
//  Created by srx on 16/8/9.
//  Copyright © 2016年 srxboys. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RXXibModel;
@class OneXibModel;
@class TwoXibModel;
@interface RXMineInfoMessageCell : UITableViewCell

@property (nonatomic , copy, readonly) RXXibModel * dataModel;

/** oneXib */
- (void)setOneCellModel:(OneXibModel *)model;

/** TwoXib */
- (void)setTwoCellModel:(TwoXibModel *)model;

//--------------------------------------
/** 也可以用一个方法实现不同的赋值 */
- (void)setCellData:(id)modelObject andSection:(NSInteger)section;

@end
