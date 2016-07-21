//
//  NSError+RXString.h
//  RXSession
//
//  Created by srx on 16/7/20.
//  Copyright © 2016年 srxboys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSError (RXString)
/** 自定义错误信息 */
+ (NSError *)errorObjec:(id)object Desc:(NSString *)desc;

/** 自定义更多错误信息， 对于字典内部是否为空需要在调用时处理 */
+ (NSError *)errorObjec:(id)object infoDictionary:(NSDictionary *)dict;
@end
