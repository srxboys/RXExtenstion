//
//  RXColorLog.m
//  RXExtenstion
//
//  Created by srx on 2016/11/28.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import "RXColorLog.h"
#import "RXConstant.h"

#define XCODE_COLORS_ESCAPE @"\033["

#define XCODE_COLORS_RESET_FG  XCODE_COLORS_ESCAPE @"fg;" // Clear any foreground color
#define XCODE_COLORS_RESET_BG  XCODE_COLORS_ESCAPE @"bg;" // Clear any background color
#define XCODE_COLORS_RESET     XCODE_COLORS_ESCAPE @";"   // Clear any foreground or background color

@implementation RXColorLog
+ (void)printLog:(BOOL)isError file:(char *)file line:(int)line method:(NSString *)method content:(NSString *)format {
#ifdef DEBUG
    NSString *filePath = [[NSString stringWithUTF8String:file] lastPathComponent];
    NSString *LogHeader = [NSString stringWithFormat:@"<%@:%d> ",filePath, line];
    
    
    if([self isEnableXcodeColors]) {
        if(isError) {
            NSLog((@"%@ %@ " XCODE_COLORS_ESCAPE @"fg0,0,255;" XCODE_COLORS_ESCAPE @"bg220,0,0;" @"%@" XCODE_COLORS_RESET @"\n\n"),LogHeader, method, format);
        }
        else {
            if(LOG_ENABLE) {
                NSLog((@"%@ %@ " XCODE_COLORS_ESCAPE @"fg209,57,168;" @"%@" XCODE_COLORS_RESET @"\n\n"),LogHeader, method, format);
            }
        }
    }
    else {
        if(isError) {
            NSLog(@"%@ %@ [ERROR❌] %@\n\n", method, method,format);
        }
        else {
            if(LOG_ENABLE) {
                NSLog(@"%@ %@ %@\n\n", method, method,format);
            }
        }
        
    }
#endif
}



+ (BOOL)isEnableXcodeColors{
    //    setenv("XcodeColors", "YES", 0); // Enables XcodeColors (you obviously have to install it too)
    char *xcode_colors = getenv("XcodeColors");
    if (xcode_colors && (strcmp(xcode_colors, "YES") == 0)){
        // XcodeColors is installed and enabled!
        return YES;
    }
    return NO;
}
@end
