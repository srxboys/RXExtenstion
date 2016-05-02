//
//  RXNetworkCheck.h
//  RXExtenstion
//
//  Created by srx on 16/4/29.
//  Copyright © 2016年 srxboys. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef  NS_ENUM(NSInteger, GetNetworksStatus)
{
    GetNetworksStatusNone,
    GetNetworksStatusWifi,
    GetNetworksStatusPhone
};


@interface RXNetworkCheck : NSObject

///以单例模型 实时监听网络
+ (void)netWorkcheck:(void (^)(GetNetworksStatus status))finishBlock;


///不是实时更新网络 只是判断当前状态【有无网络】
+ (BOOL)isAppleNetworkEnable;

@end
