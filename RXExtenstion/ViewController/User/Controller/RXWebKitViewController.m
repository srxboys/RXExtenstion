//
//  RXWebKitViewController.m
//  RXExtenstion
//
//  Created by srx on 16/8/12.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import "RXWebKitViewController.h"

#import <WebKit/WebKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
/*
    如果你的项目基于 >=iOS7 同时适配webKit，那么:
    Build Settings -> Link Binary With Libraries ->
    WebKit/WebKit (status : Optional) 否在<iOS8的设备 一运行和此程序有关的 就崩溃
 */

//还未整理 ing
typedef void(^JSCompletion)(id object, NSError * error);

////////--------------------------
@interface WeakScriptMessageDelegate : NSObject
@property (nonatomic, weak) id scriptDelegate;
- (instancetype)initWithDelegate:(id)scriptDelegate;
@end
@implementation WeakScriptMessageDelegate
- (instancetype)initWithDelegate:(id)scriptDelegate
{
    self = [super init];
    if (self) {
        _scriptDelegate = scriptDelegate;
    }
    return self;
}
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    [self.scriptDelegate userContentController:userContentController didReceiveScriptMessage:message];
}
@end
////////--------------------------


@interface RXWebKitViewController ()<WKNavigationDelegate, WKUIDelegate>
{
    WKWebView * _webView;
    JSCompletion _jsCompletion;
    JSContext * _jsContext;
}
@end

@implementation RXWebKitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"WXWebView";
    
    // self.navigationController.toolbarHidden = NO;
    
//    self.view.backgroundColor = [UIColorredColor];
    
//    [self configUI];
    
    [self configUIWithJS];
}

/*
iOS8以后，苹果推出了新框架Wekkit，提供了替换UIWebView的组件WKWebView。各种UIWebView的问题没有了，速度更快了，占用内存少了，一句话，WKWebView是App内部加载网页的最佳选择！

先看下 WKWebView的特性：

在性能、稳定性、功能方面有很大提升（最直观的体现就是加载网页是占用的内存，模拟器加载百度与开源中国网站时，WKWebView占用23M，而UIWebView占用85M）；
允许JavaScript的Nitro库加载并使用（UIWebView中限制）；
支持了更多的HTML5特性；
高达60fps的滚动刷新率以及内置手势；
将UIWebViewDelegate与UIWebView重构成了14类与3个协议（查看苹果官方文档）；
然后从以下几个方面说下WKWebView的基本用法：

加载网页
加载的状态回调
新的WKUIDelegate协议
动态加载并运行JS代码
webView 执行JS代码
JS调用App注册过的方法 一、加载网页
加载网页或HTML代码的方式与UIWebView相同，代码示例如下：
*/
- (void)configUI {
    _webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]];
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    [self.view addSubview:_webView];
}

#pragma mark - ~~~~~~~~~~~ 二、加载的状态回调 （WKNavigationDelegate） ~~~~~~~~~~~~~~~
/*
 二、加载的状态回调 （WKNavigationDelegate）
 用来追踪加载过程（页面开始加载、加载完成、加载失败）的方法：
*/

// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    RXLog(@"didStartProvisionalNavigation");
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    RXLog(@"didCommitNavigation");
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    RXLog(@"didFinishNavigation");
    
    [self printWebSouceCode];
    
    _jsContext = [_webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    //定义好JS要调用的方法, share就是调用的share方法名
    [self interceptJSFunction];

}

//拦截js方法
- (void)interceptJSFunction {
    //获取 app变量的share方法
//    weak(weakSelf);
    JSValue * app = [_jsContext objectForKeyedSubscript:@"app"];
    app[@"share"] = ^(id obj){
        RXLog(@"share %@", obj);
    };
    app[@"jumpPage"] = ^(id className, id jsonString) {
        RXLog(@"jumpPage %@=%@", className, jsonString);
    };
    app[@"sendSession"] = ^(id sessionId) {
        NSString *string = [NSString stringWithFormat:@"%@",sessionId];
        RXLog(@"sendSession %@", sessionId);
    };
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation {
    RXLog(@"didFailProvisionalNavigation");
}


//页面跳转的代理方法：
// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
    RXLog(@"didReceiveServerRedirectForProvisionalNavigation=");
}
// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    RXLog(@"decidePolicyForNavigationResponse=");
    decisionHandler(WKNavigationResponsePolicyAllow);
}
// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    RXLog(@"decidePolicyForNavigationAction");
    decisionHandler(WKNavigationActionPolicyAllow);
}

#pragma mark - ~~~~~~~~~~~ 三、新的WKUIDelegate协议 ~~~~~~~~~~~~~~~
/*
 三、新的WKUIDelegate协议
 这个协议主要用于WKWebView处理web界面的三种提示框(警告框、确认框、输入框)，下面是警告框的例子:
*/

/**
 *web界面中有弹出警告框时调用
 *
 *@param webView实现该代理的webview
 *@param message警告框中的内容
 *@param frame主窗口
 *@param completionHandler 警告框消失调用
 */
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(void (^)())completionHandler {
    RXLog(@"runJavaScriptAlertPanelWithMessage message=%@", message);
}


