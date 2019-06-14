//
//  RXUserSwiftViewController.m
//  RXExtenstion
//
//  Created by srx on 2017/9/12.
//  Copyright © 2017年 https://github.com/srxboys. All rights reserved.
//
//
//  OC项目 使用Swift 
//


#import "RXUseSwiftViewController.h"

//下面会把所有Swift所有文件导入【Swift 只有Public Class 的能够被OC调用】
#import "RXExtenstion-Swift.h"

@interface RXUseSwiftViewController ()

@end

@implementation RXUseSwiftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.nomalShowLabel.hidden = NO;
/*
    
//---------------------------------------
    //下面使用 RXLogin.swift
    
    //登录密码 设置加密
    [RXLogin Login:@"uid" :@"password"];
    
    //获取本地 用户信息
    NSDictionary * userDict = [RXLogin getLoginToOC];
    NSLog(@"userDict=%@", userDict);
    
    //移除本地 存储的 用户id和密码
    [RXLogin removeLogin];
    
//---------------------------------------
    //下面使用 RXModel.swift
    NSString * uid = [RXModel dictForKeyString:userDict key:@"name"];
    NSString * password = [RXModel dictForKeyString:userDict key:@"password"];
    NSLog(@"uid=%@====pass=%@", uid, password);
    
    //主要看里面的获取，都是针对各种异常的处理
    
//---------------------------------------
    //下面使用 RXPrintInterface.swift
    printf("\n  下面使用 RXPrintInterface.swift   \n");
    
   RXPrintJSON * printtJson = [[RXPrintJSON alloc] initWithPrintObject:userDict];
    
    //这里有个小小的问题，下次再说吧！
    [printtJson printJSON:userDict];
 */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
