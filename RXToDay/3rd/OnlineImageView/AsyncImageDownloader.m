//
//  AsyncImageDownloader.m
//  AImageDownloader
//
//  Created by Jason Lee on 12-3-8.
//  Copyright (c) 2012年 Taobao. All rights reserved.
//

#import "AsyncImageDownloader.h"

static AsyncImageDownloader *sharedDownloader = nil;

@implementation AsyncImageDownloader

@synthesize delegate = _delegate;

- (void)dealloc
{
    [asyncQueue release], asyncQueue = nil;
    //
    [super dealloc];
}

+ (id)sharedImageDownloader
{
    @synchronized(self) {
        if (nil == sharedDownloader) {
            sharedDownloader = [[AsyncImageDownloader alloc] init];
        }
        return sharedDownloader;
    }
}

- (id)init
{
    self = [ super init];
    if (nil == sharedDownloader) {
        asyncQueue = [[NSOperationQueue alloc] init];
        
        cacheQueue = [ImageCacheQueue sharedCache];
        
        sharedDownloader = self;
    }
    return sharedDownloader;
}

- (void)startWithUrl:(NSString *)url delegate:(id<AsyncImageDownloaderDelegate>)aDelegate
{
    NSDictionary *info = [NSDictionary dictionaryWithObjectsAndKeys:aDelegate, @"delegate", url, @"url", nil];
    [asyncQueue addOperation:[[[NSInvocationOperation alloc] 
                               initWithTarget:self selector:@selector(startAsync:) object:info] 
                              autorelease]];
}

- (void)startAsync:(NSDictionary *)info
{
    /* 1. Check memory cache */
    /* 2. Check disk cache */
    /* 3. Download the image */
    
    UIImage *image = nil;
    image = [cacheQueue tryToHitImageWithKey:[info objectForKey:@"url"]];
    
    if (nil != image) {
        id theDelegate = [info objectForKey:@"delegate"];
        if ([theDelegate respondsToSelector:@selector(imageDownloader:didFinishWithImage:)]) {
            [theDelegate imageDownloader:self didFinishWithImage:image];
        }
    } else {
        [self performSelector:@selector(downloadImage:) withObject:info];
    }
}

- (void)downloadImage:(NSDictionary *)info
{
    /* HOWTO: Prevent Downloading the same url many times */
    /* Keep the download task one by one ? */
    
    NSString *url = [info objectForKey:@"url"];
    NSURL *imageUrl = [NSURL URLWithString:url];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
    
    if (image) {
        id theDelegate = [info objectForKey:@"delegate"];
        if ([theDelegate respondsToSelector:@selector(imageDownloader:didFinishWithImage:)]) {
            [theDelegate imageDownloader:self didFinishWithImage:image];
        }
        
        [cacheQueue cacheImage:image withKey:url];
    } else {
#ifdef DEBUG
        NSLog(@"Failed to download : %@\n", url);
#endif
    }
}

@end
