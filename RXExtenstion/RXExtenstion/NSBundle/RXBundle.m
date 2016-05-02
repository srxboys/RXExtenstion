//
//  RXBundle.m
//  RXExtenstion
//
//  Created by srx on 16/4/29.
//  Copyright © 2016年 srxboys. All rights reserved.
//

#import "RXBundle.h"

@implementation RXBundle

+ (NSDictionary *)boundInfoDict {
    return [[NSBundle mainBundle] infoDictionary];
}

+ (NSString *)bundleIdentifier
{
    return [[self boundInfoDict] objectForKey:@"CFBundleIdentifier"];
}

+ (NSString *)bundleName
{
    return [[self boundInfoDict] objectForKey:@"CFBundleName"];
}

+ (NSString *)bundleDisplayName
{
    return [[self boundInfoDict] objectForKey:@"CFBundleDisplayName"];
}

+ (NSString *)bundleVersion
{
    return [[self boundInfoDict] objectForKey:@"CFBundleShortVersionString"];
}

+ (id)objectFromFile:(NSString *)fileName
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
    
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    if (data == nil)
    {
        return nil;
    }
    
    id object = nil;
    
    if ([fileName hasSuffix:@".json"])
    {
        NSError *error;
        object = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        if (error)
        {
            NSLog(@"read json file error: %@", error.localizedDescription);
        }
    }
    else if([fileName hasSuffix:@".plist"])
    {
        NSError *error;
        object = [NSPropertyListSerialization propertyListWithData:data
                                                           options:NSPropertyListImmutable
                                                            format:NULL
                                                             error:&error];
        if (error)
        {
            NSLog(@"read plist file error: %@", error.localizedDescription);
        }
    }
    
    return object;
}
@end
