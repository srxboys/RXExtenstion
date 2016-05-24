//
//  RXNewHomeTableViewCell.h
//  RXExtenstion
//
//  Created by srx on 16/5/24.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol RXNewHomeTableViewCellDelegate <NSObject>

@optional
- (void)RXNewHomeTableViewCellScrollView:(CGFloat)offsetY;
@end

@interface RXNewHomeTableViewCell : UICollectionViewCell
@property (nonatomic, strong) id<RXNewHomeTableViewCellDelegate>delegate;
//数据源
- (void)setCellDataArr:(NSArray *)array andSection:(NSInteger)section;

@end
