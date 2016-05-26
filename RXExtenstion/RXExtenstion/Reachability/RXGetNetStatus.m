//
//  RXGetNetStatus.m
//  RXExtenstion
//
//  Created by srx on 16/5/26.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import "RXGetNetStatus.h"
#import "RXConstant.h"

// 运行时objc_msgSend
#define RXMsgSend(...) ((void (*)(void *, SEL, NSObject *))objc_msgSend)(__VA_ARGS__)
#define RXMsgTarget(target) (__bridge void *)(target)


@interface RXGetNetStatus ()
@property (nonatomic, weak)   id  rxGetNetTarget;
@property (nonatomic, assign) SEL rxGetNetAction;
@end

@implementation RXGetNetStatus

- (instancetype)initRXGetNetStatusTarget:(id)target action:(SEL)action {
    self = [super init];
    if(self) {
        self.rxGetNetTarget = target;
        self.rxGetNetAction = action;
        [self addRXNetworkCheckObserver];
    }
    return self;
}

- (void)addRXNetworkCheckObserver {
    [self getNetworkStatus];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getNetworkResult:) name:rxGetNetworkStatusNotification object:nil];
}

- (void)getNetworkResult:(NSNotification *)noti {
    [self getNetworkStatus];
    
    if([self.rxGetNetTarget respondsToSelector:self.rxGetNetAction]) {
//        RXMsgSend(RXMsgTarget(self.rxGetNetTarget), self.rxGetNetAction, self);
        [self.rxGetNetTarget performSelector:self.rxGetNetAction withObject:self];
    }
}

- (void)getNetworkStatus {
    _netStatus = [RXNetworkCheck shareNetworkCheck].statusString;
}

@end
