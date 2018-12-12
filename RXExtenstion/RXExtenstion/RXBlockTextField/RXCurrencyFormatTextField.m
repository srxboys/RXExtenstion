//
//  RXCurrencyFormatTextField.m
//  RXExtenstion
//
//  Created by srxboys on 2018/3/22.
//  Copyright © 2018年 https://github.com/srxboys. All rights reserved.
//

#import "RXCurrencyFormatTextField.h"

@interface RXCurrencyFormatTextFieldHandler()

@property (nonatomic, assign) BOOL reformatIgnore;

@end

@implementation RXCurrencyFormatTextFieldHandler
- (instancetype)init {
    self = [super init];
    if (self) {
        _reformatIgnore = NO;
    }
    return self;
}

- (void)reformatAsCurrency:(UITextField *)textField {
    if (self.reformatIgnore == YES)
        return ;
    
    // In order to make the cursor end up positioned correctly, we need to
    // explicitly reposition it after we inject spaces into the text.
    // targetCursorPosition keeps track of where the cursor needs to end up as
    // we modify the string, and at the end we set the cursor position to it.
    //获取以from为基准的to的偏移，例如abcde，光标在c后，则光标相对文尾的偏移为-2。
    NSUInteger targetCursorPosition = [textField offsetFromPosition:textField.beginningOfDocument toPosition:textField.selectedTextRange.start];
    
    //移除非数字
    NSString *currencyWithoutComma = [self removeNonDigits:textField.text andPreserveCursorPosition:&targetCursorPosition];
    NSUInteger intDigits = [currencyWithoutComma length];
    
    NSArray *components = [currencyWithoutComma componentsSeparatedByString:@"."];
    // 限制不能有小数点。对于已经有小数点的情况，对删除不做限制
    if (!self.enablePoint && [components count] > 1 && [previousTextFieldContent length]<=[currencyWithoutComma length]) {
        [textField setText:previousTextFieldContent];
        textField.selectedTextRange = previousSelection;
        return;
    }
    // 限制只能有一个小数点
    if (self.enablePoint && [components count] > 2) {
        [textField setText:previousTextFieldContent];
        textField.selectedTextRange = previousSelection;
        return;
    }
    
    // 限制小数点后最多2位
    NSRange rangePoint = [currencyWithoutComma rangeOfString:@"."];
    if (rangePoint.length == 1 && rangePoint.location != NSNotFound && rangePoint.location+3 < [currencyWithoutComma length]) {
        [textField setText:previousTextFieldContent];
        textField.selectedTextRange = previousSelection;
        return;
    }
    
    // 限制整数部分最大12位
    if (rangePoint.location != NSNotFound) {
        intDigits = rangePoint.location;
    }
    if (intDigits > 12) {
        [textField setText:previousTextFieldContent];
        textField.selectedTextRange = previousSelection;
        return;
    }
    
    // 限制0000
    if ([currencyWithoutComma length] > 1 && [currencyWithoutComma characterAtIndex:0]=='0' && [currencyWithoutComma characterAtIndex:1]!='.') {
        [textField setText:[currencyWithoutComma substringFromIndex:1]];
        return;
    }
    
    NSString *currencyWithComma = [self insertCommaEveryThreeDigitsIntoString:currencyWithoutComma andPreserveCursorPosition:&targetCursorPosition];
    
    self.reformatIgnore = YES;
    textField.text = currencyWithComma;
    self.reformatIgnore = NO;
    
    UITextPosition *targetPosition = [textField positionFromPosition:[textField beginningOfDocument] offset:targetCursorPosition];
    
    [textField setSelectedTextRange:[textField textRangeFromPosition:targetPosition toPosition:targetPosition]];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    // Note textField's current state before performing the change, in case
    // reformatTextField wants to revert it
    previousTextFieldContent = textField.text;
    previousSelection = textField.selectedTextRange;
    
    return [super textField:textField shouldChangeCharactersInRange:range replacementString:string];
}

/*
 *   Removes non-digits from the string, decrementing `cursorPosition` as
 *   appropriate so that, for instance, if we pass in `@"1111 1123 1111"`
 *   and a cursor position of `8`, the cursor position will be changed to
 *   `7` (keeping it between the '2' and the '3' after the spaces are removed).
 */
