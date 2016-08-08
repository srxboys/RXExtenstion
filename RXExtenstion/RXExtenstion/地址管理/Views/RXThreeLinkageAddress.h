//
//  RXThreeLinkageAddress.h
//  RXExtenstion
//
//  Created by srx on 16/8/8.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//
// 3 级联动地址

#import <UIKIt/UIKit.h>

typedef void(^PickerShowOrHidden)(BOOL isShow, NSString *address, NSString * addressCode);



@interface RXThreeLinkageAddress : UIView

//block回传
@property (nonatomic, copy) PickerShowOrHidden isShow;

//外界 外这传 默认值 【没有实现呢！】
@property (nonatomic, copy) NSString * addressString;

- (void)show;

@end


/*
    这个是很早写的，好多逻辑可以优化。太懒了我
 */