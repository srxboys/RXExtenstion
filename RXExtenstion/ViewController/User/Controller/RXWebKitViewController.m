//
//  RXWebKitViewController.m
//  RXExtenstion
//
//  Created by srx on 16/8/12.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import "RXWebKitViewController.h"

#import <WebKit/WebKit.h>

@interface RXWebKitViewController ()<WKNavigationDelegate, WKUIDelegate>
{
    WKWebView * _webView;
}
@end

@implementation RXWebKitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"WXWebView";
    
    // self.navigationController.toolbarHidden = NO;
    
//    self.view.backgroundColor = [UIColorredColor];
    
    

}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
