//
//  RXMineHeader.h
//  RXExtenstion
//
//  Created by srx on 16/5/27.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RXUser;
@interface RXMineHeader : UITableViewHeaderFooterView
- (void)setHeaderData:(RXUser *)userModel;
- (void)changeHeaderFrame:(CGRect)frame;
@end
