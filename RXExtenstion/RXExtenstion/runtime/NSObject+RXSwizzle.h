//
//  NSObject+RXSwizzle.h
//  RXExtenstion
//
//  Created by srxboys on 2018/12/12.
//  Copyright © 2018 https://github.com/srxboys. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (RXSwizzle)
/// 交换方法
+ (void)swizzleClass:(Class)aClass origSel:(SEL)origSel withMethod:(SEL)insertSel;

void swizzleClass(Class aClass, SEL origSel, SEL insertSel);

/// 判断是否支持 以前的方法能被执行
BOOL ENABLE_CLASS_METHOD(Class aClass, SEL origSel, SEL insertSel);

@end

NS_ASSUME_NONNULL_END
