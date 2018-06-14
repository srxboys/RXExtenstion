//
//  RXBankCardFormatTextField.h
//  RXExtenstion
//
//  Created by srxboys on 2018/3/22.
//  Copyright © 2018年 https://github.com/srxboys. All rights reserved.
//
// 银行卡号   -> xxxx xxxx xxxx xxxx xxxx xxx

#import "RXBlockTextField.h"

@interface RXBankCardFormatTextFieldHandler : RXBlockTextFieldHandler
{
    NSString    *previousTextFieldContent; //上一次输入的内容
    UITextRange *previousSelection;        //上一次的输入区域
}
@end


@interface RXBankCardFormatTextField : RXBlockTextField
@property (nonatomic, strong, readonly) RXBankCardFormatTextFieldHandler *bankCardHandler;
@end
