//
//  RXMineCreateAddressController.m
//  RXExtenstion
//
//  Created by srx on 16/8/8.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import "RXMineCreateAddressController.h"

#import "RXOneLinkageTreeAddress.h"
#import "RXThreeLinkageAddress.h"
#import "RXJDAddressPickerView.h"

#import "AppDelegate.h"

@interface RXMineCreateAddressController ()
{
    RXOneLinkageTreeAddress * _onePicker;
    RXThreeLinkageAddress   * _twoPicker;
    RXJDAddressPickerView   * _threePicker;
    
    BOOL                      _inSelfView;
}

@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
- (IBAction)oneAddressButtonClick:(id)sender;
- (IBAction)TwoAddressButtonClick:(id)sender;
- (IBAction)threeAddressButtonClick:(id)sender;


@end

@implementation RXMineCreateAddressController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configUI];
}

- (void)configUI {
    
    weak(weakSelf);
    
    _onePicker = [[RXOneLinkageTreeAddress alloc] init];
    _onePicker.isShow = ^ (BOOL isShow, NSString *address, NSString * addressCode){
        RXLog(@"_onePicker\nisShow=%@, address=%@, addressCode=%@\n\n", isShow ? @"是" : @"否`", address, addressCode);
        
        weakSelf.addressLabel.text = [NSString stringWithFormat:@"_onePicker isShow=%@, address=%@, addressCode=%@", isShow ? @"是" : @"否`", address, addressCode];
    };
    
    
    
    _twoPicker = [[RXThreeLinkageAddress alloc] init];
    _twoPicker.isShow = ^ (BOOL isShow, NSString *address, NSString * addressCode){
        RXLog(@"_twoPicker\nisShow=%@, address=%@, addressCode=%@\n\n", isShow ? @"是" : @"否", address, addressCode);
        
        weakSelf.addressLabel.text = [NSString stringWithFormat:@"_twoPicker  isShow=%@, address=%@, addressCode=%@", isShow ? @"是" : @"否", address, addressCode];
        
    };
    
    
    _threePicker = [[RXJDAddressPickerView alloc] init];
    _threePicker.completion = ^(NSString *address, NSString * addressCode){
        RXLog(@"_threePicker\n, address=%@, addressCode=%@\n\n", address, addressCode);
        
        weakSelf.addressLabel.text = [NSString stringWithFormat:@"_threePicker , address=%@, addressCode=%@", address, addressCode];
    };
    
    
    _inSelfView = NO;
    
    if(_inSelfView) {
        [self.view addSubview:_onePicker];
        [self.view addSubview:_twoPicker];
        [self.view addSubview:_threePicker];
    }
    else {
        [SharedAppDelegate.window addSubview:_onePicker];
        [SharedAppDelegate.window addSubview:_twoPicker];
        [SharedAppDelegate.window addSubview:_threePicker];
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)oneAddressButtonClick:(id)sender {
    [_onePicker showAddressView];
}

- (IBAction)TwoAddressButtonClick:(id)sender {
    [_twoPicker show];
}

- (IBAction)threeAddressButtonClick:(id)sender {
    [_threePicker showAddress];
}

- (void)dealloc {
    [_onePicker removeFromSuperview];
    [_twoPicker removeFromSuperview];
    [_threePicker removeFromSuperview];
}
@end
