//
//  RXEncrypt.h
//  RXExtenstion
//
//  Created by srxboys on 2018/1/24.
//  Copyright © 2018年 https://github.com/srxboys. All rights reserved.
//
// 加密 (敏感逻辑的保护方案)

/*
    加密计算后，一定要给一个变量，然后清空加密算法类， 这样是为了安全考虑
 
 demo
 //加密
 NSString * base64_en = RXEncrypt->BASE64_encodeData(joinString);
 RXEncrypt_destory;
 RXLog(@"base64_en=%@", base64_en);
 
 //解密
 NSString * base64_de = RXEncrypt->BASE64_decodeData(base64_en);
 RXEncrypt_destory;
 RXLog(@"base_de=%@", base64_de);
 */

#import <Foundation/Foundation.h>

#define RXEncrypt ([_RXEncrypt allocDigest])
#define RXEncrypt_destory ([_RXEncrypt destory])



typedef struct Digest{
    
    NSString * (*AES_Digest)(NSString *string);
    NSString * (*RSA_Digest)(NSString * string);
    
    NSString * (*HMACAlgMD5_32Bit_Digest)(NSString *string);  // 32位小写 的 MD5加密
    NSString * (*MD5_32Bit_Digest)(NSString *string);  // 32位小写 的 MD5加密
    NSString * (*MD5_16Bit_Digest)(NSString *string);  //16位小写 的 MD5加密
                                              
    NSString * (*Sha1_Digest)(NSString *string);       //sha1转换
    NSString * (*Sha224_Digest)(NSString *string);
    NSString * (*Sha256_Digest)(NSString *string);
    NSString * (*Sha512_Digest)(NSString *string);
    NSString * (*Sha384_Digest)(NSString *string);
    
    NSString * (*BASE64_encodeData)(NSString *string); //base64 编码(低版本用第三方、iOS>7.0用系统的)
    NSString * (*BASE64_decodeData)(NSString *string); //base64 解码
} RXDigest_t;




@interface _RXEncrypt : NSObject
/**  标识，不可以被外部调用 */
- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

+ (RXDigest_t *)allocDigest;
+ (void)destory;

@end
