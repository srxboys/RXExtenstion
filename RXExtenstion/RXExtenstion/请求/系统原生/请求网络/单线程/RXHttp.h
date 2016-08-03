//
//  RXHttp.h
//  RXExtenstion
//
//  Created by srx on 16/7/21.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RXHttp : NSObject

/**
 *  <#Description#>
 *
 *  @param urlString  <#urlString description#>
 *  @param params     <#params description#>
 *  @param completion <#completion description#>
 */
+ (void)postWithURLString:(NSString *)urlString params:(NSDictionary *)params completion:(void (^)(id object, NSString * errorDesc))completion;
@end


/*
 1  普通 pos请求处理
 */
