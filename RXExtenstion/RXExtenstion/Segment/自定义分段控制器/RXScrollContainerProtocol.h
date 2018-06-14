//
//  RXScrollContainerProtocol.h
//  RXExtenstion
//
//  Created by srxboys on 2018/3/22.
//  Copyright © 2018年 https://github.com/srxboys. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RXScrollContainerProtocol <NSObject>
@optional

- (void)scp_contentScrollViewDidScroll:(UIScrollView *)scrollView;

@property (nonatomic, copy, readonly) void(^scp_selectIndex)(NSInteger index, BOOL animated);
@end
