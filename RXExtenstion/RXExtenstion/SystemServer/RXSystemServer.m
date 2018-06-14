//
//  RXSystemServer.m
//  RXExtenstion
//
//  Created by srx on 16/6/3.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import "RXSystemServer.h"
#import <MessageUI/MessageUI.h>
#import "AppDelegate.h"
#import "RXConstant.h"

#import "RXAlert.h" //下面用了3种方式 实现(注意哦😯)

#import <StoreKit/StoreKit.h>


#define RXSystemServer_share [RXSystemServer shareRXSystemServer]

@interface RXSystemServer ()<
MFMailComposeViewControllerDelegate,
MFMessageComposeViewControllerDelegate,
SKStoreProductViewControllerDelegate
>

@end

@implementation RXSystemServer
//+ (RXSystemServer *)shareRXSystemServer {
//    ... 实现 单例
//}
DEFINE_SINGLETON_FOR_CLASS(RXSystemServer)


- (void)openURL:(NSString*)urlString {
    NSURL *url = [NSURL URLWithString:urlString];
    if([[UIApplication sharedApplication] canOpenURL:url])
    {
        [self closeAllKeyboard];
        
        if(iOS10OrLater) {
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
                
            }];
        }
        else{
            [[UIApplication sharedApplication] openURL:url];
        }
    }
}

- (void)callTelephone:(NSString*)number {
    /*
    NSString *deviceType = [UIDevice currentDevice].model;
    if([deviceType  isEqualToString:@"iPod touch"]||[deviceType  isEqualToString:@"iPad"]||[deviceType  isEqualToString:@"iPhone Simulator"])
    {
        RXAlert *alert = [[RXAlert alloc] initWithTitle:@"您的设备不能打电话"
                                                message:nil
                                      cancelButtonTitle:@"确定"
                                      otherButtonTitles:nil];
        [alert show];
        return;
    }
    */
    if(SIMULATOR_TEST) {
        RXAlert *alert = [[RXAlert alloc] initWithTitle:@"您的设备不能打电话"
                                                message:nil
                                      cancelButtonTitle:@"确定"
                                      otherButtonTitles:nil];
        [alert show];
    }
    else {
        if (number.length == 0) return;
        
        NSString *urlStr = [NSString stringWithFormat:@"tel://%@", number];
        [self openURL:urlStr];
    }
}

#pragma mark - Send Email

- (void)sendEmailTo:(NSArray*)emailAddresses withSubject:(NSString*)subject andMessageBody:(NSString*)emailBody
{
    [self closeAllKeyboard];
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
        picker.mailComposeDelegate = self;
        [picker setSubject:subject];//邮件主题
        [picker setToRecipients:emailAddresses];//设置发送给谁，参数是NSarray
//        picker setCcRecipients:<#(nullable NSArray<NSString *> *)#> //可以添加抄送
        
        // Attach an image to the email
        //        NSString *path = [[NSBundle mainBundle] pathForResource:@"rainy" ofType:@"jpg"];
        //        NSData *myData = [NSData dataWithContentsOfFile:path];
        //        [picker addAttachmentData:myData mimeType:@"image/jpeg" fileName:@"rainy"];
        
        [picker setMessageBody:emailBody isHTML:NO];//设置邮件正文内容
        if(!picker) return;
        [SharedAppDelegate.window.rootViewController presentViewController:picker animated:YES completion:NULL];
    }
    else
    {
        RXAlert * alert = [RXAlert new];
        alert.title = @"您的设备没有配置邮箱帐号";
        alert.cancelButtonTitle = @"确定";
        [alert show];
    }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
//            [SharedAppDelegate.window makeToast:@"邮件已取消"];
            //            [SharedAppDelegate.window showToastWithDuration:1.0f message:@"邮件已取消" isSuccessToast:NO];
            break;
        case MFMailComposeResultSaved:
//            [SharedAppDelegate.window makeToast:@"邮件已保存"];
            //            [SharedAppDelegate.window showToastWithDuration:1.0f message:@"邮件已保存" isSuccessToast:YES];
            break;
        case MFMailComposeResultSent:
