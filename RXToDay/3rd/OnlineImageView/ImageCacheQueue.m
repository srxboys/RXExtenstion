//
//  ImageCacheQueue.m
//  AImageDownloader
//
//  Created by Jason Lee on 12-3-9.
//  Copyright (c) 2012年 Taobao. All rights reserved.
//

#import "ImageCacheQueue.h"
#import "NSString+MD5.h"

static ImageCacheQueue *sharedCacheQueue = nil;

@implementation ImageCacheQueue

- (void)dealloc
{
    [memoryCache release], memoryCache = nil;
    [diskCachePath release], diskCachePath = nil;
    //
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (nil != sharedCacheQueue) {
        //
    } else {
        memoryCache = [[NSMutableDictionary alloc] init];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        diskCachePath = [[[paths objectAtIndex:0] stringByAppendingPathComponent:@"ImageCache"] retain];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:diskCachePath]) {
            NSError *error = nil;
            [[NSFileManager defaultManager] createDirectoryAtPath:diskCachePath
                                      withIntermediateDirectories:YES
                                                       attributes:nil
                                                            error:&error];
        }
        
        sharedCacheQueue = self;
    }
    return sharedCacheQueue;
}

+ (id)sharedCache
{
    @synchronized (self) {
        if (nil == sharedCacheQueue) {
            sharedCacheQueue = [[ImageCacheQueue alloc] init];
        }
        return sharedCacheQueue;
    }
}

/* Interface for the delegate */
- (UIImage *)tryToHitImageWithKey:(NSString *)key
{
    UIImage *image = nil;
    image = [self performSelector:@selector(getImageFromCacheByKey:) withObject:key];
    return (nil != image) ? image : [self performSelector:@selector(getImageFromDiskByKey:) withObject:key];
}

- (void)cacheImage:(UIImage *)image withKey:(NSString *)key
{
    NSDictionary *info = [NSDictionary dictionaryWithObjectsAndKeys:image, @"image", key, @"key", nil];
    [self performSelector:@selector(cacheImageToMemory:) withObject:info];
    [self performSelector:@selector(cacheImageToDisk:) withObject:info];
}

- (void)clearCache
{
    [self performSelector:@selector(clearMemoryCache)];
    [self performSelector:@selector(clearDiskCache)];
}

/* Real Cache Hitting */
- (UIImage *)getImageFromCacheByKey:(NSDictionary *)key
{
    //return [memoryCache objectForKey:key];
    
    if ([memoryCache objectForKey:key]) {
#ifdef DEBUG
        NSLog(@"%@ was hit in memory cache.\n", key);
#endif 
        return [memoryCache objectForKey:key];
    }
    
    return nil;
}

- (UIImage *)getImageFromDiskByKey:(NSString *)key
{
    NSString *localPath = [diskCachePath stringByAppendingPathComponent:[key MD5]];
    if (![[NSFileManager defaultManager] fileExistsAtPath:localPath]) {
        return nil;
    }
    
    UIImage *image = [[[UIImage alloc] initWithContentsOfFile:localPath] autorelease];
    //return (nil == image) ? nil : image;
    
    if (nil != image) {
#ifdef DEBUG
        NSLog(@"%@ was hit in disk cache.\n", key);
#endif 
        /* Hitting here means missing in memory cache */
        NSDictionary *info = [NSDictionary dictionaryWithObjectsAndKeys:image, @"image", key, @"key", nil];
        [self performSelector:@selector(cacheImageToMemory:) withObject:info];
        
        return image;
    }
    
    return nil;
}

/* Cache The Miss Image */
- (void)cacheImageToMemory:(NSDictionary *)info
{
    /* What size is suitable for memoryCache ? */
    /* FIFO Schedule or LRU ? */
    [memoryCache setObject:[info objectForKey:@"image"] forKey:[info objectForKey:@"key"]];
    
#ifdef DEBUG
    NSLog(@"%@ was cached.\n", [info objectForKey:@"key"]);
#endif
}

- (void)cacheImageToDisk:(NSDictionary *)info
{
    NSString *key = [info objectForKey:@"key"];
    UIImage *image = [info objectForKey:@"image"];
    
    NSString *localPath = [diskCachePath stringByAppendingPathComponent:[key MD5]];
    NSData *localData = UIImageJPEGRepresentation(image, 1.0f);
    
    if ([localData length] <= 1) {
        return ;
    }
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:localPath]) {
        [[NSFileManager defaultManager] createFileAtPath:localPath contents:localData attributes:nil];
    }
    
#ifdef DEBUG
    NSLog(@"%@ was saved to disk %@.\n", key, localPath);
#endif
}

/* Empty The Cache */
- (void)clearMemoryCache
{
    [memoryCache removeAllObjects];
}

- (void)clearDiskCache
{
    NSError *error = nil;
    [[NSFileManager defaultManager] removeItemAtPath:diskCachePath error:&error];
    [[NSFileManager defaultManager] createDirectoryAtPath:diskCachePath
                              withIntermediateDirectories:YES
                                               attributes:nil
                                                    error:&error];
}

@end
