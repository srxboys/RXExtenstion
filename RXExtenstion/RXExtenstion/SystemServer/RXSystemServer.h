//
//  RXSystemServer.h
//  RXExtenstion
//
//  Created by srx on 16/6/3.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface RXSystemServer : NSObject
//+ (RXSystemServer *)shareRXSystemServer; //定义单例
 DEFINE_SINGLETON_FOR_HEADER(RXSystemServer)

//打开网页、应用
- (void)openURL:(NSString*)urlString;

//打电话呢
- (void)callTelephone:(NSString*)number;

//发邮件
- (void)sendEmailTo:(NSArray*)emailAddresses withSubject:(NSString*)subject andMessageBody:(NSString*)emailBody;

//发短信
- (void)sendMessageTo:(NSArray*)phoneNumbers withMessageBody:(NSString*)messageBody;

// 在appStore打开app
- (void)openAppleStoreProduct;

// app 评论
- (void)openAppleStoreComment;

@end
