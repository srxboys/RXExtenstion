//
//  UIImageView+OnlineImage.m
//  AImageDownloader
//
//  Created by Jason Lee on 12-3-8.
//  Copyright (c) 2012年 Taobao. All rights reserved.
//

#import "UIImageView+OnlineImage.h"

@implementation UIImageView (OnlineImage)

- (void)setOnlineImage:(NSString *)url
{
    [self setOnlineImage:url placeholderImage:nil];
}

- (void)setOnlineImage:(NSString *)url placeholderImage:(UIImage *)image
{
    self.image = image;
    
    AsyncImageDownloader *downloader = [AsyncImageDownloader sharedImageDownloader];
    [downloader startWithUrl:url delegate:self];
}

#pragma mark -
#pragma mark - AsyncImageDownloader Delegate

- (void)imageDownloader:(AsyncImageDownloader *)downloader didFinishWithImage:(UIImage *)image
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.image = image;
    });
}

@end
