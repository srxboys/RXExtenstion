//
//  RXSessionDownload.m
//  RXExtenstion
//
//  Created by srx on 16/7/21.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import "RXSessionDownload.h"
#import "NSDictionary+NSStringUTF8.h"
#import "NSError+RXString.h"

@interface RXSessionDownload ()
{
    NSURLSession * _session;
    NSURLSessionDownloadTask * _downloadTask; //下载任务
    
    NSURL * _url;
    NSData * _resumeData; //记录每次的下载进度的数据
    
    NSString * _savePath;
}
@end

@implementation RXSessionDownload
- (void)downloadWithURL:(NSString *)urlString progressValue:(void (^)(CGFloat))downloadProgressBlock saveFileAndNameInPath:(NSString *)path completionHandler:(void (^)(NSURLResponse *, NSURL *, NSError *))completionHandler {
    
    downloadProgressBlock(10);
    
    if(urlString.length <= 0) {
        completionHandler(_downloadTask.response, _url, [NSError errorObjec:self Desc:@"url错误信息"]);
    }
    _url = [NSURL URLWithString:urlString];
    
    if(path.length <= 0) {
        completionHandler(_downloadTask.response, _url, [NSError errorObjec:self Desc:@"path错误信息"]);
    }
    _savePath = path;
    
    
}

-(void)downloadWithURL:(NSString *)urlString params:(NSDictionary *)params progressValue:(void (^)(CGFloat))downloadProgressBlock saveFileAndNameInPath:(NSString *)path completionHandler:(void (^)(NSURLResponse *, NSURL *, NSError *))completionHandler {
    
}

@end
