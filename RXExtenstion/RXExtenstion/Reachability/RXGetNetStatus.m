//
//  RXGetNetStatus.m
//  RXExtenstion
//
//  Created by srx on 16/5/26.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import "RXGetNetStatus.h"
#import "RXConstant.h"



#import <objc/message.h>
// 运行时objc_msgSend
#define RXMsgSend(...) ((void (*)(void *, SEL))objc_msgSend)(__VA_ARGS__)
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
        //1 -- 可以用 -- 来源MJRefresh而来的    
        RXMsgSend(RXMsgTarget(self.rxGetNetTarget), self.rxGetNetAction);
        
        //2 因为performSelector的选择器未知可能会引起泄漏），为什么在ARC模式下会出现这个警告？
        //PerformSelector may cause a leak because its selector is unkown;
        //        [self.rxGetNetTarget performSelector:self.rxGetNetAction withObject:self];
        
        //3 -- 可以用 感觉还是第一个好（指针函数方法）
        //        IMP imp = [self.rxGetNetTarget methodForSelector:self.rxGetNetAction];
        //        void (*func)(id, SEL) = (void *)imp;
        //        func(self.rxGetNetTarget, self.rxGetNetAction);
    }
}

- (void)getNetworkStatus {
    _netStatus = [RXNetworkCheck shareNetworkCheck].statusString;
}





/*
 http://blog.csdn.net/omgle/article/details/27684917
 1、可变参数宏__VA_ARGS__
 2、在Objective-C中，message与方法的真正实现是在执行阶段绑定的，而非编译阶段。编译器会将消息发送转换成对objc_msgSend方法的调用。
 
     objc_msgSend方法含两个必要参数：receiver、方法名（即：selector），如：
     [receiver message]; 将被转换为：objc_msgSend(receiver, selector);
     
     objc_msgSend方法也能hold住message的参数，如：
     objc_msgSend(receiver, selector, arg1, arg2, …);
     
     objc_msgSend方法会做按照顺序进行以下操作，以完成动态绑定：
     查找selector所指代的程序（方法的真正实现）。因为不同类对同一方法有不同的实现，所以对方法的真正实现的查找依赖于receiver的类
     调用该实现，并将一系列参数传递过去
     将该实现的返回值作为自己的返回值，返回之
 */

@end
