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

#pragma mark - ~~~~~~~~~~~ 对请求参数做处理 ~~~~~~~~~~~~~~~
NSString* NonEmptyString(id obj){
    if ([obj isKindOfClass:[NSString class]] && [obj length]>0 && [obj isEqualToString:@"<null>"]) {
        return @"";
    }else if (obj == nil || obj == [NSNull null] || ([obj isKindOfClass:[NSString class]] && [obj length] == 0)) {
        return @"";
    }else if ([obj isKindOfClass:[NSNumber class]] && [obj integerValue]>0)
    {
        return NonEmptyString([obj stringValue]);
    }
    return obj;
}

#pragma mark - ~~~~~~~~~~~ 判断字符串是否为空 ~~~~~~~~~~~~~~~
BOOL StrBool(id obj) {
    if(obj == nil) {
        return NO;
    }
    else if(![obj isKindOfClass:[NSString class]]) {
        return NO;
    }
    else if([obj isKindOfClass:[NSString class]] && [((NSString *)obj) isEqualToString:@"<null>"]) {
        return NO;
    }
    else if([obj isKindOfClass:[NSString class]] && ((NSString *)obj).length == 0) {
        return NO;
    }
    return YES;
}



#pragma mark - ~~~~~~~~~~~ 去掉字符串中前后空格 ~~~~~~~~~~~~~~~
NSString * StrFormatWhiteSpace(id obj) {
    NSString * object = NonEmptyString(obj);
    return [object stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}





#pragma mark - ~~~~~~~~~~~ 把字符串 变成 金钱字符串 0.00样式 ~~~~~~~~~~~~~~~
NSString * StrFormatValue(id obj) {
    NSString * object = NonEmptyString(obj);
    if(object.length == 0) return @"0.00";
    
    NSRange range = [object rangeOfString:@"-"];
    if (range.location != NSNotFound) {
        return @"0.00";
    }
    
    if ([object isEqualToString:@"0"]) {
        return @"0.00";
    }
    NSString * value = [NSString stringWithFormat:@"%f",
                        [object doubleValue]];
    
    if ([object doubleValue]>0) {
        
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
        [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
        [formatter setCurrencySymbol:@""];
        
        NSMutableString *string = [NSMutableString stringWithString:[value componentsSeparatedByString:@"."][1]];
        return [NSString stringWithFormat:@"%@.%@",[value componentsSeparatedByString:@"."][0],[string substringToIndex:2]];
    }
    else {
        return @"0.00";
    }
}


#pragma mark - ~~~~~~~~~~~ 是否是数组 ~~~~~~~~~~~~~~~
BOOL ArrBool(id obj) {
    if(obj == nil) return NO;
    if(![obj isKindOfClass:[NSArray class]]) {
        return NO;
    }
    else if(((NSArray *)obj).count <= 0) {
        return NO;
    }
    else {
        return YES;
    }
}

#pragma mark - ~~~~~~~~~~~ 返回【判断后的数组】-- 如果是字典以数组形式返回 ~~~~~~~~~~~~~~~
NSArray * ArrValue(id obj) {
    if(obj == nil) return @[];
    if([obj isKindOfClass:[NSNull class]]) {
        return @[];
    }
    else if([obj isKindOfClass:[NSString class]] && ![obj isEqual:@""]) {
        return @[obj];
    }
    else if([obj isEqual:@""]) {
        return @[];
    }
    else if([obj isKindOfClass:[NSDictionary class]]) {
        return @[obj];
    }
    else if([obj isKindOfClass:[NSNumber class]]) {
        return @[[((NSNumber *)obj) stringValue]];
    }
    else {
        return (NSArray *)obj;
    }
}



#pragma mark - ~~~~~~~~~~~ 是否是 字典 ~~~~~~~~~~~~~~~
BOOL DictBool(id obj) {
    if(obj == nil) return NO;
    if([obj isKindOfClass:[NSNull class]]) {
        return NO;
    }
    else if([obj isKindOfClass:[NSString class]]) {
        return NO;
    }
    else if([obj isKindOfClass:[NSArray class]]) {
        return NO;
    }
    else if([obj isKindOfClass:[NSNumber class]]) {
        return NO;
    }
    else if(![obj isKindOfClass:[NSDictionary class]]) {
        return NO;
    }
    else {
        if(((NSDictionary *)obj).allKeys <= 0) return NO;
        return YES;
    }
}




#pragma mark - ~~~~~~~~~~~ 判断字符串是否 为 Url ~~~~~~~~~~~~~~~
BOOL UrlBool(id obj) {
    if([obj isKindOfClass:[NSNull class]]) {
        return NO;
    }
    else if([obj isKindOfClass:[NSString class]] && [(NSString *)obj isEqualToString:@""]){
        return NO;
    }
    else if([obj isKindOfClass:[NSURL class]]) {
        NSURL * objUrl = obj;
        if(objUrl == nil) {
            return NO;
        }
        else {
            if(!StrBool(objUrl.absoluteString)) return NO;
            return UrlBool(objUrl.absoluteString);
        }
    }
    else if(![obj isKindOfClass:[NSString class]]) {
        return NO;
    }
    else if ([(NSString *)obj rangeOfString:@"http://"].location != NSNotFound ) {
        return YES;
    }
    else if ([(NSString *)obj rangeOfString:@"https://"].location != NSNotFound ) {
        return YES;
    }
    else {
        return NO;
    }
}





