//
//  RXPhoneNumberFormatTextField.h
//  RXExtenstion
//
//  Created by srxboys on 2018/3/22.
//  Copyright © 2018年 https://github.com/srxboys. All rights reserved.
//
// 手机号  ->  138 1111 2222

#import "RXBlockTextField.h"


@interface RXPhoneNumberFormatTextFieldHandler : RXBlockTextFieldHandler
{
    NSString    *previousTextFieldContent; //上一次输入的内容
    UITextRange *previousSelection;        //上一次的输入区域
}
@property (nonatomic, assign) BOOL enablePoint;//是否可以用小数

@end

@interface RXPhoneNumberFormatTextField : RXBlockTextField
@property (nonatomic, strong, readonly) RXPhoneNumberFormatTextFieldHandler *phoneNumberHandler;
@end
