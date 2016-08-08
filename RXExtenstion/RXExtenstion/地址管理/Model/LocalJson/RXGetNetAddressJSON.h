//
//  RXGetNetAddressJSON.h
//  RXExtenstion
//
//  Created by srx on 16/8/8.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//
//下载地址

#import <UIKit/UIKit.h>

@interface RXGetNetAddressJSON : NSObject
+ (void)getNetWorkAddress;
+ (void)getNetWorkAddressAndCompletion:(void (^)(BOOL finished))completion __deprecated_msg("还有实现");
@end


/*
    每次启动app 都会 请求地址更新接口
 
    1、vode 验证码
        1)第一次传 0
        2)下载失败、没有返回地址 不变
        3）访问接口成功，并返回地址，更新 vode
 
    2、更新后，发个通知，告诉正在用的【地址管理】界面，更新下
 
 */