//
//  RXNavBaseController.m
//  RXExtenstion
//
//  Created by srx on 16/5/3.
//  Copyright © 2016年 srxboys. All rights reserved.
//
/*
 https://github.com/srxboys
 
 项目基本框架
 */

#import "RXNavBaseController.h"

@implementation RXNavBaseController
-(BOOL)shouldAutorotate
{
    return [[self.viewControllers lastObject] shouldAutorotate];
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [[self.viewControllers lastObject] preferredInterfaceOrientationForPresentation];
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [[self.viewControllers lastObject] supportedInterfaceOrientations];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if(self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    if(self && viewController) {
        [super pushViewController:viewController animated:animated];
    }
}


@end
