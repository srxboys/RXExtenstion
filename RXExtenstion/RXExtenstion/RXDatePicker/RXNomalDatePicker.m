//
//  RXNomalDataPicker.m
//  RXExtenstion
//
//  Created by srx on 16/8/31.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

//@年月日的 DatePicker -- 系统默认的样式

#import "RXNomalDatePicker.h"

#define viewAnimal 0.3

#define ButtonLeft 18

@interface RXNomalDatePicker ()
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

@implementation RXNomalDatePicker


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
    if(_model <= 0) {
        _model = UIDatePickerModeTime;
    }
    [_datePicker setDatePickerMode: _model];
    
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

- (void)setModel:(UIDatePickerMode)model {
    _model = model;
    [_datePicker setDatePickerMode: _model];
    [_datePicker reloadInputViews];
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
    
    //    if(isFist) {
    self.isShow(true, currentSelectDate);
    //    }
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
    [_datePicker reloadInputViews];
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
