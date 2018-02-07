//
//  RXTouchIDViewController.m
//  RXExtenstion
//
//  Created by srx on 2017/9/13.
//  Copyright © 2017年 https://github.com/srxboys. All rights reserved.
//

#import "RXTouchIDViewController.h"
#import "RXTouchID.h"

@interface RXTouchIDViewController ()
{
    BOOL _isEnableTouchID;
}
@end

@implementation RXTouchIDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nomalShowLabel.text = @"设备>iOS6s 真机哦😯";
    self.nomalShowLabel.hidden = NO;
    
    [self configUI];
}

- (void)configUI {
    BOOL isEnable = [RXTouchID isEnableTouchID];
    RXLog(@"this Phone 【%@】 use TouchID", isEnable?@"is":@"not");
    
    if(isEnable) {
        [RXTouchID evaluateTouchID:^(BOOL isSucc, NSError *error, NSString *descri) {
            NSString * succTxt = isSucc ? @"获取成功" : @"获取失败";
            RXLog(@"touchID =%@\nerror=%@\ndescri=%@", succTxt,error.description, descri);
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
