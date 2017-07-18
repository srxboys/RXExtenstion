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
    /*
     // Xcode < 8 
     
    NSString *filePath = [[NSString stringWithUTF8String:file] lastPathComponent];
    NSString *LogHeader = [NSString stringWithFormat:@": \n   FILE->%@\n   LINE->%d\n   FUNCTION->",filePath, line];
    
    format = [format stringByAppendingString:@"\n\n"];
    
    if([self isEnableXcodeColors]) {
        if(isError) {
            NSLog((@"%@ %@\n" XCODE_COLORS_ESCAPE @"fg255,253,56;" XCODE_COLORS_ESCAPE @"bg0,139,0;" @"%@" XCODE_COLORS_RESET),LogHeader, method, format);
        }
        else {
            if(LOG_ENABLE) {
                NSLog((@"%@ %@\n" XCODE_COLORS_ESCAPE @"fg209,57,168;" @"%@" XCODE_COLORS_RESET),LogHeader, method, format);
            }
        }
    }
    else {
        if(isError) {
            NSLog(@"%@ %@ [ERROR❌] %@", LogHeader, method,format);
        }
        else {
            if(LOG_ENABLE) {
                NSLog(@"%@ %@ %@", LogHeader, method,format);
            }
        }
        
    }
     */
    
    
    // Xcode >= 8 
    NSString *filePath = [[NSString stringWithUTF8String:file] lastPathComponent];
    
    NSString * headerIdentification = @"👇👇👇👇👇👇👇";
    NSString * footerIdentification = @"👉👉👉👉👉👉👉👉👉👉👉👉👉👉";
    if(isError) {
        headerIdentification = @"❌❌❌❌❌❌❌";
        footerIdentification = @"🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺🔺";
    }
    
    NSString *LogHeader = [NSString stringWithFormat:@": %@ \n   Ⓕⓘⓛⓔ ⏩ %@\n   Ⓛⓘⓝⓔ ⏩ %d\n   Ⓕⓤⓝⓒⓣⓘⓞⓝ ⏩",headerIdentification, filePath, line];
    
    format = [NSString stringWithFormat:@"\n%@", format];
    format = [format stringByAppendingString:@"\n\n"];
    format = [format stringByAppendingString:footerIdentification];
    if(isError) {
        NSLog(@"%@ %@ %@\n\n", LogHeader, method,format);
    }
    else {
        if(LOG_ENABLE) {
            NSLog(@"%@ %@ %@\n\n", LogHeader, method,format);
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