//            [SharedAppDelegate.window makeToast:@"邮件发送成功"];
            //            [SharedAppDelegate.window showToastWithDuration:1.0f message:@"邮件发送成功" isSuccessToast:YES];
            break;
        case MFMailComposeResultFailed:
//            [SharedAppDelegate.window makeToast:@"邮件发送失败"];
            //            [SharedAppDelegate.window showToastWithDuration:1.0f message:@"邮件发送失败" isSuccessToast:NO];
            break;
        default:
            break;
    }
    
    [SharedAppDelegate.window.rootViewController dismissViewControllerAnimated:YES completion:NULL];
}


#pragma mark - Send Message

- (void)sendMessageTo:(NSArray*)phoneNumbers withMessageBody:(NSString*)messageBody
{
    [self closeAllKeyboard];

    if(![MFMessageComposeViewController canSendText]) {
     //检测是否可用，然后自己设置弹框
        [RXAlert showAlertWithTitle:@"您的设备不能发短信"
                            message:nil
                  cancelButtonTitle:@"确定"
                  otherButtonTitles:nil cancelHandler:nil dismissHandler:nil];
        return;
    }
    MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
    picker.messageComposeDelegate = self;
    picker.recipients = phoneNumbers;
    picker.body = messageBody;
    if(!picker) {
        return;
    }
    [SharedAppDelegate.window.rootViewController presentViewController:picker animated:YES completion:NULL];
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller
                 didFinishWithResult:(MessageComposeResult)result
{
    [self closeAllKeyboard];
    switch (result)
    {
        case MessageComposeResultCancelled:
//            [SharedAppDelegate.window makeToast:@"短消息已取消"];
            //            [SharedAppDelegate.window showToastWithDuration:1.0f message:@"短消息已取消" isSuccessToast:YES];
            break;
        case MessageComposeResultSent:
//            [SharedAppDelegate.window makeToast:@"短消息已发送"];
            //            [SharedAppDelegate.window showToastWithDuration:1.0f message:@"短消息已发送" isSuccessToast:YES];
            break;
        case MessageComposeResultFailed:
//            [SharedAppDelegate.window makeToast:@"短消息发送失败"];
            //            [SharedAppDelegate.window showToastWithDuration:1.0f message:@"短消息发送失败" isSuccessToast:NO];
            break;
        default:
            break;
    }
    
    [SharedAppDelegate.window.rootViewController dismissViewControllerAnimated:YES completion:nil];
}


- (void)closeAllKeyboard {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}


- (void)openAppleStoreProduct {
    
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    
    SKStoreProductViewController * skStorePVC = [[SKStoreProductViewController alloc] init];
    skStorePVC.delegate = self;
    
    void(^complete)(void) = ^(void) {
        if ([[NSThread currentThread] isMainThread]) {
            [SharedAppDelegate.window.rootViewController presentViewController:skStorePVC animated:YES completion:NULL];
        }
        else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [SharedAppDelegate.window.rootViewController presentViewController:skStorePVC animated:YES completion:NULL];
            });
        }
    };
    
    [skStorePVC loadProductWithParameters:@{SKStoreProductParameterITunesItemIdentifier:APPSTORE_ID}
                            completionBlock:^(BOOL result, NSError *error) {
                                if(!error) {
                                    complete();
                                }
     }];
}

- (void)openAppleStoreComment {
    //仅支持iOS10.3+（需要做校验） 且每个APP内每年最多弹出3次评分start
    if([SKStoreReviewController respondsToSelector:@selector(requestReview)]) {
        //防止键盘遮挡
        [[UIApplication sharedApplication].keyWindow endEditing:YES];
        [SKStoreReviewController requestReview];
        
    } else {
        //不论iOS 版本均可使用APP内部打开网页形式，跳转到App Store 直接编辑评论
        NSString *nsStringToOpen = [NSString stringWithFormat: @"itms-apps://itunes.apple.com/app/id%@?action=write-review",APPSTORE_ID];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:nsStringToOpen]];
    }
}

- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController {
    [SharedAppDelegate.window.rootViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
