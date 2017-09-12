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


/*
  + (NSString *)correspondVersion 这个不建议使用。
 
 就用[self getDeviceVersionInfo]给服务器，
 你只要给出对应的列表。https://github.com/srxboys/iphone-device-name-list
 
 这样以后 apple 出新设备，客户端就不需要打包去适配。后台也是保存这个。
 
 好处>
   1、减少 app 的适配，和丢失率。
   2、后台也不用适配。防止适配出错。
 使用>
   如果iPhone1,1 看不懂，就看你的对照表。这样就好
 
 如果你总结麻烦。我写好了 https://github.com/srxboys/iphone-device-name-list
 如果你有更多 新设备的标识。记得pull request 或者 issues告诉我。
 
  */


//设备型号 iPhone 4、4s、5、5s...
//结果 存储在 UserDefautls沙盒里
+ (void)bundlePhoneVersionCheck;

//监测设备是不是在6s以上，用3D touch
+ (BOOL)boundPhone6sLater;
/*
    这个 具体的判断、或者自己想要真正的严格的判断，就在上面bundlePhoneVersionCheck 里加个条件
 */

@end
