//
//  AppDelegate.m
//  RXExtenstion
//
//  Created by srx on 16/4/29.
//  Copyright © 2016年 srxboys. All rights reserved.
//

#import "AppDelegate.h"

#import "RXTabBarController.h"
#import "RXNetworkCheck.h"
#import "RXPrisonBreak.h"
#import "RXBundle.h"
#import "RXConstant.h"
#import "RXShortcutItem.h"
#import "TTCacheUtil.h"

#import "RXUUID.h"

@interface AppDelegate ()
{
    UIWindow     * _messageWindow;
    UILabel      * _messageLabel;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = [UIColor whiteColor];
//
    RXTabBarController * tabBarController = RXStroyBoard(@"Main", @"RXTabBarController");
    _window.rootViewController = tabBarController;
    
//    id pickerView = [[NSClassFromString(@"RXPickerView") alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    
    //监测手机版本——存储在沙盒
    [RXBundle bundlePhoneVersionCheck];
    
    //监测是否初始化 3D Touch
    [self checkShortcutItem];
    
    //监听网络
    [RXNetworkCheck getNetworkStatus];
    
    //判断是否越狱
    [RXPrisonBreak prisonBreakCheck];
    
    //uuid
    [UserDefaults setObject:[RXUUID getUMSUDID] forKey:App_deviceUDID];
    [UserDefaults synchronize];
    
    [_window makeKeyAndVisible];
    return [self applicationClick3DTouch:launchOptions];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - ~~~~~~~~~~~ 3D-Touch ~~~~~~~~~~~~~~~
- (void)checkShortcutItem {
    if(!iOS9OrLater) {
        RXLog(@"iOS < 9 不能用 3D touch");
        return;
    }
    
//    if(![RXBundle boundPhone6sLater]) {
//        return;//这个判断设备是不是支持3D Touch
        //由于我的设备不多，就没 较真
//    }
    //删除
//    [RXShortcutItem removeLocalData];
    
    //获取
    NSArray * array = [RXShortcutItem readerLocalData];
    
    
    if(array.count > 0 && array != nil) {
        //有数据，就不做判断,,在设置页面就有
        //在没有改变 3D-touch选项时，就不用第二次赋值
        return;
    }
    
    // 3D-Touch 默认值
    NSMutableArray * mutableArray = [[NSMutableArray alloc] init];
    
    for(NSInteger i = 0; i < 4; i++) {
        //最好用自定义图片的，不然还需要判断版本
        RXShortcutItem * model = [[RXShortcutItem alloc] init];
        
        NSInteger  rxIconType = 0;
        NSString * rxItemTitle = nil;
        NSString * rxItemSubTitle = nil;
        
        if(i == 0) {
            //iOS > 9.1
            rxIconType = UIApplicationShortcutIconTypeHome;
            rxItemTitle = @"首页";
            rxItemSubTitle = @"0";
        }
        else if(i == 1) {
            //iOS > 9.0
            rxIconType = UIApplicationShortcutIconTypeSearch;
            rxItemTitle = @"搜索";
            rxItemSubTitle = @"";
        }
        else if(i == 2) {
            //iOS > 9.0
            rxIconType = UIApplicationShortcutIconTypeProhibit;
            rxItemTitle = @"什么";
            rxItemSubTitle = @"2";
        }
        else if (i == 3) {
            //iOS > 9.1
            rxIconType = UIApplicationShortcutIconTypeContact;
            rxItemTitle = @"3D-Touch定制";
            rxItemSubTitle = @"我的-3D touch 定制";
        }
        
        model.rxIconType = rxIconType;
        model.rxItemTitle = rxItemTitle;
        model.rxItemSubTitle = rxItemSubTitle;
        
        [mutableArray addObject:model];
    }
    
    [self setShortcutItem:mutableArray];
    
}

//用数据模型 给3D touch
- (void)setShortcutItem:(NSArray *)array {
    [RXShortcutItem writeLocalDataWithArray:array];
    
    if(array.count <= 0 || array == nil) return;
    
    NSMutableArray * mutableArray = [[NSMutableArray alloc] init];

    for(NSInteger i = 0; i < array.count; i++){
        RXShortcutItem * model = array[i];
        
        if(model.rxHidden || model.rxItemTitle.length <= 0) {
            continue;
        }
        
        UIApplicationShortcutIcon *icon = [UIApplicationShortcutIcon iconWithType:model.rxIconType];
        
        //创建快捷选项
        UIApplicationShortcutItem * item = [[UIApplicationShortcutItem alloc]initWithType:STRING_OF_INT(i) localizedTitle:model.rxItemTitle localizedSubtitle:model.rxItemSubTitle icon:icon userInfo:nil];
        
        [mutableArray addObject:item];
    }
    
    //添加到快捷选项数组
    [UIApplication sharedApplication].shortcutItems = mutableArray;
}

- (BOOL)applicationClick3DTouch:(NSDictionary *)launchOptions {
    if(!iOS9OrLater) {
        return YES;
    }
    
    UIApplicationShortcutItem *shortcutItem = [launchOptions valueForKey:UIApplicationLaunchOptionsShortcutItemKey];
    //如果是从快捷选项标签启动app，则根据不同标识执行不同操作，然后返回NO，防止调用- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler
    if (shortcutItem) {
        //判断先前我们设置的快捷选项标签唯一标识，根据不同标识执行不同操作
//        if([shortcutItem.type isEqualToString:@"com.mycompany.myapp.one"]){
//            NSArray *arr = @[@"hello 3D Touch"];
//            UIActivityViewController *vc = [[UIActivityViewController alloc]initWithActivityItems:arr applicationActivities:nil];
//            [self.window.rootViewController presentViewController:vc animated:YES completion:^{
//            }];
//        } else if ([shortcutItem.type isEqualToString:@"com.mycompany.myapp.search"]) {//进入搜索界面
//            SearchViewController *childVC = [storyboard instantiateViewControllerWithIdentifier:@"searchController"];
//            [mainNav pushViewController:childVC animated:NO];
//        } else if ([shortcutItem.type isEqualToString:@"com.mycompany.myapp.share"]) {//进入分享界面
//            SharedViewController *childVC = [storyboard instantiateViewControllerWithIdentifier:@"sharedController"];
//            [mainNav pushViewController:childVC animated:NO];
//        }
        return NO;
    }
    return YES;
}

//不是启动的 点击3D-touch
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
    
