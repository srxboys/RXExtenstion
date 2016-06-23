//
//  RXBundle.h
//  RXExtenstion
//
//  Created by srx on 16/4/29.
//  Copyright © 2016年 srxboys. All rights reserved.
//

#import <Foundation/Foundation.h>

#define bundlePhoneCorrespondVersion @"bundlePhoneCorrespondVersion"

@interface RXBundle : NSObject

//应用标识
+ (NSString *)bundleIdentifier;

//应用名称
+ (NSString *)bundleName;

//应用显示名称
+ (NSString *)bundleDisplayName;

//应用版本号
+ (NSString *)bundleVersion;

//设备型号 iPhone 4、4s、5、5s...
//结果 存储在 UserDefautls沙盒里
+ (void)bundlePhoneVersionCheck;

//监测设备是不是在6s以上，用3D touch
+ (BOOL)boundPhone6sLater;
/*
    这个 具体的判断、或者自己想要真正的严格的判断，就在上面bundlePhoneVersionCheck 里加个条件
 */

@end
