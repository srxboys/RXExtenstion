//
//  RXDatePicker.m
//  RXExtenstion
//
//  Created by srx on 16/8/31.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//
// 基本 日期picker 自定义封装(可以在这个基础上封装自己想要的 更多样式)
//2015年 写的，方法、逻辑 处理等等，都不是很好，我不想改了

#import "RXDatePicker.h"

#import "RXNomalDatePicker.h"

#define viewAnimal 0.3

#define ButtonLeft 18

@interface RXDatePicker ()
{
    UIView * _keyBoardView;
    UIDatePicker *_datePicker;
    
    UIView * _backView;
    
    CGRect _viewHiddenFrame;
    CGRect _viewShowFrame;
    
    NSDate* currentSelectDate;
    
    
    BOOL isFist;
    
    UITableView * _tempSuperView;
}
@end


@implementation RXDatePicker

- (instancetype)init {
    return [self initWithFrame:[UIScreen mainScreen].bounds];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        
        _viewHiddenFrame = CGRectMake(0, frame.size.height * 2 , frame.size.width, 216 + 44);
        _viewShowFrame = CGRectMake(0, frame.size.height - 216 - 44, frame.size.width, 216 + 44);
        
        self.backgroundColor = [UIColor clearColor];
        self.hidden = YES;
        
        
        self.layer.masksToBounds = NO;
        
        _backView = [[UIView alloc] initWithFrame:self.bounds];
        _backView.backgroundColor = [UIColor blackColor];
        _backView.alpha = 0.0f;
        _backView.userInteractionEnabled = NO;
        [self addSubview:_backView];
        
        
        [self configPicker];
    }
    return self;
}

- (void)configPicker {
    
    isFist = YES;
    
    _keyBoardView = [[UIView alloc] initWithFrame:_viewHiddenFrame];
    _keyBoardView.backgroundColor = UIColorRGB(238, 238, 238);
    [self addSubview:_keyBoardView];
    
    currentSelectDate = [NSDate date];
    
    UIButton * cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame = CGRectMake(ButtonLeft, 0, _viewHiddenFrame.size.width / 2.0 - ButtonLeft, 44);
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:UIColorRGB(51 , 51 , 51 ) forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    cancelButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    cancelButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [_keyBoardView addSubview:cancelButton];
    
    UIButton * trueButton = [UIButton buttonWithType:UIButtonTypeCustom];
    trueButton.frame = CGRectMake(_viewHiddenFrame.size.width/2.0, 0, _viewHiddenFrame.size.width/2.0 - ButtonLeft, 44);
    [trueButton setTitle:@"确定" forState:UIControlStateNormal];
    [trueButton setTitleColor:UIColorRGB(51 , 51 , 51 ) forState:UIControlStateNormal];
    [trueButton addTarget:self action:@selector(trueButtonClick) forControlEvents:UIControlEventTouchUpInside];
    trueButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    trueButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    trueButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [_keyBoardView addSubview:trueButton];
    
    _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 44, _viewHiddenFrame.size.width, 216)];
    _datePicker.backgroundColor = [UIColor whiteColor];
    [_keyBoardView addSubview:_datePicker];
    
    //设置为中文
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    _datePicker.locale = locale;
    
    //通过setDatePickerMode方法 来设置UIDatePicker的样式
    [_datePicker setDatePickerMode:UIDatePickerModeDate];
    
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [inputFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate* minDate = [inputFormatter dateFromString:@"1899-04-04"];
    
    _datePicker.minimumDate = minDate;
    _datePicker.maximumDate = [NSDate date];
    
    //日历今天，默认也是今天
    [_datePicker setCalendar:[NSCalendar currentCalendar]];
    
    //添加事件
    [_datePicker addTarget:self action:@selector(datePickerDateChanged:) forControlEvents:UIControlEventValueChanged];
    
}


-(void)datePickerDateChanged:(UIDatePicker *)paramDatePicker {
    
    isFist = false;
    
    if ([paramDatePicker isEqual:_datePicker]){
        RXLog(@"Selected date = %@", paramDatePicker.date);
        currentSelectDate = paramDatePicker.date;
        
        //        self.isShow(true, currentSelectDate);
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    //[self trueButtonClick];
    [self hidden];
}

- (void)cancelButtonClick {
    //    self.isShow(false, @"");
    [self hidden];
}

- (void)trueButtonClick {
    
    if(self.isShow) {
        self.isShow(true, currentSelectDate);
    }
    [self hidden];
}

- (void)show:(UITableView *)view {
    _tempSuperView = view;
    self.hidden = NO;
    
    //226 为【出生日期】= y + height
    //    TTLog(@"screenHeight =%.2f", ScreenHeight);
    //在table中 的 top + height
    CGFloat dataHeight = 64 + 226;
    
    CGFloat height = (ScreenHeight - dataHeight) < _viewShowFrame.size.height ? _viewShowFrame.size.height - (ScreenHeight - dataHeight) : 0;
    
    [UIView animateWithDuration:viewAnimal animations:^{
        _backView.alpha = 0.4f;
        _keyBoardView.frame = _viewShowFrame;
        _tempSuperView.contentOffset = CGPointMake(0, height);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)show {
    self.hidden = NO;
    [UIView animateWithDuration:viewAnimal animations:^{
        _backView.alpha = 0.4f;
        _keyBoardView.frame = _viewShowFrame;
    } completion:^(BOOL finished) {
        
    }];
}


- (void)hidden {
    [UIView animateWithDuration:viewAnimal animations:^{
        _backView.alpha = 0;
        _keyBoardView.frame  = _viewHiddenFrame;
        _tempSuperView.contentOffset = CGPointMake(0, 0);
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}


- (void)setBirthdayDate:(NSDate *)birthdayDate {
    _datePicker.date = birthdayDate;
}

@end
