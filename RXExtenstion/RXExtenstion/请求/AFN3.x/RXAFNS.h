//
//  RXAFNS.h
//  RXExtenstion
//
//  Created by srx on 16/4/29.
//  Copyright © 2016年 srxboys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface Response : NSObject
@property (nonatomic, copy)   NSString * message;
@property (nonatomic, copy)   NSArray  * returndata;
@property (nonatomic, assign) BOOL       status;
+ (Response*)responseWithDict:(NSDictionary*)dict;
@end

@interface RXAFNS : NSObject
/**
 * @author ----------, 16-03-01 12:03:55
 *
 * @brief 请求数据接口，block返回结果
 *
 * @param paramsDict   请求参数(字典)
 * @param successBlock 请成功，以block形式返回
 * @param failureBlock 请求失败，以block形式返回
 * @param showHUD      是否显示 加载的状态【转圈】
 */
+ (void)postReqeustWithParams:(NSDictionary*)paramsDict
                 successBlock:(void (^)(Response * responseObject))successBlock
                 failureBlock:(void (^)(NSError * error))failureBlock
                      showHUD:(BOOL)showHUD loadingInView:(UIView *)view;


/**
 *  @author srxboys, 16-03-25 15:03:46
 *
 *  @brief 上传文件并请求接口
 *
 *  @param paramsDict      请求参数(字典)
 *  @param uploadParamsDIY 上传文件/多文件到服务器的文件设置(自定义)
 *  @param successBlock    请成功，以block形式返回
 *  @param failureBlock    请求失败，以block形式返回
 *  @param showHUD         是否显示 加载的状态【转圈】
 */
+ (void)UploadDIYRequestWithParams:(NSDictionary*)paramsDict
                   uploadParamsDIY:(void (^)(id <AFMultipartFormData> formData))uploadParamsDIY
                      successBlock:(void (^)(Response * responseObject))successBlock
                      failureBlock:(void (^)(NSError * error))failureBlock
                           showHUD:(BOOL)showHUD loadingInView:(UIView *)view;


//移除请求
+ (void)removeRequestWithParams:(NSDictionary *)paramsDict;
@end
