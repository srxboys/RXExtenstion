//
//  RXCheckNetwork.h
//  test_reachability_2016_6_2
//
//  Created by srx on 16/6/2.
//  Copyright © 2016年 srxboys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RXNetworkCheck : NSObject

+ (RXNetworkCheck *)shareNetworkCheck;

@property (nonatomic, copy, readonly) NSString * statusString;

/**
 * 以单例模型 实时监听网络 --- 发送全局通知
 *
 * 最佳调用是在appDelegate中调用一次，其他界面需要，就接接受通知就好
 */
+ (void)getNetworkStatus;

@end
