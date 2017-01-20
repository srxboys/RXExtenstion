
//
//  RXConstant.h
//  RXExtenstion
//
//  Created by srx on 16/5/4.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#ifndef RXConstant_h
#define RXConstant_h

//-------------------- 是否打印日志 --------------------/
// 0:不打印   1:打印 (和发布没有关系)
#define LOG_ENABLE    1

/********************** 统计、客服、推送配置 ************/
//0:面向开发人员  1:面向用户 (发布市场前请改为1) 个推、客服、
#define SEC_UM_GeTui 0

/********************** 服务器 *************************/
// 0: 正式环境Dis    1: 测试环境Test   2:开发Dev (发布市场前请改为0)
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
/********************** 个推、友盟、七鱼客服配置 *************************/
#if SEC_UM_GeTui == 1
    /// 个推
    #define kGeTuiAppId     @""
    #define kGeTuiAppKey    @""
    #define KGeTuiAppSecret @""

    /// 友盟 统计
    #define UM_Statistics_APPKET  @""

    // Cobb Razor统计
    #define CobbRazor_APPKET    @""
    #define CobbRazor_ServerURL @""

    /// 网易七鱼云 在线客服
    #define QYAppKey        @""
    #define QyAppName       @""

#else

    /*
     * 自己测试的 —— 测试------
     * apple bundule id = 【*****】
     * 个推、七鱼-->账号 *** 密码:**
     */
    #define kGeTuiAppId     @""
    #define kGeTuiAppKey    @""
    #define KGeTuiAppSecret @""

    ///-----友盟测试 统计 —— 测试------
    #define UM_Statistics_APPKET  @""

    // -----Cobb Razor统计 —— 测试------
    #define CobbRazor_APPKET @""
    #define CobbRazor_ServerURL @""

    //-----网易七鱼云 在线客服 —— 测试------
    #define QYAppKey        @""
    #define QyAppName       @""
#endif



/********************** 下载渠道区分 ************************/
//----- 把开发、测试  和 上线的区分 ------
#ifdef DEBUG
    #define AppChannel @"真机测试"
#else
    #ifdef SEC_UM_GeTui
        #define AppChannel @"AppStore"
    #else
        #define AppChannel @"本地服务器下载"
    #endif
#endif


/********************** 沙盒 ******************************/
#pragma mark ---沙盒定义---
#define App_DeviceToken              @"app_deviceToken"
#define App_deviceUDID               @"app_deviceUDID"

/********************** 通知定义 ***************************/
#pragma mark ---通知定义---

#pragma mark --- 缓存定义 ---
///本地 3D touch 数据缓存
#define RXShortcutItemLocalArray  @"shortcutItemLocalArray.json"

#define AddressLocalJson          @"AdressLocalJson.json" //网络请求地址 --缓存
#define AddressVodeDefaults       @"AddressVodeDefaults" //网络地址 验证码 --缓存 沙盒

#pragma mark --- 接口定义 ---



#endif /* RXConstant_h */
