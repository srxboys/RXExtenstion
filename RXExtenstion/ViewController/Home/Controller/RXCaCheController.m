//
//  RXCaCheController.m
//  RXExtenstion
//
//  Created by srx on 16/5/5.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import "RXCaCheController.h"
#import "RXAFNS.h"

///字符处理 、数组、 字典 -> 空处理
#import "RXCharacter.h"

@implementation RXCaCheController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString * string = @"https://github.com/srxboys";
    
    if([string strBOOL]) {
        //是否为字符串
    }
    
    if([string urlBOOL]) {
        //是否为 网址
    }
    
    if([string arrBOOL]) {
        //是否为 数组
    }
    
    string = @"0"; // or --> string = @"<null>"
    NSString * dictValue = [string strNotEmptyValue];
    RXLog(@"dictValue=%@", dictValue);

}

@end
