//
//  RXCharacter.m
//  RXExtenstion
//
//  Created by srx on 16/4/29.
//  Copyright © 2016年 srxboys. All rights reserved.
//

/*
 https://github.com/srxboys
 
 项目基本框架
 */

#import "RXCharacter.h"

@implementation NSObject (strNotEmptyValue)
- (NSString *)strNotEmptyValue {
    if ([self isKindOfClass:[NSString class]] && ((NSString *)self).length >0 && [((NSString *)self) isEqualToString:@"<null>"]) {
        return @"";
    }else if (self == nil || self == [NSNull null] || ([self isKindOfClass:[NSString class]] && ((NSString *)self).length == 0)) {
        return @"";
    }else if ([self isKindOfClass:[NSNumber class]] && [((NSString *)self) integerValue]>0)
    {
        return [NSString stringWithFormat:@"%@", (id)self];
    }
    return ((NSString *)self);
}
@end

@implementation NSObject (strBOOL)
- (BOOL)strBOOL {
    if([self isKindOfClass:[NSString class]] && [((NSString *)self) isEqualToString:@"<null>"]) {
        return NO;
    }
    else if([self isKindOfClass:[NSString class]] && ((NSString *)self).length <= 0) {
        return NO;
    }
    else if(![self isKindOfClass:[NSString class]]) {
        return NO;
    }
    return YES;
}

@end


@implementation NSObject (arrBOOL)
- (BOOL)arrBOOL {
    if(![self isKindOfClass:[NSArray class]]) {
        return NO;
    }
    else if(((NSArray *)self).count <= 0) {
        return NO;
    }
    else {
        return YES;
    }
}
@end


@implementation NSObject (arrValue)

- (NSArray *)arrValue {
    if([self isKindOfClass:[NSNull class]]) {
        return @[];
    }
    else if([self isKindOfClass:[NSString class]] && ![self isEqual:@""]) {
        return @[self];
    }
    else if([self isEqual:@""]) {
        return @[];
    }
    else if([self isKindOfClass:[NSDictionary class]]) {
        return @[self];
    }
    else {
        return (NSArray *)self;
    }
}

@end

@implementation NSObject (dictBOOL)

- (BOOL)dictBOOL {
    if([self isKindOfClass:[NSNull class]]) {
        return NO;
    }
    else if([self isKindOfClass:[NSString class]]) {
        return NO;
    }
    else if([self isKindOfClass:[NSArray class]]) {
        return NO;
    }
    else if([self isKindOfClass:[NSNumber class]]) {
        return NO;
    }
    else {
        return YES;
    }
}

@end


@implementation NSObject (urlBOOL)
- (BOOL)urlBOOL {
    if([self isKindOfClass:[NSNull class]]) {
        return NO;
    }
    else if([self isKindOfClass:[NSString class]] && [(NSString *)self isEqualToString:@""]){
        return NO;
    }
    else if(![self isKindOfClass:[NSString class]]) {
        return NO;
    }
    else if ([(NSString *)self rangeOfString:@"http://"].location != NSNotFound ) {
        return YES;
    }
    else if ([(NSString *)self rangeOfString:@"https://"].location != NSNotFound ) {
        return YES;
    }
    else {
        return NO;
    }
}
@end


@implementation NSObject (fromatValue)

- (NSString *)formatMonery {
    
    NSRange range = [((NSString *)self) rangeOfString:@"-"];
    if (range.location != NSNotFound) {
        return @"0.00";
    }
    
    if ([((NSString *)self) isEqualToString:@"0"]) {
        return @"0.00";
    }
    NSString * value = [NSString stringWithFormat:@"%f",
                        [((NSString *)self) doubleValue]];
    
    if ([((NSString *)self) doubleValue]>0) {
        
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
        [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
        [formatter setCurrencySymbol:@""];
        
        NSMutableString *string = [NSMutableString stringWithString:[value componentsSeparatedByString:@"."][1]];
        return [NSString stringWithFormat:@"%@.%@",[value componentsSeparatedByString:@"."][0],[string substringToIndex:2]];
    }
    return ((NSString *)self);
}

@end