- (NSString *)removeNonDigits:(NSString *)string andPreserveCursorPosition:(NSUInteger *)cursorPosition {
    NSUInteger      originalCursorPosition = *cursorPosition;
    NSMutableString *digitsOnlyString = [NSMutableString new];
    
    for (NSUInteger i = 0; i < [string length]; i++) {
        unichar characterToAdd = [string characterAtIndex:i];
        
        if (isdigit(characterToAdd) || characterToAdd=='.') {
            NSString *stringToAdd = [NSString stringWithCharacters:&characterToAdd length:1];
            
            [digitsOnlyString appendString:stringToAdd];
        } else {
            if (i < originalCursorPosition) {
                (*cursorPosition)--;
            }
        }
    }
    
    return digitsOnlyString;
}

/*
 *   Inserts spaces into the string to format it as a credit card number,
 *   incrementing `cursorPosition` as appropriate so that, for instance, if we
 *   pass in `@"111111231111"` and a cursor position of `7`, the cursor position
 *   will be changed to `8` (keeping it between the '2' and the '3' after the
 *   spaces are added).
 */
- (NSString *)insertCommaEveryThreeDigitsIntoString:(NSString *)string andPreserveCursorPosition:(NSUInteger *)cursorPosition {
    NSMutableString *stringWithAddedCommas = [NSMutableString new];
    NSUInteger      cursorPositionInCommalessString = *cursorPosition;
    NSUInteger      pointOffset = [string length];
    
    NSRange rangePoint = [string rangeOfString:@"."];
    if (rangePoint.length == 1 && rangePoint.location != NSNotFound)
        pointOffset = rangePoint.location;
    
    for (NSUInteger i=0 ; i<pointOffset ; i++)
    {
        if (i>0 && ((pointOffset-i)%3)==0)
        {
            [stringWithAddedCommas appendString:@","];
            
            if (pointOffset-i < cursorPositionInCommalessString) {
                (*cursorPosition)++;
            }
        }
        
        unichar     characterToAdd = [string characterAtIndex:i];
        NSString    *stringToAdd = [NSString stringWithCharacters:&characterToAdd length:1];
        
        [stringWithAddedCommas appendString:stringToAdd];
    }
    
    if (rangePoint.length == 1 && rangePoint.location != NSNotFound)
        [stringWithAddedCommas appendString:[string substringFromIndex:rangePoint.location]];
    
    return stringWithAddedCommas;
}

@end






@implementation RXCurrencyFormatTextField

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.enablePoint = YES;
        _currencyHandler = [[RXCurrencyFormatTextFieldHandler alloc] init];
        _currencyHandler.enablePoint = YES;
        self.delegate = _currencyHandler;
        [self addTarget:_currencyHandler action:@selector(reformatAsCurrency:) forControlEvents:UIControlEventEditingChanged];
        _placeholderFont = [UIFont systemFontOfSize:15];
    }
    
    return self;
}

- (void)setEnablePoint:(BOOL)enablePoint {
    _enablePoint = enablePoint;
    _currencyHandler.enablePoint = enablePoint;
}

- (void)drawPlaceholderInRect:(CGRect)rect {
    if (![self respondsToSelector:@selector(setAttributedPlaceholder:)] && self.placeholderColor) {
        [self.placeholderColor setFill];
    }
    CGRect placeholderRect = CGRectMake(rect.origin.x, (rect.size.height- self.placeholderFont.lineHeight)/2+4, rect.size.width, self.placeholderFont.lineHeight);//设置距离
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineBreakMode = NSLineBreakByTruncatingTail;
    style.alignment = self.textAlignment;
    
    NSDictionary *attr = [NSDictionary dictionaryWithObjectsAndKeys:style,NSParagraphStyleAttributeName,self.placeholderFont, NSFontAttributeName, self.placeholderColor, NSForegroundColorAttributeName,nil];
    
    [self.placeholder drawInRect:placeholderRect withAttributes:attr];
}

@end
