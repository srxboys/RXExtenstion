//
//  RXAFNDownload.m
//  RXExtenstion
//
//  Created by srx on 16/7/21.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import "RXAFNDownload.h"
#import "RXCharacter.h"
#import "NSError+RXString.h"
#import "AFNetworking.h"

@interface RXAFNDownload ()
{
    NSURLRequest * _afnRequest;
    NSURLSessionDownloadTask * _downloadTask; //下载任务
    
    NSURL * _url;
    NSData * _resumeData; //记录每次的下载进度的数据
    
    NSString * _savePath;
}
@end

@implementation RXAFNDownload
- (void)downloadWithURL:(NSString *)urlString params:(NSDictionary *)params progressValue:(void (^)(CGFloat))downloadProgressBlock saveFileAndNameInPath:(NSString *)path completionHandler:(void (^)(NSURLResponse *, NSURL *, NSError *))completionHandler {
    
    if(![urlString strBOOL]) {
        completionHandler(_downloadTask.response, _url, [NSError errorObjec:self Desc:@"url错误"]);
    }
    _url = [NSURL URLWithString:urlString];
    
    if(![path strBOOL]) {
        completionHandler(_downloadTask.response, _url, [NSError errorObjec:self Desc:@"path错误"]);
    }
    _savePath = path;
    
    
    NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    //请求
    _afnRequest = [NSURLRequest requestWithURL:_url];
    
    //AFN3.0+基于封住URLSession的句柄
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    _downloadTask = [manager downloadTaskWithRequest:_afnRequest progress:^(NSProgress * _Nonnull downloadProgress) {
        //下载进度
        // @property int64_t totalUnitCount;     需要下载文件的总大小
        // @property int64_t completedUnitCount; 当前已经下载的大小
        
        CGFloat progressValue = 1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount;
        //block 返回 进度值
        downloadProgressBlock(progressValue);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        //写入 文件路径 和 文件名字
        NSString * targetStr = [path stringByAppendingPathComponent:response.suggestedFilename];
        NSURL * targetUrl = [NSURL fileURLWithPath:targetStr];
        return targetUrl;
        
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        //下载完成
        completionHandler(response, filePath, error);
        
    }];
    
    
    [_downloadTask resume];
}
@end
