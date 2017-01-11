//
//  RXTabBarController.h
//  RXExtenstion
//
//  Created by srx on 16/5/3.
//  Copyright © 2016年 srxboys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RXTabBarController : UITabBarController

/**
 切换tabBarItem 并是 seletedIndex的第一viewController
 内部不调用，供外部调用
 */
- (void)tabBarControllSelectedIndex:(NSInteger)index;

@end


/*
    tabBar拿出来定义，为了 多人开发避免git/svn 冲突
    
    对于不会解决 stroyboard 冲突的，是很好的
 */