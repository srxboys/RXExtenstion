//
//  RXGetNetStatus.h
//  RXExtenstion
//
//  Created by srx on 16/5/26.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RXNetworkCheck.h"



@interface RXGetNetStatus : NSObject
@property (nonatomic, copy, readonly) NSString * netStatus;
- (instancetype)initRXGetNetStatusTarget:(id)target action:(SEL)action;
@end
