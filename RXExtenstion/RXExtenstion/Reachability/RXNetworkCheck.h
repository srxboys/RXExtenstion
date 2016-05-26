//
//  RXNetworkCheck.h
//  RXExtenstion
//
//  Created by srx on 16/5/25.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RXNetworkCheck : NSObject

@property (nonatomic, copy, readonly) NSString * statusString;

+ (RXNetworkCheck *)shareNetworkCheck;

/**
 * 以单例模型 实时监听网络 --- 发送全局通知
 *
 * 最佳调用是在appDelegate中调用一次，其他界面需要，就接接受通知就好
 */
+ (void)getNetworkStatus;


///不是实时更新网络 只是判断当前状态【有无网络】
+ (BOOL)isAppleNetworkEnable;
@end
