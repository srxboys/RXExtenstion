//
//  RXNomalDataPicker.h
//  RXExtenstion
//
//  Created by srx on 16/8/31.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PickerIsShowDate)(BOOL isShow, NSDate * date);

@interface RXNomalDatePicker : UIView


@property (nonatomic, assign) UIDatePickerMode model;

//外面调用【block 回传值】
@property (nonatomic, copy) PickerIsShowDate isShow;

//外界 往这里传个默认 日期
@property (nonatomic, copy)NSDate * defaultDate;

//显示、隐藏
- (void)show:(UITableView *)view; //【这个实现，要看看里面的注释】

- (void)show;
- (void)hidden;

@end
