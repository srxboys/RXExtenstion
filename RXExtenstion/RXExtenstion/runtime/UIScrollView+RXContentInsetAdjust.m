//
//  UIScrollView+RXContentInsetAdjust.m
//  RXExtenstion
//
//  Created by srxboys on 2018/1/15.
//  Copyright © 2018年 https://github.com/srxboys. All rights reserved.
//

#import "UIScrollView+RXContentInsetAdjust.h"

@implementation UIScrollView (RXContentInsetAdjust)

- (void)willMoveToSuperview:(UIView *)newSuperview {
    
    //以下 针对  >= Xcode9
#ifdef __IPHONE_11_0
    if (@available(iOS 11.0, *)) {
        //针对 WKWebKit 写的GCD（WKWebKit 里面有WKScroll 就崩溃，所以写了线程处理）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            
            //如果这么处理后，所有iPhoneX页面适配，就要自己单独处理了(或者自己二次封装)
//            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        });
    }
    else {
        
    }
#endif
    if([self isKindOfClass:[UITableView class]]) {
        UITableView * selfTable = (UITableView *)self;
        selfTable.estimatedRowHeight = 0;
        selfTable.estimatedSectionFooterHeight = 0;
        selfTable.estimatedSectionHeaderHeight = 0;
    }
}

@end
