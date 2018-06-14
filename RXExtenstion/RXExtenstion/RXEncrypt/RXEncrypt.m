//
//  RXEncrypt.m
//  RXExtenstion
//
//  Created by srxboys on 2018/1/24.
//  Copyright © 2018年 https://github.com/srxboys. All rights reserved.
//

#import "RXEncrypt.h"

//Xcode 自带的MD5加密,,,下面导入的是，所有自带的加密方法
#import <CommonCrypto/CommonCrypto.h>


//这个定义 有点危险， Xcode默认兼容最低版本 在编译的时候判断， 就算你添加的 iOSDeveloperSuppler  也不行。
#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_7_0 || MAC_OS_X_VERSION_MAX_ALLOWED <  MAC_OS_X_VERSION_10_9
    #import "GTMBase64.h"
#endif

#import "RSACrypt.h"
#import "AESCrypt.h"

#define SALT_KEY @"srxboys_salt" // 盐


static RXDigest_t * rxSign = NULL;
@implementation _RXEncrypt

bool isString(id obj) {
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

static NSString * _RSA_Digest(NSString * string) {
    if(!isString(string)) {
        return @"";
    }
    NSString * encWithPubKey = [RSACrypt encryptString:string publicKey:SALT_KEY];
    // +  替换  $   //如果加密区分有误  后台 会告诉你他的后台需要什么样子的
    //    encWithPubKey = [encWithPubKey stringByReplacingOccurrencesOfString:@"+" withString:@"$"];
    return encWithPubKey;
}

static NSString * _AES_Digest(NSString * string) {
    if(!isString(string)) {
        return @"";
    }
    NSString * encryptString = [AESCrypt encrypt:string password:SALT_KEY];
    // +  替换  $  //如果加密区分有误  后台 会告诉你他的后台需要什么样子的
    //    encryptString = [encryptString stringByReplacingOccurrencesOfString:@"+" withString:@"$"];
    return encryptString;
}

#pragma mark 返回32位小写 的 MD5加密
static NSString * _md5_32Bit_Digest(NSString * string) {
    if(!isString(string)) {
        return @"";
    }
    const char *original_str = [string UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (int)strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
    {
        [hash appendFormat:@"%02X", result[i]];
    }
    NSString * lastHash = [hash lowercaseString];
    return lastHash;
}

////返回16位小写 的 MD5加密
static NSString * _MD5_16Bit_Digest(NSString * string) {
    if(!isString(string)) {
        return @"";
    }
    //提取32位MD5散列的中间16位
    NSString *md5_32Bit_String = _md5_32Bit_Digest(string);
    NSString *result = [[md5_32Bit_String substringToIndex:24] substringFromIndex:8];//即9～25位
    return result;
}

// HmacAlg MD5【除了md5你还想其他的加密       CCHmac(kCCHmacAlgMD5 [这里是枚举替换就好了],    长度选择相应的】
static NSString * _HMACAlgMD5_32Bit_Digest(NSString *string) {
    NSString * key = SALT_KEY;
    NSData *datas = [string dataUsingEncoding:NSUTF8StringEncoding];
    size_t dataLength = datas.length;
    NSData *keys = [key dataUsingEncoding:NSUTF8StringEncoding];
    size_t keyLength = keys.length;
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgMD5, [keys bytes], keyLength, [datas bytes], dataLength, result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i ++) {
        [hash appendFormat:@"%02X", result[i]];
    }
    NSString * lastHash = [hash lowercaseString];
    return lastHash;
}


static NSString * _Sha1_Digest(NSString * string) {
    if(!isString(string)) {
        return @"";
    }
    const char *cstr = [string cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:string.length];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (uint32_t)data.length, digest);
    NSMutableString* result = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH *2];
    for(int i =0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    return result;
}

