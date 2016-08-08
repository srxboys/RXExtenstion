//
//  RXGetArea.h
//  RXExtenstion
//
//  Created by srx on 16/8/8.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RXGetArea : NSObject
+ (NSArray *)getAreaArray;
@end


/*
    获取本地地址、网络地址
 
    1、获取网络地址，失败了  用本地地址
    2、网络地址有更新时，会有通知，在此获取下
 */