    RXTabBarController * tabBarController = RXStroyBoard(@"Main", @"RXTabBarController");
    _window.rootViewController = tabBarController;
    [self.window makeKeyAndVisible];
    
    if(shortcutItem != nil) {
        NSArray * array = [TTCacheUtil objectFromFile:RXShortcutItemLocalArray];
        if(array.count <= 0) {
            if (completionHandler) {
                completionHandler(YES);
            }
            //没有数据模型，可以跳转
            return;
        }
        
        NSInteger i = [shortcutItem.type integerValue];
        NSDictionary * dict = array[i];
        NSInteger  rxIconType = [dict[@"rxIconType"] integerValue];
//        NSString * rxItemTitle = dict[@"rxItemTitle"];
//        NSString * rxItemSubTitle = dict[@"rxItemSubTitle"];
        
        ///这里主要是判断 入口 是首页、我的
        
        if(rxIconType == UIApplicationShortcutIconTypeHome) {
            //首页
            RXLog(@"首页");
        }
        else if(rxIconType == UIApplicationShortcutIconTypeSearch) {
            //搜索
            RXLog(@"搜索");
        }
        else if (rxIconType == UIApplicationShortcutIconTypeProhibit) {
            //什么
            RXLog(@"什么");
        }
        else if (rxIconType == UIApplicationShortcutIconTypeContact) {
            //3D-touch定制
            RXLog(@"3D-touch定制");
        }
        
        
    }
    
