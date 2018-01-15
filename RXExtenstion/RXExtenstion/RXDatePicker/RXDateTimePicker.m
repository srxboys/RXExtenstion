//
//  RXDateTimePicker.m
//  RXExtenstion
//
//  Created by srx on 16/8/31.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//
//@月日+时间 (24小时) 的 DatePicker -- 自定义的样式


#import "RXDateTimePicker.h"
#import "NSDateUtilities.h"


#define LLPICKER_MONTH 1 //几个月  -- 这个是可变的
#define LLPICKER_HOUR 24
#define LLPICKER_MINUTE 60

#define PickerHeight 260
#define PickerSureHeight 43

#define ViewAnimal 0.3

#define NAVIGATION_BAR_COLOR [UIColor colorWithRed:51/255.0 green:204/255.0 blue:204/255.0 alpha:1.0]

#define weekArray @[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"]

@interface RXDateTimePicker ()<UIPickerViewDelegate, UIPickerViewDataSource>
{
    
    UIControl      * _backView;
    UIView         * _animalView;
    
    UIPickerView   * _datePicker;
    CGRect           _viewHiddenFrame;
    CGRect           _viewShowFrame;
    
    NSDate         * _currentSelectDate;
    NSDate         * _tempDate;//缓存，，就是用户滑动操作
    
    NSMutableArray * _dateArray;
    UIButton       * _sureButton;
    
    //选择器 选了哪些
    NSInteger        _componentOne, _componentTwo, _componentThree;
}
@end


@implementation RXDateTimePicker

- (instancetype)init{
    self = [self initWithFrame:CGRectMake(0, 0 , ScreenWidth, ScreenHeight)];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        
        CGFloat width = frame.size.width;
        
        _viewHiddenFrame = CGRectMake(0, PickerHeight + ScreenHeight , width, PickerHeight);
        _viewShowFrame = CGRectMake(0, ScreenHeight - PickerHeight, width, PickerHeight);
        
        self.backgroundColor = [UIColor clearColor];
        self.hidden = YES;
        
        self.layer.masksToBounds = NO;
        
        _backView = [[UIControl alloc] initWithFrame:self.bounds];
        _backView.backgroundColor = [UIColor blackColor];
        _backView.alpha = 0.0f;
        [_backView addTarget:self action:@selector(hiddenDatePickerView) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_backView];
        
        _animalView = [[UIView alloc] initWithFrame:_viewHiddenFrame];
        [self addSubview:_animalView];
        
        [self configUI];
    }
    return self;
}

- (void)configUI {
    
    _datePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, PickerHeight - PickerSureHeight)];
    _datePicker.backgroundColor = [UIColor whiteColor];
    _datePicker.showsSelectionIndicator = YES;
    _datePicker.delegate = self;
    _datePicker.dataSource = self;
    [_animalView addSubview:_datePicker];
    
    _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _sureButton.frame = CGRectMake(0, PickerHeight - PickerSureHeight, ScreenWidth, PickerSureHeight);
    [_sureButton setTitle:@"确定" forState:UIControlStateNormal];
    [_sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_sureButton addTarget:self action:@selector(complePicker) forControlEvents:UIControlEventTouchUpInside];
    _sureButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    _sureButton.backgroundColor = NAVIGATION_BAR_COLOR;
    [_animalView addSubview:_sureButton];
    
    
    //最多一个月
    _dateArray  = [[NSMutableArray alloc] init];
    
    NSDate * nowDate = [NSDate date];
    //当前日期
    _currentSelectDate = nowDate;
    
    [_dateArray addObject:nowDate];
    for(NSInteger i = 1; i < LLPICKER_MONTH * 30; i ++) {
        [_dateArray addObject:[nowDate daysLater:i]];
    }
    
    
    UICollectionView * _collectionView;
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [_collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
    
}

- (void)scrollToPickerWithDate:(NSDate *)date hour:(NSInteger)hour minute:(NSInteger)minute {
    
    _componentOne = [_dateArray indexOfObject:date];
    _componentTwo = hour;
    _componentThree = minute;
    
    //日期
    [_datePicker selectRow:_componentOne inComponent:0 animated:NO];
    //时
    [_datePicker selectRow:_componentTwo inComponent:1 animated:NO];
    //分
    [_datePicker selectRow:_componentThree inComponent:2 animated:NO];
    
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView*)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return _dateArray.count;
    } else if (component == 1) {
        return LLPICKER_HOUR;
    } else {
        return LLPICKER_MINUTE;
    }
}

- (NSString*)pickerView:(UIPickerView*)pickerView titleForRow:(NSInteger)row  forComponent:(NSInteger)component {
    if (component == 0) {
        return [self formateWithDate:_dateArray[row]];
    }
    //    else if (component == 1) {
    //        return [self stringWithRow:row + 1];
    //    }else {
    //        return [self stringWithRow:row + 1];
    //    }
    else {
        return [self stringWithRow:row];
    }
}

//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view {
//    return nil;
//}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return  44;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component  {
    if (component == 0) {
        return ScreenWidth - 140 - 10;
    }
    else{
        return 70;
    }
}

//选择后的结果
- (void)pickerView:(UIPickerView*)pickerView didSelectRow:(NSInteger)row  inComponent:(NSInteger)component {
    
    if (component == 0) {
        _componentOne = row;
    }else if (component == 1) {
        _componentTwo = row;
    }else {
        _componentThree = row;
    }
    
}

- (void)defauleDate:(NSString *)dateString {
    //这里 把 string 变成 NSDate给_currentSelectDate
    //怎么变成_currentSelectDate 看 "NSDateUtilities.h"
}

- (void)complePicker {
    
    NSDate * date = _dateArray[_componentOne];
    NSString * dateString = [NSString stringWithFormat:@"%zd-%zd-%zd %02zd:%02zd %@", date.year, date.month, date.day, _componentTwo, _componentThree, weekArray[date.week]];
    if(_pickerComple) {
        _pickerComple(YES, dateString);
    }
    [self hiddenDatePickerView];
}

- (void)showDatePickerView {
    self.hidden = NO;
    [self scrollToPickerWithDate:_currentSelectDate hour:_currentSelectDate.hour minute:_currentSelectDate.minute];
    
    [UIView animateWithDuration:ViewAnimal animations:^{
        _backView.alpha = 0.4f;
        _animalView.frame = _viewShowFrame;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hiddenDatePickerView {
    [UIView animateWithDuration:ViewAnimal animations:^{
        _backView.alpha = 0;
        _animalView.frame  = _viewHiddenFrame;
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}

- (NSString *)formateWithDate:(NSDate *)date {
    //9月4日 周三 14:12                [2016年]
    //    NSLog(@"星期=%@", weekArray[date.week]);
    
    NSString * component0 = [NSString stringWithFormat:@"%zd月%zd日 %@", date.month, date.day, weekArray[date.weekday]];
    
    if([self compareDate:date]) {
        component0 = @"今天";
    }
    
    return component0;
}

- (NSString *)stringWithRow:(NSInteger)row {
    return [NSString stringWithFormat:@"%02zd", row];
}

- (BOOL)compareDate:(NSDate *)tempDate {
    NSDate * nowDate = [NSDate date];
    return nowDate.year == tempDate.year && nowDate.month == tempDate.month && nowDate.day == tempDate.day;
}

@end
