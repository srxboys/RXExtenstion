//
//  RXBlockTextField.m
//  RXExtenstion
//
//  Created by srxboys on 2018/3/22.
//  Copyright © 2018年 https://github.com/srxboys. All rights reserved.
//

#import "RXBlockTextField.h"

@implementation RXBlockTextFieldHandler
#pragma mark - delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (self.textFieldShouldBeginEditingBlock)
        return self.textFieldShouldBeginEditingBlock(textField);
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (self.textFieldDidBeginEditingBlock)
        self.textFieldDidBeginEditingBlock(textField);
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if (self.textFieldShouldEndEditingBlock)
        return self.textFieldShouldEndEditingBlock(textField);
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (self.textFieldDidEndEditingBlock)
        self.textFieldDidEndEditingBlock(textField);
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (self.textFieldShouldChangeCharactersInRangeReplacementStringBlock)
        return self.textFieldShouldChangeCharactersInRangeReplacementStringBlock(textField, range, string);
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    if (self.textFieldShouldClearBlock)
        return self.textFieldShouldClearBlock(textField);
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (self.textFieldShouldReturnBlock)
        return self.textFieldShouldReturnBlock(textField);
    return YES;
}

@end





@implementation RXBlockTextField
- (void)_setup {
    self.contentInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.placeholderColor = [UIColor grayColor];
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-missing-super-calls"
- (void)awakeFromNib {
    [self _setup];
}
#pragma clang diagnostic pop

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _handler = [[RXBlockTextFieldHandler alloc] init];
        self.delegate = _handler;
        [self _setup];
    }
    return self;
}

#pragma mark - 重写
///重写来重置文字区域
- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, self.contentInsets.left, self.contentInsets.top);
}

///重写来重置占位符区域
- (CGRect)placeholderRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, self.contentInsets.left, self.contentInsets.top);
}

///重写来重置编辑区域
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, self.contentInsets.left, self.contentInsets.top);
}

/*
///改变绘文字属性.重写时调用super可以按默认图形属性绘制,若自己完全重写绘制函数，就不用调用super了.
//- (void)drawTextInRect:(CGRect)rect {}

///重写来重置边缘区域
//- (CGRect)borderRectForBounds:(CGRect)bounds {}

///重写来重置clearButton位置,改变size可能导致button的图片失真
//- (CGRect)clearButtonRectForBounds:(CGRect)bounds{}

//- (CGRect)leftViewRectForBounds:(CGRect)bounds {}
//- (CGRect)rightViewRectForBounds:(CGRect)bounds {}
*/

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
// Call setNeedsDisplay on the UITextField does not call the drawPlaceholderInRect method again.
- (void)drawPlaceholderInRect:(CGRect)rect {
    //针对没有使用富文本的placeholder
    if (![self respondsToSelector:@selector(setAttributedPlaceholder:)] && self.placeholderColor) {
        [self.placeholderColor setFill];
        [[self placeholder] drawInRect:rect withFont:self.font];
    } else {
        [super drawPlaceholderInRect:rect];
    }
}
#pragma clang diagnostic pop

#pragma mark - 设置属性
- (void)setContentInsets:(UIEdgeInsets)contentInsets {
    _contentInsets = contentInsets;
    [self setNeedsDisplay];
}

- (void)setPlaceholder:(NSString *)placeholder {
    if ([self respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName:self.placeholderColor}];
    } else {
        [super setPlaceholder:placeholder];
    }
}

@end




