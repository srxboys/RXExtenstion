//
//  RXSystemServerController.m
//  RXExtenstion
//
//  Created by srx on 16/6/3.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

//  coding ~~~~

#import "RXSystemServerController.h"

#import "RXSystemServer.h"

@interface RXSystemServerController ()
- (IBAction)goToSinaButtonClick:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *phoneNumTextField;
- (IBAction)callButtonClick:(id)sender;

@property (weak, nonatomic) IBOutlet UITextView *messageTextView;
- (IBAction)sendMessageButtonClick:(id)sender;

@property (weak, nonatomic) IBOutlet UITextView *emailTextView;
- (IBAction)sendEmailButtonClick:(id)sender;



@end

@implementation RXSystemServerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configUI];
}

- (void)configUI {
    _phoneNumTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    UIView * padding = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 5)];
    _phoneNumTextField.leftView = padding;
    _phoneNumTextField.leftViewMode = UITextFieldViewModeAlways;
}



- (IBAction)goToSinaButtonClick:(id)sender {
    [[RXSystemServer sharedRXSystemServer] openURL:@"https://weibo.com/srxboys"];
}

- (IBAction)callButtonClick:(id)sender {
    /*
     这里需要判断手机号
     */
    [[RXSystemServer sharedRXSystemServer] callTelephone:_phoneNumTextField.text];
}

- (IBAction)sendMessageButtonClick:(id)sender {
    
//   [RXSystemServer sharedRXSystemServer] sendMessageTo:<#(NSArray *)#> withMessageBody:<#(NSString *)#>
}



- (IBAction)sendEmailButtonClick:(id)sender {
//    [[RXSystemServer sharedRXSystemServer] sendEmailTo:<#(NSArray *)#> withSubject:<#(NSString *)#> andMessageBody:<#(NSString *)#>];
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
