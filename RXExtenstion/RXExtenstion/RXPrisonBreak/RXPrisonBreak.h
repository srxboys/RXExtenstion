//
//  RXPrisonBreak.h
//  RXExtenstion
//
//  Created by srx on 16/6/14.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import <Foundation/Foundation.h>

#define prisonBreakDefault @"prisonBreakDefaultBOOL"

@interface RXPrisonBreak : NSObject
+ (void)prisonBreakCheck;
@end
/*
    判断是否越狱的条件
 
 1. 判定常见的越狱文件
     /Applications/Cydia.app
     /Library/MobileSubstrate/MobileSubstrate.dylib
     /bin/bash
     /usr/sbin/sshd
     /etc/apt
 
 2. 判断cydia的URL scheme
 
 3. 读取系统所有应用的名称
 
 4. 使用stat方法来判定cydia是否存在
 
 5. 读取环境变量
 
 6. 新增路径
     /private/var/lib/apt/
 
 */
