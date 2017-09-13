//
//  RXTouchID.m
//  RXExtenstion
//
//  Created by srx on 2017/9/13.
//  Copyright © 2017年 https://github.com/srxboys. All rights reserved.
//

#import "RXTouchID.h"

#import "RXTouchIDOption.h"

@interface RXTouchID ()

@property (nonatomic, copy) RXTouchIDOption * touchIDOption;

@end

@implementation RXTouchID

+ (RXTouchID *)getTouchID {
    return [[RXTouchID alloc] init];
}


+ (BOOL)isEnableTouchID {
    @autoreleasepool {
        if(iOS8OrLater) {
            return [[self getTouchID].touchIDOption isEnableTouchIDOption];
        }
        return NO;
    }
}

+ (void)evaluateTouchID:(void (^)(BOOL, NSError *, NSString *))block {
    @autoreleasepool {
        if(iOS8OrLater) {
            [[self getTouchID].touchIDOption evaluateTouchID:^(BOOL isSucc, NSError *error, NSString *descri) {
                if(block) {
                    block(isSucc, error, descri);
                }
            }];
        }
    }
}


- (RXTouchIDOption *)touchIDOption {
    if(!_touchIDOption) {
        _touchIDOption = [[RXTouchIDOption alloc] init];
    }
    return _touchIDOption;
}

@end
