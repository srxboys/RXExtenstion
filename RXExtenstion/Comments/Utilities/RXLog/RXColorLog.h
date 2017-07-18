//
//  RXColorLog.h
//  RXExtenstion
//
//  Created by srx on 2016/11/28.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import <Foundation/Foundation.h>

#if DEBUG
#define RXLog(format, ...) RXLogger(NO, format, ##__VA_ARGS__)
#define RXLogError(format, ...) RXLogger(YES, format, ##__VA_ARGS__)

#define RXLogger(__isError,__format,  ...) [RXColorLog printLog:__isError file:__FILE__ line:__LINE__ method:[NSString stringWithFormat:@"%s", __PRETTY_FUNCTION__] content:[NSString stringWithFormat:(__format), ##__VA_ARGS__]]
#else
#define TTLog(...)
#define TTLogError(...)
#endif

@interface RXColorLog : NSObject
+ (void)printLog:(BOOL)isError file:(char *)file line:(int)line method:(NSString *)method content:(NSString *)format;
@end


/*
 // Xcode > 8 的不建议用 颜色
 
 
 //使用
     RXLog(@"...");
     RXLogError(@"...");
 
 //安装Xcode插件
     1、下载安装 XcodeColors 插件。下载地址:https://github.com/robbiehanson/XcodeColors
     2、设置 XcodeColors 参数
         Xcode 菜单栏 Product -> Scheme -> Edit Scheme
         选择 Run -> Arguments
         在 Environment Variables 下面点击 + 号
         Name 填写 XcodeColors，Value 填写 YES
         经过上面设置后，RXLog 会为不同级别的 Log 自动着色。
 
 //根据
 https://github.com/pljhonglu/LewLogger
 http://blog.csdn.net/wang631106979/article/details/52404094
 改写的
 
 //------------------------
 //------------------------
 //------------------------
 //------------------------
 //以前写的
     //#define ALog(format, ...) NSLog((@"\n  **srxboys**-->> %s [L%d] " format), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
 //
 //#ifdef DEBUG
     //#define RXLog(format, ...) ALog(format, ##__VA_ARGS__)
 //#else
     //#define RXLog(...)
 //#endif
 
 */
