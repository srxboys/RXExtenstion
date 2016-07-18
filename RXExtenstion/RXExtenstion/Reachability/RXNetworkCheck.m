//
//  RXCheckNetwork.m
//  test_reachability_2016_6_2
//
//  Created by srx on 16/6/2.
//  Copyright © 2016年 srxboys. All rights reserved.
//

#import "RXNetworkCheck.h"
#import "Reachability.h"

@interface RXNetworkCheck()
@property (nonatomic, strong) Reachability  * conn;
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    self.conn = [Reachability reachabilityForInternetConnection];
    [self.conn startNotifier];
    
    [self updateInterfaceWithReachability:self.conn];
}


//检测网络
- (void) reachabilityChanged:(NSNotification *)note {
    Reachability* curReach = [note object];
    // 断言 判断条件--然后抛出异常，告诉我们
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    
//    关于断言，还需要注意的一点是在Xcode 4.2以后，在release版本中断言是默认关闭的，这是由宏NS_BLOCK_ASSERTIONS来处理的。也就是说，当编译release版本时，所有的断言调用都是无效的。
    //这个是监测 判断条件为假，抛出异常
    //    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    
    if(![curReach isKindOfClass:[Reachability class]]) {
        _statusString = RXNetworksStatusNone;
        [[NSNotificationCenter defaultCenter] postNotificationName:rxGetNetworkStatusNotification object:nil];
        RXLog(@"network=%@=%s", [self class],__FUNCTION__);
        return;
    }
    
    [self updateInterfaceWithReachability:curReach];
}


- (void)updateInterfaceWithReachability:(Reachability *)reachability {
    NetworkStatus netStatus = [reachability currentReachabilityStatus];
    BOOL connectionRequired = [reachability connectionRequired];

    
    if(netStatus == NotReachable) {
        // 没有网络
        _statusString = RXNetworksStatusNone;
        connectionRequired = NO;
    }
    else if(netStatus == ReachableViaWiFi) {
        // 有wifi
        _statusString = RXNetworksStatusWifi;
    }
    else if(netStatus == ReachableViaWWAN) {
        //手机自带网络
        _statusString = RXNetworksStatusPhone;
    }
    
     [[NSNotificationCenter defaultCenter] postNotificationName:rxGetNetworkStatusNotification object:_statusString];
}



+ (void)getNetworkStatus {
    [RXNetworkCheck shareNetworkCheck];
}

- (void)dealloc {
    [self.conn stopNotifier];
    
    //因为就一个通知，1 和 2 方法那个都可以
    //1
    //    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
    //2
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
