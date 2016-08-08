//
//  RXJDTableCell.h
//  RXExtenstion
//
//  Created by srx on 16/8/8.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import <UIKit/UIKit.h>

#define cellHeight 31

@interface RXJDTableCell : UITableViewCell
- (void)setCellTitle:(NSString *)title isSelected:(BOOL)isSelected;
@end

/*
        外部不掉用此文件
 */