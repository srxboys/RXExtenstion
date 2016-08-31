//
//  RXDateTimePicker.h
//  RXExtenstion
//
//  Created by srx on 16/8/31.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^PickerIsShowDateTime)(BOOL isShow, NSString * dateString);

@interface RXDateTimePicker : UIView

@property (nonatomic, copy) PickerIsShowDateTime pickerComple;
//根据已有的日期 ，，定位 -- 还没有实现
- (void)defauleDate:(NSString *)dateString;

- (void)showDatePickerView;
- (void)hiddenDatePickerView;

@end
