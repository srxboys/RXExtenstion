//
//  RXBaseViewController.h
//  RXExtenstion
//
//  Created by srx on 16/5/2.
//  Copyright © 2016年 srxboys. All rights reserved.
//

#import <UIKit/UIKit.h>

///弱引用
#define weak(weakSelf)  __weak __typeof(&*self)weakSelf = self;
/*
 用法如下：
 weak(weakself);
 
 [self.tableView addHeaderWithCallback:^{
 [weakself requestMemberList];
 }];
 */

//网络状态，区分 WIFI 和非 WIFI
typedef NS_ENUM(NSInteger, NetworkStatused){
    NetworkStatusedNone,
    NetworkStatusedWIFI,
    NetworkStatusedPhone
};

@interface RXBaseViewController : UIViewController

/// 显示没有网络状态  默认从顶部64开始
- (void)showNullNetworkView;
/// 显示没有网络状态  自定义 顶部位置显示
- (void)showNullNetworkViewOriginY:(CGFloat)y;
/// 隐藏没有网络状态
- (void)hiddenNullNetworkView;

/// 刷新数据源---重新请求数据-注意清空分页数据源
- (void)networkReloadDataButtonClick;

///网络状态
@property (nonatomic, assign) NetworkStatused netWorkStatus;

@end
