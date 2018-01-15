//
//  RXBaseViewController.m
//  RXExtenstion
//
//  Created by srx on 16/5/2.
//  Copyright © 2016年 srxboys. All rights reserved.
//
/*
 https://github.com/srxboys
 
 项目基本框架
 */

#import "RXBaseViewController.h"
#import "RXGetNetStatus.h"


@interface RXBaseViewController ()
{
    UIControl      * _noneNetworkView;
    UIButton       * _networkButton;
    RXGetNetStatus * _netStatusObject;
    
    NSString * _runtime_get_string;
}
@end

@implementation RXBaseViewController
- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //网络状态
    [self AddCheckNetworkEnable];
    
    //无网络、请求接口失败
    [self networkStatusEqualNoneCreateButton];
    
    [self.view addSubview:self.nomalShowLabel];
    
    _runtime_get_string = @"srxboys";
}

#pragma mark - ~~~~~~~~~~~ 实时检测网络状态 ~~~~~~~~~~~~~~~

- (UILabel *)nomalShowLabel {
    if(!_nomalShowLabel) {
        CGRect frame = self.view.bounds;
        frame.size.width -= 40;
        frame.origin.x = 20;
        _nomalShowLabel = [[UILabel alloc] initWithFrame:frame];
        _nomalShowLabel.text = @"请使用Xcode，断点调试+打印控制台,欣赏该页面";
        _nomalShowLabel.numberOfLines = 0;
        _nomalShowLabel.hidden = YES;
    }
    return _nomalShowLabel;
}

//网络状态
- (void)AddCheckNetworkEnable {
    _netStatusObject = [[RXGetNetStatus alloc] initRXGetNetStatusTarget:self action:@selector(setNetStatus)];
    _netWorkStatus = _netStatusObject.netStatus;
    [self networkChange:_netWorkStatus];
}

- (void)checkNetworkEnable {
    [self setNetStatus];
}

- (void)setNetStatus {
    _netWorkStatus = _netStatusObject.netStatus;
    [self networkChange:_netWorkStatus];
}

- (void)networkChange:(NSString *)status {
    
}

#pragma mark - ~~~~~~~~~~~ 无网络状态页面 ~~~~~~~~~~~~~~~
- (void)networkStatusEqualNoneCreateButton {
    
    _noneNetworkView = [[UIControl alloc] initWithFrame:CGRectMake(0, NavHeight, ScreenWidth, ScreenHeight - NavHeight)];
    _noneNetworkView.backgroundColor = GHS_231_231_231_COLOR;
    //    _noneNetworkView.backgroundColor = [UIColor redColor];
    _noneNetworkView.hidden = YES;
    [_noneNetworkView addTarget:self action:@selector(checkButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_noneNetworkView];
    
    _networkButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    CGFloat width = 100;
    CGFloat height = 100;
    CGFloat top = (ScreenHeight - 203)/2.0 - NavHeight;
    _networkButton.frame = CGRectMake((ScreenWidth - width)/2.0, top, width, height);
    [_networkButton setImage:[UIImage imageNamed:@"pic_lostNetwork"] forState:UIControlStateNormal];
    [_networkButton addTarget:self action:@selector(checkButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_noneNetworkView addSubview:_networkButton];
    
    top += 100 + 25;
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, top, ScreenWidth, 16)];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = GHS_666_COLOR;
    label.text = messageNetNull;
    [_noneNetworkView addSubview:label];
    
    top += 16 + 22;
    width = 141;
    height = 40;
    UIButton * reloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    reloadButton.frame = CGRectMake((ScreenWidth - width)/2.0, top, width, height);
    reloadButton.layer.borderColor = UIColorRGB(83, 83, 83).CGColor;
    reloadButton.layer.borderWidth = BorderWidth;
    reloadButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [reloadButton setTitle:@"点我重试" forState:UIControlStateNormal];
    [reloadButton setTitleColor:GHS_666_COLOR forState:UIControlStateNormal];
    [reloadButton addTarget:self action:@selector(checkButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_noneNetworkView addSubview:reloadButton];
    
    
}

- (void)checkButtonClick {
    [self networkReloadDataButtonClick];
}
///刷新数据源---重新请求数据-注意清空分页数据源
- (void)networkReloadDataButtonClick {
#warning mark ~~~~ 根据子类的不同情况，填写请求 方法名 ~~~~~~~~~~~~~~
}

/// 默认从顶部64开始
- (void)showNullNetworkView {
    [self showNullNetworkViewOriginY:NavHeight];
}

/// 自定义 顶部位置显示
- (void)showNullNetworkViewOriginY:(CGFloat)y {
    CGRect rect = CGRectMake(0, y, ScreenWidth, ScreenHeight - y);
    _noneNetworkView.frame = rect;
    _noneNetworkView.hidden = NO;
}

/// 隐藏
- (void)hiddenNullNetworkView {
    _noneNetworkView.hidden = YES;
}











- (void)showToast:(NSString *)message {
    [self showToast:message ToastPosit:ToastPositCenter];
}
///提示框--文字
-(void)showToast:(NSString *)message ToastPosit:(ToastPosit)toastPosit{
    
    NSString * posit = @"CSToastPositionCenter";
    if(toastPosit == ToastPositTop) {
        posit = @"CSToastPositionTop";
    }
    else if(toastPosit == ToastPositBottom){
        posit = @"CSToastPositionBottom";
    }
    [self.view makeToast:message duration:2.0 position:posit];
}

- (void)showToast:(NSString *)message originY:(CGFloat)originY {
    
    CGPoint point = CGPointMake(self.view.bounds.size.width / 2, originY);
    //NSValue
    NSValue *value = [NSValue valueWithCGPoint:point];
    
    [self.view makeToast:message duration:2.0 position:value];
}





-(BOOL)shouldAutorotate
{
    return YES;
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}
@end
