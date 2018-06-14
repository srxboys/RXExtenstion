//
//  RXCurrencyFormatTextField.h
//  RXExtenstion
//
//  Created by srxboys on 2018/3/22.
//  Copyright © 2018年 https://github.com/srxboys. All rights reserved.
//
//货币格式化  -> 1，000.00     1,000,000.00

#import "RXBlockTextField.h"

@interface RXCurrencyFormatTextFieldHandler : RXBlockTextFieldHandler
{
    NSString    *previousTextFieldContent; //上一次输入的内容
    UITextRange *previousSelection;        //上一次的输入区域
}
@property (nonatomic, assign) BOOL enablePoint;//是否可以用小数

@end



@interface RXCurrencyFormatTextField : RXBlockTextField

@property (nonatomic, strong, readonly) RXCurrencyFormatTextFieldHandler *currencyHandler;

@property (nonatomic, assign) BOOL enablePoint;
@property (nonatomic, strong) UIFont *placeholderFont;

@end
