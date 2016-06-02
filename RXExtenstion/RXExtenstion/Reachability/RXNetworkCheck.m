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
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
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
