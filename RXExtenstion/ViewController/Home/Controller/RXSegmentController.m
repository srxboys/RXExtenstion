//
//  RXSegmentController.m
//  RXExtenstion
//
//  Created by srxboys on 2018/2/6.
//  Copyright © 2018年 https://github.com/srxboys. All rights reserved.
//

#import "RXSegmentController.h"

@interface RXSegmentController ()

@end

@implementation RXSegmentController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"分段控制器";
    id a = [NSClassFromString(@"RXSearchViewController") new];
    id b = [NSClassFromString(@"RXMenuController") new];
    self.viewControllers = @[a, b];
}


/*
    如果分段控制器的UI 不满足需求，请看(AppStore 搜索`聚鲨环球SCM` `消息`)
 
    RXSegmentView.h    //去掉了SDAutoLayout
    RXSegmentControl.h //项目用了 SDAutoLayout
 */


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
