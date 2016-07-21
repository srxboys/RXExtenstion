//
//  RXAFNDownload.h
//  RXExtenstion
//
//  Created by srx on 16/7/21.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RXAFNDownload : NSObject

/**
 *  <#Description#>
 *
 *  @param urlString             网络地址
 *  @param params                字典 参数
 *  @param downloadProgressBlock 下载进度回调   CGFloat
 *  @param path                  下载的路径回调
 *  @param completionHandler     下载完成回调
 */
- (void)downloadWithURL:(NSString *)urlString
        params:(NSDictionary *)params
        progressValue:(void (^)(CGFloat downloadProgressValue)) downloadProgressBlock
        saveFileAndNameInPath:(NSString *)path completionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler;


@end
