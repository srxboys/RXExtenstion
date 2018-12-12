//
//  NSObject+RXSwizzle.m
//  RXExtenstion
//
//  Created by srxboys on 2018/12/12.
//  Copyright © 2018 https://github.com/srxboys. All rights reserved.
//

#import "NSObject+RXSwizzle.h"
#import <objc/runtime.h>

@implementation NSObject (RXSwizzle)

+ (void)swizzleClass:(Class)aClass origSel:(SEL)origSel withMethod:(SEL)insertSel {
    if(!aClass) return;
    Method originMethod = class_getInstanceMethod(aClass, origSel);
    Method insertMethod = class_getInstanceMethod(aClass, insertSel);
    
    if(!originMethod) return;
    if(!insertMethod) return;
    
    BOOL didAddMethod = class_addMethod(aClass, insertSel, method_getImplementation(insertMethod), method_getTypeEncoding(insertMethod));
    if(didAddMethod) {
        //添加后替换
        class_replaceMethod(aClass,
                            insertSel,
                            method_getImplementation(originMethod),
                            method_getTypeEncoding(originMethod));
        //效果是  以前的方法执行地址是 insertSel方法地址 ， insertSel方法的执行地址 是 nil
    }
    else {
        // 交换实现
        method_exchangeImplementations(originMethod, insertMethod);
    }
}

// 是否支持
BOOL ENABLE_CLASS_METHOD(Class aClass, SEL origSel, SEL insertSel) {
    if(!aClass) return NO;
    Method originMethod = class_getInstanceMethod(aClass, origSel);
    IMP oriImp = method_getImplementation(originMethod);
    if(!oriImp) return NO;
    
    Method insertMethod = class_getInstanceMethod(aClass, insertSel);
    IMP aftImg = method_getImplementation(insertMethod);
    
    if(!aftImg) return NO;
    
    if( oriImp == aftImg) {
        // replace `at same a place` ==> class_replaceMethod
        return NO;
    }
    
    //是 method_exchangeImplementations
    return YES;
}

@end
