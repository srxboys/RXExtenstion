//
//  AppDelegate.h
//  RXExtenstion
//
//  Created by srx on 16/4/29.
//  Copyright © 2016年 srxboys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

#pragma mark - ~~~~~~~~~~~ 3D-Touch ~~~~~~~~~~~~~~~
- (void)checkShortcutItem;
- (void)setShortcutItem:(NSArray *)array;


/** 在键盘上弹toash //针对系统、第三方键盘的处理 */
- (void)showOnWindowMessage:(NSString *)message;
- (void)hiddenOnWindowMessage;

/** 关闭所有键盘 */
- (void)closeAllKeyboard;

/** 清除UIWebView的缓存//准确的说 是清除请求缓存 */
- (void) cleanCache;

/** 清除 cookies */
- (void)cleanCookies;
@end

