//
//  ImageCacheQueue.h
//  AImageDownloader
//
//  Created by Jason Lee on 12-3-9.
//  Copyright (c) 2012年 Taobao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageCacheQueue : NSObject
{
    NSMutableDictionary *memoryCache;
    NSString *diskCachePath;
}

+ (id)sharedCache;

- (UIImage *)tryToHitImageWithKey:(NSString *)key;
- (void)cacheImage:(UIImage *)image withKey:(NSString *)key;
- (void)clearCache;

@end
