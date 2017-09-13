//
//  RXTouchID.h
//  RXExtenstion
//
//  Created by srx on 2017/9/13.
//  Copyright © 2017年 https://github.com/srxboys. All rights reserved.
//
// 【>= iOS8】&& 【iPhone >= 6s】

#import <Foundation/Foundation.h>

@interface RXTouchID : NSObject
+ (BOOL)isEnableTouchID;
+ (void)evaluateTouchID:(void(^)(BOOL isSucc,NSError * error, NSString * descri))block;
@end


/*
  一、为了兼容低版本，这个是头文件，进行判断，是否调用 framework并提取方法，
 
   ①< iOS9 ,就不去调用 系统的方法直接告诉，不能访问
 
   ②>=iOS ,调用系统的方法，系统返回 能就是能，不能就不能
 
 
  二、为了控制 TouchIDOption的生命周期，这里面控制。 【太简单了，你们自己写吧】
     作用: 例如 touchID 15秒内 免指纹识别
 
 */
