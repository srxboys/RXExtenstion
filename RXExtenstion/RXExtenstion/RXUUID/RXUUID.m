//
//  RXUUID.m
//  RXExtenstion
//
//  Created by srx on 16/6/27.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import "RXUUID.h"
#import "SFHFKeychainUtils.h"
#import "OpenUDID.h"

#define userName @"srxboysUDID"
#define serviceName @"RXExtenstion"


@implementation RXUUID
+(NSString *)getUMSUDID
{
    NSString * udidInKeyChain = [SFHFKeychainUtils getPasswordForUsername:userName andServiceName:serviceName error:nil];
    if(udidInKeyChain && ![udidInKeyChain isEqualToString:@""])
    {
        return udidInKeyChain;
    }
    else
    {
        //        NSString *idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
        //        if(idfa && ![idfa isEqualToString:@""])
        //        {
        //            [SFHFKeychainUtils storeUsername:@"UMSAgentUDID" andPassword:idfa forServiceName:@"UMSAgent" updateExisting:NO error:nil];
        //            return idfa;
        //        }
        //        else
        //        {
        NSString *openUDID = [OpenUDID value];
        [SFHFKeychainUtils storeUsername:userName andPassword:openUDID forServiceName:serviceName updateExisting:NO error:nil];
        return openUDID;
        //        }
    }
}
@end
