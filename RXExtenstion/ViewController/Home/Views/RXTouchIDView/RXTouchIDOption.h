//
//  RXTouchIDOption.h
//  RXExtenstion
//
//  Created by srx on 2017/9/13.
//  Copyright © 2017年 https://github.com/srxboys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RXTouchIDOption : NSObject
- (BOOL)isEnableTouchIDOption;
- (void)evaluateTouchID:(void(^)(BOOL isSucc,NSError * error, NSString * descri))block;
@end
