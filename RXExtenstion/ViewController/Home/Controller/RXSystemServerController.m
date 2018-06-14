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
#import "RXCharacter.h"

@interface RXSystemServerController ()
- (IBAction)goToSinaButtonClick:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *phoneNumTextField;
- (IBAction)callButtonClick:(id)sender;

@property (weak, nonatomic) IBOutlet UITextView *messageTextView;
- (IBAction)sendMessageButtonClick:(id)sender;

@property (weak, nonatomic) IBOutlet UITextView *emailTextView;
- (IBAction)sendEmailButtonClick:(id)sender;


- (IBAction)gotoAppStoreComment:(id)sender;
- (IBAction)gotoAppStore:(id)sender;

@end

@implementation RXSystemServerController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"调用系统功能";
    
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
    NSString * message = _messageTextView.text;
    message = StrFormatWhiteSpace(message);
    if(!StrBool(message)) {
        // alert [没有内容 /  haven't content]
        return;
    }
    NSArray * phoneNums = @[@"18811425575"];
    [[RXSystemServer sharedRXSystemServer] sendMessageTo:phoneNums withMessageBody:message];
}



- (IBAction)sendEmailButtonClick:(id)sender {
    NSString * message = _emailTextView.text;
    message = StrFormatWhiteSpace(message);
    if(!StrBool(message)) {
        // alert [没有内容 /  haven't content]
        return;
    }
    NSArray * emails = @[@"srxboys@126.com"];
    
    NSString * subject = @"RX_主题";
    
    [[RXSystemServer sharedRXSystemServer] sendEmailTo:emails withSubject:subject andMessageBody:message];
}

- (IBAction)gotoAppStoreComment:(id)sender {
    [[RXSystemServer sharedRXSystemServer] openAppleStoreComment];
}

- (IBAction)gotoAppStore:(id)sender {
    [[RXSystemServer sharedRXSystemServer] openAppleStoreProduct];
}


- (void)closeKeyboard {
    [_phoneNumTextField resignFirstResponder];
    [_emailTextView resignFirstResponder];
    [_messageTextView resignFirstResponder];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self closeKeyboard];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
