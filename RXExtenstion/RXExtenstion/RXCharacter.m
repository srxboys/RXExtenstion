//
//  RXCharacter.m
//  RXExtenstion
//
//  Created by srx on 16/4/29.
//  Copyright © 2016年 srxboys. All rights reserved.
//

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