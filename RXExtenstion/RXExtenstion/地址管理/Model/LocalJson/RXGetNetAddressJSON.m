//
//  RXGetNetAddressJSON.m
//  RXExtenstion
//
//  Created by srx on 16/8/8.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import "RXGetNetAddressJSON.h"

#import "RXCharacter.h"
#import "TTCacheUtil.h"
#import "RXConstant.h"
#import "RXAFNS.h"
#import "RXCharacter.h"


@implementation RXGetNetAddressJSON
+ (void)getNetWorkAddress {
    
    
    
    return;
    
    //下面的是请求数据
    
    __weak typeof(self)weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString * vode = @"0";
        NSString * tempVode = [UserDefaults objectForKey:AddressVodeDefaults];
        if([tempVode strBOOL]) {
            vode = tempVode;
        }
        
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf  postRequestWithVode:vode];
            });
    });
    
}


+ (void)postRequestWithVode:(NSString *)vode {
    NSDictionary * dict = @{
                            @"method" : @"接口",
                            @"vode"   : vode
                            };
    [RXAFNS postReqeustWithParams:dict successBlock:^(Response *responseObject) {
        
//        TTLog(@"returndata=%@", responseObject.returndata);
        if(!responseObject.status) {
            //已经为最新的地址了
            return ;
        }
        
        NSArray * arr = responseObject.returndata;
        if(![arr arrBOOL]) {
            //没有返回地址
            return;
        }
        
        //缓存地址
        NSDictionary * addressDict = arr[0];
        NSArray * array = addressDict[@"regions"];
        if([array arrBOOL]) {
        [TTCacheUtil writeObject:array toFile:AddressLocalJson];
            
            //缓存验证码
            NSString * vode = addressDict[@"vode"];
            if([vode strBOOL]) {
                [UserDefaults setObject:vode forKey:AddressVodeDefaults];
                [UserDefaults synchronize];
            }
        }
        
        
        
        
    } failureBlock:^(NSError *error) {
        RXLog(@"GHSGetAddressJSON___error=%@", error);
    } showHUD:NO loadingInView:nil];

    
}

+ (void)getNetWorkAddressAndCompletion:(void (^)(BOOL))completion {
    
}
@end
