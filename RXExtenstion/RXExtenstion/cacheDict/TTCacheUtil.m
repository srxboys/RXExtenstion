//
//  TTCacheUtil.m
//  EBCCard
//
//  Created by guligei on 2/17/13.
//  Copyright (c) 2013 totemtec.com. All rights reserved.
//

#import "TTCacheUtil.h"

@implementation TTCacheUtil

+ (NSString*)documentDirectory
{
    //for test
//    static NSString *documentPath = @"/Users/majianglin/Desktop";
    
    static NSString *documentPath = nil;
    
    if (documentPath == nil)
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory,   NSUserDomainMask, YES);
        documentPath = [paths objectAtIndex:0];
    }
    
    return documentPath;
}

+ (BOOL)writeObject:(id)object toFile:(NSString*)fileName;
{
    NSString *filePath = [[TTCacheUtil documentDirectory] stringByAppendingPathComponent:fileName];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
    }
    
    NSData *data = nil;
    //-hasPrefix: //检查字符串是否以另一个字符串开头
    //hasSuffix //.......结尾
    if ([fileName hasSuffix:@".json"])
    {
        NSError *error;
        data = [NSJSONSerialization dataWithJSONObject:object options:kNilOptions error:&error];
        if (error)
        {
            NSLog(@"write cache json error: %@", error.localizedDescription);
        }
    }
    else if([fileName hasSuffix:@".plist"])
    {
        data = [NSKeyedArchiver archivedDataWithRootObject:object];
	}
    BOOL success = [data writeToFile:filePath atomically:YES];
    return success;
}


+ (id)objectFromFile:(NSString *)fileName
{
    NSString *filePath = [[TTCacheUtil documentDirectory] stringByAppendingPathComponent:fileName];
    
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
            NSLog(@"read cache json error: %@", error.localizedDescription);
        }
    }
    else if([fileName hasSuffix:@".plist"])
    {   
        object = [NSKeyedUnarchiver unarchiveObjectWithData:data];
	}
    
    return object;
}


+ (void)removeObjectForName:(NSString*)aName
{
    NSString *filePath = [[TTCacheUtil documentDirectory] stringByAppendingPathComponent:aName];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
    }
}

@end
