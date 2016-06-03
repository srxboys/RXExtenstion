//
//  RXExpansionContractionCell.h
//  RXExtenstion
//
//  Created by srx on 16/6/3.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RXExpansionContractionCellDelegate <NSObject>

@optional
- (void)pansionCCellClick:(NSInteger)row;
@end

@class RXExpanCCellHeightModel;
@interface RXExpansionContractionCell : UITableViewCell

@property (nonatomic, strong) id<RXExpansionContractionCellDelegate>delegate;

- (void)setCellData:(RXExpanCCellHeightModel *)cellModel andRow:(NSInteger)row;

@end
