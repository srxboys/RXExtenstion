//
//  RXTouchIDOption.m
//  RXExtenstion
//
//  Created by srx on 2017/9/13.
//  Copyright © 2017年 https://github.com/srxboys. All rights reserved.
//

#import "RXTouchIDOption.h"

#import <LocalAuthentication/LocalAuthentication.h> //导入的包，为option


NSString * const RXTouchIDOptionErrorDomain = @"github.com.srxboys.TouchIDOption";

@interface RXTouchIDOption ()
{
    LAContext *_context;
}
@end

@implementation RXTouchIDOption

- (instancetype)init
{
    self = [super init];
    if (self) {
        //创建LAContext
        _context = [[LAContext alloc] init];
        
        
        //这个主要为了。国际化语言设置的。【我感觉的】
        //指纹弹出框 的【提示信息】
        _context.localizedFallbackTitle = @"没有忘记密码";
        
        //指纹弹框中的"取消" 【按钮】的文本
        if(iOS10OrLater) {
            _context.localizedCancelTitle = @"快取消吧！别嘚瑟!";
        }
        
        //允许设置生物认证期间失败次数的限制。(指纹识别错误超过次数，只会关闭touchID弹框，不会锁定)
        //默认3次。
        _context.maxBiometryFailures = [NSNumber numberWithInteger:2];
        
        //readOnly 指纹数据(evaluatepolicy执行后，才有值) 不建议使用，用户可以更换指纹( 但是我们可以用于第二次的非用户操作指纹解锁)
//        if(iOS9OrLater) {
//            NSData * data = _context.evaluatedPolicyDomainState;
//        }
        
        //默认为5分钟内免指纹识别(就是AppStore下载的样式)(该对象不被销毁才管用)
//        if(iOS9OrLater) {
//            _context.touchIDAuthenticationAllowableReuseDuration = 15;
            ////如果让对象不销毁。操作RXTouchID.h.m 的生命周期。
//        }
        
    }
    return self;
}

- (BOOL)isEnableTouchIDOption {
    BOOL isEnable = NO;
    //是否可用
    NSError * error = nil;
    
    if([_context canEvaluatePolicy:kLAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        isEnable = YES;
    }
    else {
        RXLog(@"%@", error);
    }
    
    return isEnable;
}

- (void)evaluateTouchID:(void(^)(BOOL isSucc,NSError * error, NSString * descri))block {
    if(![self isEnableTouchIDOption]) {
        if(block) {
            NSString * string = @"touchIDOption notEnableError";
            NSDictionary *userInfo = @{@"desc":string};
            NSError * notEnableError = [[NSError alloc] initWithDomain:RXTouchIDOptionErrorDomain code:LAErrorAuthenticationFailed userInfo:userInfo];
            block(NO, notEnableError, string);
        }
        return;
    };
    
    /*
        //LAPolicyDeviceOwnerAuthentication
            //iOS 9 之后锁定指纹识别之后 【指纹错误】,立即弹出输入密码界面需要使用LAPolicyDeviceOwnerAuthentication这个属性重新发起验证，如果密码成功，指纹验证也就成功了。一般不用。
         
         LAPolicyDeviceOwnerAuthenticationWithBiometrics
             //指纹对就是对，错就是错。操作次数的错误，弹框消失。
     
     */
    
    [_context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"请按home键 指纹(或者 识别脸部) 解锁" reply:^(BOOL success, NSError * _Nullable error) {
        NSString * descri = @"成功";
        if (success) {
            RXLog(@"验证成功 刷新主界面");
        }else{
            RXLog(@"%@",error.localizedDescription);
            switch (error.code) {
                case LAErrorSystemCancel:
                {
                    descri = @"系统取消授权，如其他APP切入";
                    
                    break;
                }
                case LAErrorUserCancel:
                {
                    descri = @"用户取消验证Touch ID";
                    
                    break;
                }
                case LAErrorAuthenticationFailed:
                {
                    descri = @"授权失败";
                    
                    break;
                }
                case LAErrorPasscodeNotSet:
                {
                    descri = @"系统未设置密码";
                    
                    break;
                }
                case LAErrorUserFallback:
                {
                    __block NSString *  weakDescri = descri;
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        weakDescri = @"用户选择输入密码，切换主线程处理";
                        RXLog(@"%@", weakDescri);
                    }];
                    break;
                }
                default:
                {
                    #define RXAdjustLAErrorInIOS11(iOS11Error, olderError) ({   \
                        LAError _$_error = 0;  \
                        if (@available(iOS 11.0, *)) {  \
                            _$_error = iOS11Error;     \
                        }   \
                        else {  \
                            _$_error = olderError;    \
                        }   \
                        _$_error;    \
                    })
                    
                    if(error.code == RXAdjustLAErrorInIOS11(LAErrorBiometryNotAvailable, LAErrorTouchIDNotAvailable)) {
                        descri = @"设备Touch ID / FaceID 不可用，例如未打开";
                        break;
                    }
                    else if(error.code == RXAdjustLAErrorInIOS11(LAErrorBiometryNotEnrolled, LAErrorTouchIDNotEnrolled)) {
                        descri = @"设备Touch ID / FaceID 不可用，用户未录入";
                        break;
                    }
                    else if(error.code == RXAdjustLAErrorInIOS11(LAErrorBiometryLockout, LAErrorTouchIDLockout)) {
                        descri = @"设备Touch ID / FaceID 已被锁定，稍后再试";
                        break;
                    }
                    else {
                        __block NSString *  weakDescri = descri;
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            weakDescri = @"其他情况，切换主线程处理";
                            RXLog(@"%@", weakDescri);
                        }];
                        break;
                    }
                }
            }
        }
        
        RXLog(@"%@", descri);
        block(success, error, descri);
        
        //在次object 没有销毁的情况下，使用此方法管用。否则 设不设置都是销毁所有。
        [_context invalidate];
        
        
        //如果让对象不销毁。操作RXTouchID.h.m 的生命周期
    }];
}



//未实现的 功能

- (void)noUseEvaluateTouchID {
    if(![self isEnableTouchIDOption]) return;
    
    
    //针对用户 touchID.data 解锁额外加密凭证【 >=iOS9 】
    NSData * data = _context.evaluatedPolicyDomainState;
    
    //【 >=iOS9 】
    BOOL result = [_context setCredential:data type:LACredentialTypeApplicationPassword];
    
    //【 >=iOS9 】
    result = [_context isCredentialSet:LACredentialTypeApplicationPassword];
    
    //touch ID 后 额外加密 【 >=iOS9 】
    //_context evaluateAccessControl:<#(nonnull SecAccessControlRef)#> operation:<#(LAAccessControlOperation)#> localizedReason:<#(nonnull NSString *)#> reply:<#^(BOOL success, NSError * _Nullable error)reply#>
    
    
}



@end
