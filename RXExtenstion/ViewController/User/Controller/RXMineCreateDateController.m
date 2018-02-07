//
//  RXMineCreateDateController.m
//  RXExtenstion
//
//  Created by srx on 16/8/31.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import "RXMineCreateDateController.h"
#import "NSDateUtilities.h"

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
        //这个时间不是中国的
        RXLog(@"%d %@", isShow, date);
        
        //下面处理时间差
        weakSelf.resultLabel.text = [NSString stringWithFormat:@"%zd-%zd-%zd %2zd %2zd", date.year, date.month, date.day, date.hour, date.minute];
    };
    
    _datePicker = [[RXDatePicker alloc] init];
    _datePicker.isShow = ^(BOOL isShow, NSDate * date) {
        //这个时间不是中国的
        RXLog(@"%d %@", isShow, date);
        
        //下面处理时间差
        weakSelf.resultLabel.text = [NSString stringWithFormat:@"%zd-%zd-%zd %2zd %2zd", date.year, date.month, date.day, date.hour, date.minute];
    };
    
    _dateTimePicker = [[RXDateTimePicker alloc] init];
    _dateTimePicker.pickerComple = ^(BOOL isShow, NSString * dateString) {
        //这个返回的   是中国地区的
        RXLog(@"%d %@", isShow, dateString);
        weakSelf.resultLabel.text = dateString;
    };
    
    
    
    UIButton * gotoDiyPickerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    gotoDiyPickerButton.frame = CGRectMake(20, ScreenHeight - 70, 300, 40);
    gotoDiyPickerButton.backgroundColor = [UIColor purpleColor];
    [gotoDiyPickerButton setTitle:@"Picker DIY 内容是UIView" forState:UIControlStateNormal];
    [gotoDiyPickerButton addTarget:self action:@selector(gotoDiyPikerButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:gotoDiyPickerButton];
    
    
    
    
    [self.view addSubview:_nomalDatePicker];
    [self.view addSubview:_datePicker];
    [self.view addSubview:_dateTimePicker];
}

- (void)gotoDiyPikerButtonClick {
    Class vcClass = NSClassFromString(@"RXMineDIYPickerViewController");
    if(!vcClass) return;
    id vc = [vcClass new];
    if(!vc) return;
    [self.navigationController pushViewController:vc animated:YES];
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
    [_nomalDatePicker show];
}

- (IBAction)sysCustomPickerShowButtonClick:(id)sender {
    [_datePicker show];
}

- (IBAction)CustomDTPickerShowButtonClick:(id)sender {
    [_dateTimePicker showDatePickerView];
}
@end
