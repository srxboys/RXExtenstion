//
//  RX3DCell.m
//  RXExtenstion
//
//  Created by srx on 2016/10/27.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import "RX3DCell.h"

@implementation RX3DCell

- (void)willTransitionToState:(UITableViewCellStateMask)state {
//    NSLog(@"111==%@", NSStringFromCGRect(self.contentView.frame));
//    self.contentView.frame = CGRectMake(0, self.contentView.frame.origin.y, self.contentView.frame.size.width, self.contentView.frame.size.height);
    self.contentView.backgroundColor = [UIColor redColor];
}

- (void)didTransitionToState:(UITableViewCellStateMask)state {
//    NSLog(@"2222--%@", NSStringFromCGRect(self.contentView.frame));
//    self.contentView.frame = CGRectMake(0, self.contentView.frame.origin.y, self.contentView.frame.size.width, self.contentView.frame.size.height);
    self.contentView.backgroundColor = [UIColor clearColor];

}

@end
