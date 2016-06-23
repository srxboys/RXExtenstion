//
//  RXBundle.m
//  RXExtenstion
//
//  Created by srx on 16/4/29.
//  Copyright © 2016年 srxboys. All rights reserved.
//

#import "RXBundle.h"
#import <sys/utsname.h>


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








#pragma mark - ~~~~~~~~~~~ 设备硬件 4 4s 5 5c ... ~~~~~~~~~~~~~~~
+ (NSString *)getDeviceVersionInfo
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithFormat:@"%s", systemInfo.machine];
    
    //    //返回  iPhone iPod iPad
    //    NSString *deviceType = [[UIDevice currentDevice] model];
    
    return platform;
}

+ (NSString *)correspondVersion {
    
    NSString *correspondVersion = [self getDeviceVersionInfo];
    
    if ([correspondVersion isEqualToString:@"i386"])        return@"Simulator";
    if ([correspondVersion isEqualToString:@"x86_64"])
        return @"Simulator";
    if ([correspondVersion isEqualToString:@"iPhone1,1"])   return@"iPhone 1";
    if ([correspondVersion isEqualToString:@"iPhone1,2"])   return@"iPhone 3";
    if ([correspondVersion isEqualToString:@"iPhone2,1"])   return@"iPhone 3S";
    if ([correspondVersion isEqualToString:@"iPhone3,1"] || [correspondVersion isEqualToString:@"iPhone3,2"])       return@"iPhone 4";
    if ([correspondVersion isEqualToString:@"iPhone4,1"])   return@"iPhone 4S";
    if ([correspondVersion isEqualToString:@"iPhone5,1"] || [correspondVersion isEqualToString:@"iPhone5,2"])
        return @"iPhone 5";
    if ([correspondVersion isEqualToString:@"iPhone5,3"] || [correspondVersion isEqualToString:@"iPhone5,4"])
        return @"iPhone 5C";
    if ([correspondVersion isEqualToString:@"iPhone6,1"] || [correspondVersion isEqualToString:@"iPhone6,2"])
        return @"iPhone 5S";
    if ([correspondVersion isEqualToString:@"iPhone7,1"])
        return @"iPhone 6";
    if ([correspondVersion isEqualToString:@"iPhone7,2"])
        return @"iPhone 6 plus";
    if ([correspondVersion isEqualToString:@"iPhone8,1"])
        return @"iPhone 6s";
    if ([correspondVersion isEqualToString:@"iPhone8,2"])
        return @"iPhone 6s plus";
    
    if ([correspondVersion isEqualToString:@"iPod1,1"])
        return@"iPod Touch 1";
    if ([correspondVersion isEqualToString:@"iPod2,1"])
        return@"iPod Touch 2";
    if ([correspondVersion isEqualToString:@"iPod3,1"])
        return@"iPod Touch 3";
    if ([correspondVersion isEqualToString:@"iPod4,1"])
        return@"iPod Touch 4";
    if ([correspondVersion isEqualToString:@"iPod5,1"])
        return@"iPod Touch 5";
    
    if ([correspondVersion isEqualToString:@"iPad1,1"])
        return@"iPad 1";
    if ([correspondVersion isEqualToString:@"iPad2,1"] || [correspondVersion isEqualToString:@"iPad2,2"] || [correspondVersion isEqualToString:@"iPad2,3"] || [correspondVersion isEqualToString:@"iPad2,4"])
        return@"iPad 2";
    if ([correspondVersion isEqualToString:@"iPad2,5"] || [correspondVersion isEqualToString:@"iPad2,6"] || [correspondVersion isEqualToString:@"iPad2,7"] )
        return @"iPad Mini";
    if ([correspondVersion isEqualToString:@"iPad3,1"] || [correspondVersion isEqualToString:@"iPad3,2"] || [correspondVersion isEqualToString:@"iPad3,3"] || [correspondVersion isEqualToString:@"iPad3,4"] || [correspondVersion isEqualToString:@"iPad3,5"] || [correspondVersion isEqualToString:@"iPad3,6"])
        return @"iPad 3";
    
//    NSLog(@"您的设备类型是：%@",correspondVersion);
    //返回  iPhone iPod iPad
    return correspondVersion;
}

+ (void)bundlePhoneVersionCheck {
    
    [UserDefaults setObject:[self correspondVersion] forKey:bundlePhoneCorrespondVersion];
    [UserDefaults synchronize];
}


+ (BOOL)boundPhone6sLater {
    NSString * phoneVision = [UserDefaults objectForKey:bundlePhoneCorrespondVersion];
    if(phoneVision.length <= 0) {
        return NO;
    }
    
    NSArray * array = [phoneVision componentsSeparatedByString:@" "];
    if(array.count <= 1) {
        return NO;
    }
    
    NSString * currentPhone = array[1];
    if([currentPhone compare:@"6s" options:NSNumericSearch] == NSOrderedDescending) {
        //为了 7 7s 7plus 准备
        return YES;
    }
    return NO;
}

@end