static NSString * _Sha224_Digest(NSString * string) {
    if(!isString(string)) {
        return @"";
    }
    const char *cstr = [string cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:string.length];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA224(data.bytes, (uint32_t)data.length, digest);
    NSMutableString* result = [NSMutableString stringWithCapacity:CC_SHA224_DIGEST_LENGTH *2];
    for(int i =0; i < CC_SHA224_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    return result;
}

static NSString * _Sha256_Digest(NSString * string) {
    if(!isString(string)) {
        return @"";
    }
    const char *cstr = [string cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:string.length];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA256(data.bytes, (uint32_t)data.length, digest);
    NSMutableString* result = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH *2];
    for(int i =0; i < CC_SHA256_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    return result;
}

static NSString * _Sha512_Digest(NSString * string) {
    if(!isString(string)) {
        return @"";
    }
    const char *cstr = [string cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:string.length];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA512(data.bytes, (uint32_t)data.length, digest);
    NSMutableString* result = [NSMutableString stringWithCapacity:CC_SHA512_DIGEST_LENGTH *2];
    for(int i =0; i < CC_SHA512_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    return result;
}

static NSString * _Sha384_Digest(NSString * string) {
    if(!isString(string)) {
        return @"";
    }
    const char *cstr = [string cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:string.length];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA384(data.bytes, (uint32_t)data.length, digest);
    NSMutableString* result = [NSMutableString stringWithCapacity:CC_SHA384_DIGEST_LENGTH *2];
    for(int i =0; i < CC_SHA384_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    return result;
}

//编码
static NSString * _BASE64_encodeData(NSString * string) {
    if(!isString(string)) {
        return @"";
    }
#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_7_0 || MAC_OS_X_VERSION_MAX_ALLOWED <  MAC_OS_X_VERSION_10_9
    //兼容低版本
    NSData *data= [string dataUsingEncoding:NSUTF8StringEncoding];
    if([data length]<0) return @"";
    data = [GTMBase64 encodeData:data];//编码
    NSString *retStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
#else
    //系统方法
    NSData *data= [string dataUsingEncoding:NSUTF8StringEncoding];
    if([data length]<=0) return @"";
    NSString * retStr = [data base64EncodedStringWithOptions:0];
    return retStr;
#endif
}

//解码
static NSString * _BASE64_decodeData(NSString * string) {
    if(!isString(string)) {
        return @"";
    }
#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_7_0 || MAC_OS_X_VERSION_MAX_ALLOWED <  MAC_OS_X_VERSION_10_9
    //兼容低版本
    NSData *data= [string dataUsingEncoding:NSUTF8StringEncoding];
    if([data length]<0) return @"";
    data = [GTMBase64 decodeData:data];
    NSString *retStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
#else
    //系统方法
    NSData * data =  [[NSData alloc] initWithBase64EncodedString:string options:0];
    if([data length]<=0) return @"";
    NSString * retStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return retStr;
#endif
}

+ (RXDigest_t *)allocDigest {
    rxSign = malloc(sizeof(RXDigest_t));
    
    rxSign->RSA_Digest = _RSA_Digest;
    rxSign->AES_Digest = _AES_Digest;
    
    /// 返回32位小写 的 MD5加密
    rxSign->HMACAlgMD5_32Bit_Digest = _HMACAlgMD5_32Bit_Digest;
    rxSign->MD5_32Bit_Digest = _md5_32Bit_Digest;
    rxSign->MD5_16Bit_Digest = _MD5_16Bit_Digest;
    
    rxSign->Sha1_Digest = _Sha1_Digest;
    rxSign->Sha224_Digest = _Sha224_Digest;
    rxSign->Sha256_Digest = _Sha256_Digest;
    rxSign->Sha512_Digest = _Sha512_Digest;
    rxSign->Sha384_Digest = _Sha384_Digest;
    
    rxSign->BASE64_encodeData = _BASE64_encodeData;
    rxSign->BASE64_decodeData = _BASE64_decodeData;
    
    return rxSign;
}

+ (void)destory {
    rxSign ? free(rxSign): 0;
    rxSign = NULL;
}

@end



/*
     为什么这么写？
     Objective-C代码容易被hook，暴露信息太赤裸裸，为了安全，改用C来写吧
     以前的OC方法，被class-dump出来后，利用Cycript很容易实现攻击，容易被hook，存在很大的安全隐患
 
     好处:
     把函数名隐藏在结构体里，以函数指针成员的形式存储。
     这样做的好处是，编译后，只留了下地址，去掉了名字和参数表，提高了逆向成本和攻击门槛。
 */








