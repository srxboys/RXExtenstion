//
//  RXWebViewController.m
//  RXExtenstion
//
//  Created by srx on 16/6/1.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import "RXMineWebViewController.h"
#import "RXDataModel.h"
#import "RXMJHeader.h"

@interface RXMineWebViewController ()<UIWebViewDelegate>
{
    UIWebView  * _webView;
    RXMJHeader * _loadingView;
    
    UIButton   * _safariButton;
}
@end

@implementation RXMineWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configUI];
}

- (void)configUI {
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, NavHeight, ScreenWidth, ScreenHeight - NavHeight)];
    _webView.scrollView.bounces = NO;
    _webView.scalesPageToFit = YES;
    _webView.opaque = NO;
    _webView.delegate = self;
    [self.view addSubview:_webView];
    
    CGFloat height = 40;
    CGFloat top = (ScreenHeight - NavHeight - height)/2.0;
    _loadingView = [[RXMJHeader alloc] initWithFrame:CGRectMake(0, top, ScreenWidth, height)];
    _loadingView.hidden = NO;
    [self.view addSubview:_loadingView];
    [_loadingView animationStart];
    
    _safariButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _safariButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    _safariButton.frame = CGRectMake(0, 0, 100, 40);
    [_safariButton addTarget:self action:@selector(navRightItemClick) forControlEvents:UIControlEventTouchUpInside];
    [_safariButton setTitle:@"浏览器中打开" forState:UIControlStateNormal];
    [_safariButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:_safariButton];
    self.navigationItem.rightBarButtonItem = item;
    
    if(_model != nil) {
        //标题
        self.title = _model.title;
    }
    else {
        //加载失败
    }
    
    if([self.netWorkStatus isEqualToString:RXNetworksStatusNone]) {
        //没有链接网络
    }
    
//    NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//    for (NSHTTPCookie *cookie in [cookieJar cookies]) {
//        NSLog(@"cookie=%@", cookie);
//    }
//    
//    //清楚cookie
//    NSHTTPCookieStorage *cookieJar2 = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//    NSArray *_tmpArray = [NSArray arrayWithArray:[cookieJar2 cookies]];
//    for (id obj in _tmpArray) {
//        [cookieJar deleteCookie:obj];
//    }
//    
//    NSHTTPCookieStorage *cookieJar3 = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//    for (NSHTTPCookie *cookie in [cookieJar3 cookies]) {
//        NSLog(@"cookie=%@", cookie);
//    }
    
}

- (void)navRightItemClick {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_model.webUrl]];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if(_model != nil) {
        //加载web
        NSURL *url = [NSURL URLWithString:_model.webUrl];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [_webView loadRequest:request];
        
        //写在这里，为了，控制要返回上级，但是没返回，而加载的请求还是刚进来的请求
    }
}




//点击处理
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    //常用的下面，会对请求改动
    
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        RXLog(@"UIWebViewNavigationTypeLinkClicked url =%@", request.URL);
    }
    else if(navigationType == UIWebViewNavigationTypeFormSubmitted) {
        RXLog(@"UIWebViewNavigationTypeFormSubmitted url=%@", request.URL);
    }
    else if(navigationType == UIWebViewNavigationTypeOther) {
        RXLog(@"UIWebViewNavigationTypeOther url=%@", request.URL);
    }
    return YES;
}

//一般下面的，我们会用一个view遮挡界面标识请求、界面错误、界面加载动画
- (void)webViewDidStartLoad:(UIWebView *)webView {
    RXLog(@"正在加载");
    [_loadingView animationStart];
    _loadingView.hidden = NO;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    RXLog(@"加载完毕");
    [_loadingView animationStop];
    _loadingView.hidden = YES;
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    RXLog(@"错误的网络地址");
    [_loadingView animationStop];
    _loadingView.hidden = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
