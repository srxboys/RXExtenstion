//
//  RXSegmentViewController.h
//  RXExtenstion
//
//  Created by srxboys on 2018/2/6.
//  Copyright © 2018年 https://github.com/srxboys. All rights reserved.
//

#import "RXBaseViewController.h"

@interface RXSegmentBaseViewController : RXBaseViewController

@property(nonatomic, strong) NSArray <UIViewController *>*viewControllers;
@property(nonatomic) NSInteger selectedIndex;

@end





@interface UIViewController (RXSegmentParentViewController)

- (RXSegmentBaseViewController *)rxSegmentParentViewController;

@end


/*
    如果样式上需要自定义  请移步看 RXExtentstion->Segment->..
 */
