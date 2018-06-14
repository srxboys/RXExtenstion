//
//  RXBlockTextField.h
//  RXExtenstion
//
//  Created by srxboys on 2018/3/22.
//  Copyright © 2018年 https://github.com/srxboys. All rights reserved.
//
// block 监听textFile输入等等变化

#import <UIKit/UIKit.h>

@interface RXBlockTextFieldHandler : NSObject <UITextFieldDelegate>
@property (nonatomic,copy) BOOL(^textFieldShouldBeginEditingBlock)(UITextField * textField);
@property (nonatomic,copy) BOOL(^textFieldShouldEndEditingBlock)(UITextField * textField);

@property (nonatomic,copy) void(^textFieldDidBeginEditingBlock)(UITextField * textField);
@property (nonatomic,copy) void(^textFieldDidEndEditingBlock)(UITextField * textField);

@property (nonatomic,copy) BOOL(^textFieldShouldChangeCharactersInRangeReplacementStringBlock)(UITextField *textField, NSRange range, NSString *string);

@property (nonatomic,copy) BOOL(^textFieldShouldClearBlock)(UITextField * textField);
@property (nonatomic,copy) BOOL(^textFieldShouldReturnBlock)(UITextField * textField);
@end




@interface RXBlockTextField : UITextField

@property(nonatomic, assign) UIEdgeInsets contentInsets;
@property(nonatomic, strong) UIColor *placeholderColor;
@property(nonatomic, strong, readonly) RXBlockTextFieldHandler* handler;

@end
