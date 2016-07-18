//
//  UIImageView+OnlineImage.h
//  AImageDownloader
//
//  Created by Jason Lee on 12-3-8.
//  Copyright (c) 2012年 Taobao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageDownloader.h"

@interface UIImageView (OnlineImage) <AsyncImageDownloaderDelegate>

- (void)setOnlineImage:(NSString *)url;
- (void)setOnlineImage:(NSString *)url placeholderImage:(UIImage *)image;

@end
