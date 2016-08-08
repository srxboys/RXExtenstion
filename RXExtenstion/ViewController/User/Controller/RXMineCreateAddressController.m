//
//  RXMineCreateAddressController.m
//  RXExtenstion
//
//  Created by srx on 16/8/8.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import "RXMineCreateAddressController.h"

#import "RXOneLinkageTreeAddress.h"
#import "RXThreeLinkageAddress.h"
#import "RXJDAddressPickerView.h"

#import "AppDelegate.h"

@interface RXMineCreateAddressController ()
{
    RXOneLinkageTreeAddress * _onePicker;
    RXThreeLinkageAddress   * _twoPicker;
    RXJDAddressPickerView   * _threePicker;
}




@end

@implementation RXMineCreateAddressController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configUI];
}

- (void)configUI {
    
    _onePicker = [[RXOneLinkageTreeAddress alloc] init];
    _onePicker.isShow = ^ (BOOL isShow, NSString *address, NSString * addressCode){
        RXLog(@"isShow=%@, address=%@, addressCode=%@", isShow ? @"是" : @"否feq`", address, addressCode);
    };
    
    
    _twoPicker = [[RXThreeLinkageAddress alloc] init];
    _twoPicker.isShow = ^ (BOOL isShow, NSString *address, NSString * addressCode){
        RXLog(@"");
    };
    
    
    _threePicker = [[RXJDAddressPickerView alloc] init];
    _threePicker.completion = ^(NSString *address, NSString * addressCode){
        RXLog(@"");
    };

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
