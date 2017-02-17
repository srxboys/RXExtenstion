//
//  RXWebKitViewController.h
//  RXExtenstion
//
//  Created by srx on 2017/2/17.
//  Copyright © 2017年 https://github.com/srxboys. All rights reserved.
//

#import "RXBaseViewController.h"

@class RXMineModel;
@interface RXWebKitViewController : RXBaseViewController

@property (nonatomic, strong) RXMineModel * model;
@end


/**
 *  WKWebView + js 相互调用
 *  看  https://github.com/srxboys/RXJavaScriptDemo
 */