- (void)printWebSouceCode {
    //获取header源码1
    NSString *JsToGetHTMLSource = @"document.getElementsByTagName('html')[0].innerHTML";
    
    
    [_webView evaluateJavaScript:JsToGetHTMLSource completionHandler:^(id _Nullable obj, NSError * _Nullable error) {
        if(!error) {
            RXLog(@"\n%@\n\n",obj);
        }
        else {
            RXLog(@"printWebSouceCode error=%@", error.description);
        }
    }];
}


#pragma mark - ~~~~~~~~~~~ 四、动态加载并运行JS代码 ~~~~~~~~~~~~~~~
//用于在客户端内部加入JS代码，并执行，示例如下：
- (void)configUIWithJS {
    NSString * htmlURL = @"http://11.1.0.140:13080/index.php/wap/act-1.html?uid=56874&ts=1484286933&sign=621F83DA0920579E0FAABE0276507E79&device_id=d41d8cd98f00b204e9800998ecf8427ee6451bb3&app_key=6b44ac452e7dcd81971283f54e116f0a&res_session_id=0091C8ABE93DC31D367F6B9B2A200681&nick_name=18811425575&avatar=http://testec.ghs.net/public/images/bb/33/74/d3291fb81e0410aaed2b62bce7fb85f29b52e29b.jpg&mobile=18811425575&version=2.4.0";
    
    //js代码
    NSString *js = @"var script = document.createElement('script');"
    "%@"
    "script.text = \" var app = {}; app.%@ = function() {};\";"
    //定义myFunction方法
    "document.getElementsByTagName('head')[0].appendChild(script);";
    // 根据JS字符串初始化WKUserScript对象
    WKUserScript *script = [[WKUserScript alloc] initWithSource:js injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    // 根据生成的WKUserScript对象，初始化WKWebViewConfiguration
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    [config.userContentController addUserScript:script];
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, NavHeight, ScreenWidth, ScreenHeight - NavHeight) configuration:config];
    _webView.opaque = NO;
    _webView.backgroundColor = UIColorRGB(227, 227, 227);
    _webView.scrollView.bounces = NO;
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    //本地
//    [_webView loadHTMLString:@""baseURL:nil];
//    [_webView loadFileURL:nil allowingReadAccessToURL:nil];
    //网络
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:htmlURL]]];
    [self.view addSubview:_webView];
}


#pragma mark - ~~~~~~~~~~~  五、webView 执行JS代码 ~~~~~~~~~~~~~~~
//用户调用用JS写过的代码，一般指服务端开发的：

- (void)executeJS {
//javaScriptString是JS方法名，completionHandler是异步回调block
    NSString * javaScriptString = @"js code";
    [_webView evaluateJavaScript:javaScriptString completionHandler:_jsCompletion];
}


#pragma mark - ~~~~~~~~~~~  六、JS调用App注册过的方法 ~~~~~~~~~~~~~~~
//再WKWebView里面注册供JS调用的方法，是通过WKUserContentController类下面的方法：
- (void)addScriptMessageHandler:(id )scriptMessageHandler name:(NSString *)name {
    RXLog(@"addScriptMessageHandler=%@--name=%@",scriptMessageHandler, name);
}
//scriptMessageHandler是代理回调，JS调用name方法后，OC会调用scriptMessageHandler指定的对象。
//JS在调用OC注册方法的时候要用下面的方式：
//window.webkit.messageHandlers..postMessage()
//注意，name(方法名)是放在中间的，messageBody只能是一个对象，如果要传多个值，需要封装成数组，或者字典。整个示例如下：


//OC注册供JS调用的方法
- (void)regiterJS {
    [[_webView configuration].userContentController addScriptMessageHandler:self name:@"closeMe"];
}
//OC在JS调用方法做的处理
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    RXLog(@"JS 调用了 %@ 方法，传回参数 %@",message.name,message.body);
}
//JS调用
   // window.webkit.messageHandlers.closeMe.postMessage(null);
//如果你在self的dealloc打个断点，会发现self没有释放！这显然是不行的！谷歌后看到一种解决方法，如下：





//思路是另外创建一个代理对象，然后通过代理对象回调指定的self，

- (void)aa {
WKUserContentController *userContentController = [[WKUserContentController alloc] init];
[userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"closeMe"];
}
//运行代码，self释放了，WeakScriptMessageDelegate却没有释放啊啊啊！ 还需在self的dealloc里面 添加这样一句代码：
- (void)dealloc {
    [[_webView configuration].userContentController removeScriptMessageHandlerForName:@"closeMe"];
}



//OK，圆满解决问题！


//目前，大多数App需要支持iOS7以上的版本，而WKWebView只在iOS8后才能用，所以需要一个兼容性方案，既iOS7下用UIWebView，iOS8后用WKWebView。这个库提供了这种兼容性方案：https://github.com/wangyangcc/IMYWebView



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end


