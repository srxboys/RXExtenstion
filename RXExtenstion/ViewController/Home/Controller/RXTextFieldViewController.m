//
//  RXTextFieldViewController.m
//  RXExtenstion
//
//  Created by srxboys on 2018/3/22.
//  Copyright © 2018年 https://github.com/srxboys. All rights reserved.
//

#import "RXTextFieldViewController.h"

#import "RXCurrencyFormatTextField.h"
#import "RXPhoneNumberFormatTextField.h"
#import "RXBankCardFormatTextField.h"

@interface RXTextFieldViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UILabel * moneyLabel;
@property (nonatomic, strong) RXCurrencyFormatTextField * moneyTextField;

@property (nonatomic, strong) UILabel * phoneNumberLabel;
@property (nonatomic, strong) RXPhoneNumberFormatTextField * phoneNumberTextField;

@property (nonatomic, strong) UILabel * bankCardLabel;
@property (nonatomic, strong) RXBankCardFormatTextField * bankCardTextField;

@end

@implementation RXTextFieldViewController

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    CGFloat top = 88;
    CGFloat titleWidth = 150;
    CGFloat textWidth = 160;
    _moneyLabel.frame = CGRectMake(20, top, titleWidth, 40);
    _moneyTextField.frame = CGRectMake(ViewRight(_moneyLabel)+10, top, textWidth, 40);
    
    top += ViewHeight(_moneyLabel) + 10;
    _phoneNumberLabel.frame = CGRectMake(20, top, titleWidth, 40);
    _phoneNumberTextField.frame = CGRectMake(ViewRight(_phoneNumberLabel)+10, top, textWidth, 40);
    
    top += ViewHeight(_phoneNumberLabel) + 10;
    _bankCardLabel.frame = CGRectMake(20, top, titleWidth, 40);
    _bankCardTextField.frame = CGRectMake(ViewRight(_bankCardLabel)+10, top, textWidth, 40);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"TextField定制";
    [self configUI];
}

- (void)configUI {
    NSString * className = NSStringFromClass([RXCurrencyFormatTextField class]);
    _moneyLabel = [self configLabelWithTxt:className];
    _moneyTextField = [RXCurrencyFormatTextField new];
    [self setTextField:_moneyTextField placeholder:className];
    
    className = NSStringFromClass([RXPhoneNumberFormatTextField class]);
    _phoneNumberLabel = [self configLabelWithTxt:className];
    _phoneNumberTextField = [RXPhoneNumberFormatTextField new];
    [self setTextField:_phoneNumberTextField placeholder:className];
    
    className = NSStringFromClass([RXBankCardFormatTextField class]);
    _bankCardLabel = [self configLabelWithTxt:className];
    _bankCardTextField = [RXBankCardFormatTextField new];
    [self setTextField:_bankCardTextField placeholder:className];
    
    
    weak(weakSelf);
    UITapGestureRecognizer *tap = [UITapGestureRecognizer new];
    tap.delegate = weakSelf;
    [self.view addGestureRecognizer:tap];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    [self.view endEditing:YES];
    return NO;
}



- (UILabel *)configLabelWithTxt:(NSString *)txt {
    UILabel * label = [UILabel new];
    label.adjustsFontSizeToFitWidth = YES;
    label.text = txt;
    label.textAlignment = NSTextAlignmentRight;
    label.textColor = [UIColor lightGrayColor];
    [self.view addSubview:label];
    return label;
}

- (void)setTextField:(RXBlockTextField *)textField placeholder:(NSString *)placeholder {
    textField.contentInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.font = [UIFont systemFontOfSize:12];
    textField.placeholder = placeholder;
    textField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:textField];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
