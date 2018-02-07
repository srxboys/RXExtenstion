//
//  RXBaseViewController.h
//  RXExtenstion
//
//  Created by srx on 16/5/2.
//  Copyright © 2016年 srxboys. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RXConstant.h"
#import "UIView+Toast.h"

///弱引用
#define weak(weakSelf)  __weak __typeof(&*self)weakSelf = self;
/*
 用法如下：
 weak(weakself);
 
 [self.tableView addHeaderWithCallback:^{
 [weakself requestMemberList];
 }];
 */


typedef NS_ENUM(NSInteger, ToastPosit){
    ToastPositTop,
    ToastPositCenter,
    ToastPositBottom
};

@interface RXBaseViewController : UIViewController

@property (nonatomic, copy) UILabel * nomalShowLabel;

@property (nonatomic, assign) BOOL showSegmentToNavHidden;
@property (nonatomic, assign, readonly) CGFloat navigationHeight;

/// 显示没有网络状态  默认从顶部64开始
- (void)showNullNetworkView;
/// 显示没有网络状态  自定义 顶部位置显示
- (void)showNullNetworkViewOriginY:(CGFloat)y;
/// 隐藏没有网络状态
- (void)hiddenNullNetworkView;

/// 刷新数据源---重新请求数据-注意清空分页数据源
- (void)networkReloadDataButtonClick;

///网络状态
- (void)checkNetworkEnable;
@property (nonatomic, assign, readonly) NSString * netWorkStatus;
- (void)networkChange:(NSString *)status;


/// 显示 toast 【垂直居中显示】
- (void)showToast:(NSString *)message;
/// 显示 toast 位置 上 、 中 、下
- (void)showToast:(NSString *)message ToastPosit:(ToastPosit)toastPosit;
/// 显示 toast 自定义位置
- (void)showToast:(NSString *)message originY:(CGFloat)originY;

@end
