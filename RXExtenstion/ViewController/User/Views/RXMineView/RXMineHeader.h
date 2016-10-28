//
//  RXMineHeader.h
//  RXExtenstion
//
//  Created by srx on 16/5/27.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RXUser;

@protocol RXMineHeaderDelegate <NSObject>

@optional
- (void)mineHeaderClick;
@end


@interface RXMineHeader : UIView
@property (nonatomic, strong) id<RXMineHeaderDelegate>delegate;
- (void)setHeaderData:(RXUser *)userModel;
@end
