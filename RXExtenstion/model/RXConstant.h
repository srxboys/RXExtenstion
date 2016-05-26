
//
//  RXConstant.h
//  RXExtenstion
//
//  Created by srx on 16/5/4.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#ifndef RXConstant_h
#define RXConstant_h

/********************** 服务器 *************************/
// 0: 正式环境Dis    1: 测试环境Test   2:开发Dev
#define VERSION     0

#if VERSION == 0
    //正式服务器
    #define SERVER_URL  @"https://github.com/srxboys"

#elif VERSION == 1
    //测试服务器
    #define SERVER_URL  @"https://github.com/srxboys"

#elif VERSION == 2
    //开发服务器
    #define SERVER_URL  @"https://github.com/srxboys"
#endif



#pragma mark----------------- -【- GeTui Notification id -】- ------------------------
//推送
#if VERSION == 0 //正式
    #define kGeTuiAppId       @""
    #define kGeTuiAppKey      @""
    #define KGeTuiAppSecret   @""
#else //测试、开发
    #define kGeTuiAppId       @""
    #define kGeTuiAppKey      @""
    #define KGeTuiAppSecret   @""
#endif

#pragma mark ---通知定义---
/// 实时监听网络 带参数的通知
#define rxGetNetworkStatusNotification @"rxGetNetworkStatusNotification"


#pragma mark --- 接口定义 ---

#endif /* RXConstant_h */
