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
#import "NSObject+RXSwizzle.h"

@interface RXNavBaseController ()<UINavigationControllerDelegate>
@property (nonatomic, assign) BOOL pushing;
@end

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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
}

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        self.delegate = self; //默认代理设置Self
    }
    return self;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if(self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;

        if(!self.pushing) {
            return;
        }
        self.pushing = NO;
    }
    
    if(self && viewController) {
        [super pushViewController:viewController animated:animated];
    }
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    self.pushing = NO;
}

- (void)hook_navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    self.pushing = NO;
    if(ENABLE_CLASS_METHOD([self class], @selector(navigationController:didShowViewController:animated:), @selector(hook_navigationController:didShowViewController:animated:)))  {
        [self hook_navigationController:navigationController didShowViewController:viewController animated:animated];
    }
}


- (void)setDelegate:(id<UINavigationControllerDelegate>)delegate {
    [super setDelegate:delegate];
    
    if(delegate && ![self isEqual:delegate]) {
        Class class = [delegate class];
        
        //如果已经实现过了呢？
        swizzleClass(class, @selector(navigationController:didShowViewController:animated:), @selector(hook_navigationController:didShowViewController:animated:));
    }
}

@end
