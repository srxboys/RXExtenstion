//
//  RXMineCreateDateController.m
//  RXExtenstion
//
//  Created by srx on 16/8/31.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import "RXMineCreateDateController.h"

#import "RXNomalDatePicker.h"

#import "RXDatePicker.h"

#import "RXDateTimePicker.h"


@interface RXMineCreateDateController ()
{
    RXNomalDatePicker * _nomalDatePicker;
    
    RXDatePicker      * _datePicker;
    
    RXDateTimePicker  * _dateTimePicker;
    
    UIDatePickerMode    _pickerModel;
}

@property (weak, nonatomic) IBOutlet UILabel *resultLabel;


@property (weak, nonatomic) IBOutlet UISwitch *timeSwitch;
- (IBAction)timeSwithAction:(id)sender;

@property (weak, nonatomic) IBOutlet UISwitch *dateSwitch;
- (IBAction)dateSwithAction:(id)sender;

@property (weak, nonatomic) IBOutlet UISwitch *dateTimeSwitch;
- (IBAction)dateTimeSwithAction:(id)sender;

@property (weak, nonatomic) IBOutlet UISwitch *dateTimeDownSwitch;
- (IBAction)dateTimeDownSwithAction:(id)sender;

- (IBAction)sysPickerShowButtonClick:(id)sender;
- (IBAction)sysCustomPickerShowButtonClick:(id)sender;
- (IBAction)CustomDTPickerShowButtonClick:(id)sender;

@end

@implementation RXMineCreateDateController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"日期、时间 选择 样式";
    
    weak(weakSelf);
    
    _nomalDatePicker  = [[RXNomalDatePicker alloc] init];
    _nomalDatePicker.isShow = ^(BOOL isShow, NSDate * date) {
        RXLog(@"%d %@", isShow, date);
        weakSelf.resultLabel.text = [NSString stringWithFormat:@"%@", date];
    };
    
    _datePicker = [[RXDatePicker alloc] init];
    _datePicker.isShow = ^(BOOL isShow, NSDate * date) {
        RXLog(@"%d %@", isShow, date);
        weakSelf.resultLabel.text = [NSString stringWithFormat:@"%@", date];
    };
    
    _dateTimePicker = [[RXDateTimePicker alloc] init];
    _dateTimePicker.pickerComple = ^(BOOL isShow, NSString * dateString) {
        RXLog(@"%d %@", isShow, dateString);
        weakSelf.resultLabel.text = dateString;
    };
    
    
    [self.view addSubview:_nomalDatePicker];
    [self.view addSubview:_datePicker];
    [self.view addSubview:_dateTimePicker];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)switchOnOffIndex:(NSInteger)index {
    _timeSwitch.on = index == 1 ? YES : NO;
    _dateSwitch.on = index == 2 ? YES : NO;
    _dateTimeSwitch.on = index == 3 ? YES : NO;
    _dateTimeDownSwitch.on = index == 4 ? YES : NO;
}

- (void)nomalSysPickerChangeModel {
    _nomalDatePicker.model = _pickerModel;
}

- (IBAction)timeSwithAction:(id)sender {
    [self switchOnOffIndex:1];
    _pickerModel = UIDatePickerModeTime;
    [self nomalSysPickerChangeModel];
}

- (IBAction)dateSwithAction:(id)sender {
    [self switchOnOffIndex:2];
    _pickerModel = UIDatePickerModeDate;
    [self nomalSysPickerChangeModel];
}

- (IBAction)dateTimeSwithAction:(id)sender {
    [self switchOnOffIndex:3];
    _pickerModel = UIDatePickerModeDateAndTime;
    [self nomalSysPickerChangeModel];
}

- (IBAction)dateTimeDownSwithAction:(id)sender {
    [self switchOnOffIndex:4];
    _pickerModel = UIDatePickerModeCountDownTimer;
    [self nomalSysPickerChangeModel];
}


- (IBAction)sysPickerShowButtonClick:(id)sender {
    [_nomalDatePicker show:NO];
}

- (IBAction)sysCustomPickerShowButtonClick:(id)sender {
    [_datePicker show:NO];
}

- (IBAction)CustomDTPickerShowButtonClick:(id)sender {
    [_dateTimePicker showDatePickerView];
}
@end