    //判断先前我们设置的快捷选项标签唯一标识，根据不同标识执行不同操作
    if([shortcutItem.type isEqualToString:@"com.mycompany.myapp.one"]){
        NSArray *arr = @[@"hello 3D Touch"];
        UIActivityViewController *vc = [[UIActivityViewController alloc]initWithActivityItems:arr applicationActivities:nil];
        [self.window.rootViewController presentViewController:vc animated:YES completion:^{
        }];
    } else if ([shortcutItem.type isEqualToString:@"com.mycompany.myapp.search"]) {//进入搜索界面
//        SearchViewController *childVC = [storyboard instantiateViewControllerWithIdentifier:@"searchController"];
//        [mainNav pushViewController:childVC animated:NO];
    } else if ([shortcutItem.type isEqualToString:@"com.mycompany.myapp.share"]) {//进入分享界面
//        SharedViewController *childVC = [storyboard instantiateViewControllerWithIdentifier:@"sharedController"];
//        [mainNav pushViewController:childVC animated:NO];
    }
    
    if (completionHandler) {
        completionHandler(YES);
    }
}





/// 在键盘上的 window 显示 message
- (void)configMessageWindow {
    _messageWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _messageWindow.backgroundColor = [UIColor clearColor];
    _messageLabel = [[UILabel alloc] init];
    _messageLabel.font = [UIFont systemFontOfSize:16];
    _messageLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0];
    _messageLabel.textColor = [UIColor whiteColor];
    _messageLabel.textAlignment = NSTextAlignmentCenter;
    [_messageWindow addSubview:_messageLabel];
}

- (void)showOnWindowMessage:(NSString *)message {
    UIWindow *view = [[[UIApplication sharedApplication] delegate] window];
    CGFloat level = view.windowLevel;
    NSArray *windows = [UIApplication sharedApplication].windows;
    for (UIWindow * windowView in windows) {
        if(windowView.windowLevel > view.windowLevel) {
            level = windowView.windowLevel;
        }
    }
    _messageWindow.windowLevel = level + 1;
    
    _messageLabel.text = message;
    CGFloat height = [_messageLabel textRectForBounds:CGRectMake(0, 0, 300, CGFLOAT_MAX) limitedToNumberOfLines:0].size.height;
    
    if(height < 50) {
        height = 50;
    }
    else {
        height += 10;
    }
    
    CGFloat top = round((ScreenHeight - height)/2);
    _messageLabel.frame = CGRectMake((ScreenWidth - 300)/2, top, 300, height);
    _messageWindow.hidden = NO;
    [_messageWindow makeKeyAndVisible];
    
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^{
        _messageLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    } completion:^(BOOL finished) {
        [weakSelf performSelector:@selector(hiddenOnWindowMessage) withObject:nil afterDelay:2];
    }];
    
}

- (void)hiddenOnWindowMessage {
    _messageWindow.hidden = YES;
    _messageLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0];
    [self.window makeKeyAndVisible];
}

- (void) cleanCache {
    //清除UIWebView的缓存//准确的说 是清除请求缓存
    NSURLCache * cache = [NSURLCache sharedURLCache];
    [cache removeAllCachedResponses];
    [cache setDiskCapacity:0];
    [cache setMemoryCapacity:0];
}

- (void)cleanCookies {
    //清除 cookies
    NSHTTPCookie * cookie;
    NSHTTPCookieStorage * storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies]) {
        [storage deleteCookie:cookie];
    }
}

- (void)closeAllKeyboard {
    /*
     关闭键盘的，简单写法
     1、在控制器页面，想关闭键盘
        [self.view endEditing:YES];
     2、在view页面
         [self endEditing:YES];
     
     3、在非view里面，关闭键盘，就使用下面的
     */
    for (UIWindow* window in [UIApplication sharedApplication].windows)
    {
        for (UIView* view in window.subviews)
        {
            [self dismissAllKeyBoardInView:view];
        }
    }
}

- (BOOL)dismissAllKeyBoardInView:(UIView *)view {
    if([view isFirstResponder])
    {
        [view resignFirstResponder];
        return YES;
    }
    for(UIView *subView in view.subviews)
    {
        if([self dismissAllKeyBoardInView:subView])
        {
            return YES;
        }
    }
    return NO;
}


@end
