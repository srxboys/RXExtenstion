//
//  RXOneLinkageTreeAddress.h
//  RXExtenstion
//
//  Created by srx on 16/8/8.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//
// 1 级 3 动地址

#import <UIKit/UIKit.h>


typedef void(^OnePickerShowOrHidden)(BOOL isShow, NSString *address, NSString * addressCode);

@interface RXOneLinkageTreeAddress : UIView

//block回传
@property (nonatomic, copy) OnePickerShowOrHidden isShow;

//外界 外这传 默认值 【没有实现呢！】
@property (nonatomic, copy) NSString * addressString;

- (void)showAddressView;

@end

/*
 这个是很早写的，好多逻辑可以优化。太懒了我
 */
