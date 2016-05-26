//
//  RXNetworkCheck.m
//  RXExtenstion
//
//  Created by srx on 16/5/25.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import "RXNetworkCheck.h"

#import "RXConstant.h"

#import "Reachability.h"
#import <SystemConfiguration/SCNetworkReachability.h>


typedef  NS_ENUM(NSInteger, GetNetworksStatus)
{
    GetNetworksStatusNone  = 0,
    GetNetworksStatusWifi  = 1,
    GetNetworksStatusPhone = 2
};



typedef void(^netCheckBlock)(GetNetworksStatus status);



@interface RXNetworkCheck ()
@property (nonatomic, strong) Reachability  * conn;
@property (nonatomic, copy) netCheckBlock sblock;
@end


@implementation RXNetworkCheck
+ (RXNetworkCheck *)shareNetworkCheck {
    static dispatch_once_t onceToken;
    static RXNetworkCheck * _net = nil;
    dispatch_once(&onceToken, ^{
        _net = [[RXNetworkCheck alloc] init];
        [_net addCheckNetWork];
    });
    return _net;
}


- (void)addCheckNetWork {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkNetworkState) name:kReachabilityChangedNotification object:nil];
    self.conn = [Reachability reachabilityForInternetConnection];
    [self.conn startNotifier];
}


//检测网络
-(void)checkNetworkState {
    // 1.检测wifi状态
    Reachability *wifi = [Reachability reachabilityForLocalWiFi];
    
    // 2.检测手机是否能上网络(WIFI\3G\2.5G)
    Reachability *conn = [Reachability reachabilityForInternetConnection];
    
    __weak typeof(self)bself = self;
       
    // 3.判断网络状态
    if ([wifi currentReachabilityStatus] != NotReachable) {
        // 有wifi
//        _sblock(GetNetworksStatusWifi);
        
        [bself postNotification:GetNetworksStatusWifi];
        
    } else if ([conn currentReachabilityStatus] != NotReachable) {
        // 没有使用wifi, 使用手机自带网络进行上网
//        _sblock(GetNetworksStatusPhone);
        
        
        [bself postNotification:GetNetworksStatusPhone];
    } else { // 没有网络
//        _sblock(GetNetworksStatusNone);
        
        [bself postNotification:GetNetworksStatusNone];
    }
}


//发送通知
- (void)postNotification:(GetNetworksStatus)status {
  
    
    if(status == GetNetworksStatusNone) {
        _statusString = RXNetworksStatusNone;
    }
    else if(status == GetNetworksStatusWifi) {
        _statusString = RXNetworksStatusWifi;
    }
    else if(status == GetNetworksStatusPhone){
        _statusString = RXNetworksStatusPhone;
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:rxGetNetworkStatusNotification object:_statusString];
}





+ (void)netWorkcheck:(void (^)(GetNetworksStatus status))finishBlock {
    //已经不建议用了
    [RXNetworkCheck shareNetworkCheck].sblock = ^ (GetNetworksStatus status) {
        finishBlock(status);
    };
    [[RXNetworkCheck shareNetworkCheck] checkNetworkState];
    
}

+ (void)getNetworkStatus {
    [[RXNetworkCheck shareNetworkCheck] checkNetworkState];
}

- (void)dealloc {
    [self.conn stopNotifier];
    
    //因为就一个通知，1 和 2 方法那个都可以
    //1
    //    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
    //2
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}




///不是实时更新网络 只是判断当前状态
+ (BOOL) isAppleNetworkEnable {
    
    BOOL bEnable = NO;
    
    NSString * url = @"www.baidu.com";//也可以是公司的网址
    
    SCNetworkReachabilityRef ref = SCNetworkReachabilityCreateWithName(NULL, [url UTF8String]);
    SCNetworkReachabilityFlags flags;
    
    //bEnable = SCNetworkReachabilityGetFlags(<#SCNetworkReachabilityRef target#>, <#SCNetworkReachabilityFlags *flags#>);
    bEnable = SCNetworkReachabilityGetFlags(ref, &flags);
    
    CFRelease(ref);
    
    if(bEnable) {
        // kSCNetworkReachabilityFlagsReachable：能够连接网络
        // kSCNetworkReachabilityFlagsConnectionRequired：能够连接网络，但是首先得建立连接过程
        // kSCNetworkReachabilityFlagsIsWWAN：判断是否通过蜂窝网覆盖的连接，比如EDGE，GPRS或者目前的3G.主要是区别通过WiFi的连接。
        
        BOOL flagsReachable = ((flags & kSCNetworkFlagsReachable) != 0);
        
        BOOL connectionRequired = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
        
        BOOL nonWiFi = flags & kSCNetworkReachabilityFlagsTransientConnection;
        
        bEnable = ((flagsReachable && !connectionRequired) || nonWiFi) ? YES : NO;
        
        //        BOOL nonWiFi2 = kSCNetworkReachabilityFlagsIsWWAN;
        //        NSLog(@"nonWiFi2 = %d", nonWiFi2);
    }
    
    return bEnable;
}
@end
