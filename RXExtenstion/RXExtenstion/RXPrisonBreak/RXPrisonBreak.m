//
//  RXPrisonBreak.m
//  RXExtenstion
//
//  Created by srx on 16/6/14.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import "RXPrisonBreak.h"

#import <dlfcn.h>


//1
#define ARRAY_SIZE(a) sizeof(a)/sizeof(a[0])

//3
#define USER_APP_PATH  @"/User/Applications/"

//4
#define CYDIA_APP_PATH  "/Applications/Cydia.app"

@implementation RXPrisonBreak

+ (void)prisonBreakCheck {
    if([self prisonBreak]) {
        //越狱 设备
        [UserDefaults setObject:@"1" forKey:prisonBreakDefault];
    }
    else {
        //没有 越狱
        [UserDefaults setObject:@"0" forKey:prisonBreakDefault];
    }
    [UserDefaults synchronize];
}


+ (BOOL)prisonBreak {
    
    if([self isJailBreakOne]) {
        return YES;
    }
    
    if([self isJailBreakTwo]) {
        return YES;
    }
    
    if([self isJailBreakThree]) {
        return YES;
    }
    
    if([self isJailbroken]) {
        return YES;
    }
    
    return NO;
}

#pragma mark - ~~~~~~~~~~~ 1. 判定常见的越狱文件 ~~~~~~~~~~~~~~~
+ (BOOL)isJailBreakOne {
    NSArray * tool_pathes = @[@"/Applications/Cydia.app",
                              @"/Library/MobileSubstrate/MobileSubstrate.dylib",
                              @"/bin/bash",
                              @"/usr/sbin/sshd",
                              @"/etc/apt"];
    
    
    for(int i=0; i< tool_pathes.count; i++) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:tool_pathes[i]]) {
//            NSLog(@"The device is jail broken!");
            return YES;
        }
    }
//    NSLog(@"The device is NOT jail broken!");
    return NO;
}

#pragma mark - ~~~~~~~~~~~ 2. 判断cydia的URL scheme ~~~~~~~~~~~~~~~

+ (BOOL)isJailBreakTwo {
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"cydia://"]]) {
//        NSLog(@"The device is jail broken!");
        return YES;
    }
//    NSLog(@"The device is NOT jail broken!");
    return NO;
}


#pragma mark - ~~~~~~~~~~~ 3. 读取系统所有应用的名称 ~~~~~~~~~~~~~~~
+ (BOOL)isJailBreakThree {
    if([[NSFileManager defaultManager] fileExistsAtPath:USER_APP_PATH]) {
//        NSLog(@"The device is jail broken!");
        NSArray *applist = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:USER_APP_PATH error:nil];
//        NSLog(@"applist = %@", applist);
        return YES;
    }
    NSLog(@"The device is NOT jail broken!");
    return NO;
}


#pragma mark - ~~~~~~~~~~~ 4. 使用stat方法来判定cydia是否存在 ~~~~~~~~~~~~~~~

//int checkInject()
//{
//    int ret;
//    Dl_info dylib_info;
//    int (*func_stat)(const char*, struct stat*) = stat;
//    
//    if ((ret = dladdr(func_stat, &dylib_info)) && strncmp(dylib_info.dli_fname, dylib_name, strlen(dylib_name))) {
//        return 0;
//    }
//    return 1;
//}
//
//int checkCydia()
//{
//    // first ,check whether library is inject
//    struct stat stat_info;
//    
//    if (!checkInject()) {
//        if (0 == stat(CYDIA_APP_PATH, &stat_info)) {
//            return 1;
//        }
//    } else {
//        return 1;
//    }
//    return 0;
//}
//
//+ (BOOL)isJailBreakFour
//{
//    if (checkCydia()) {
////        NSLog(@"The device is jail broken!");
//        return YES;
//    }
////    NSLog(@"The device is NOT jail broken!");
//    return NO;
//}


#pragma mark - ~~~~~~~~~~~ 5. 读取环境变量 ~~~~~~~~~~~~~~~
//char* printEnv(void)
//{
//    charchar *env = getenv("DYLD_INSERT_LIBRARIES");
//    NSLog(@"%s", env);
//    return env;
//}
//
//+ (BOOL)isJailBreakFive
//{
//    if (printEnv()) {
////        NSLog(@"The device is jail broken!");
//        return YES;
//    }
////    NSLog(@"The device is NOT jail broken!");
//    return NO;
//}


#pragma mark - ~~~~~~~~~~~ 6 ~~~~~~~~~~~~~~~
+ (BOOL)isJailbroken {
    BOOL jailbroken = NO;
    NSString *cydiaPath = @"/Applications/Cydia.app";
    NSString *aptPath = @"/private/var/lib/apt/";
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:cydiaPath]) {
        jailbroken = YES;
    }
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:aptPath]) {
        jailbroken = YES;
    }
    
    return jailbroken;
    
}

@end
