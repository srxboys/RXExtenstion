//
//  RXTabBarController.m
//  RXExtenstion
//
//  Created by srx on 16/5/3.
//  Copyright © 2016年 srxboys. All rights reserved.
//

#import "RXTabBarController.h"
#import "RXNavBaseController.h"
#import "RXBaseViewController.h"
#import "RXCharacter.h"

#import "RXHomeController.h"
#import "RXLocationController.h"
#import "RXMineViewController.h"

@interface RXTabBarController ()<UITabBarControllerDelegate>
{
    RXHomeController     * _home;
    RXMineViewController * _mine;
    RXLocationController * _location;
    
    __weak RXBaseViewController * _currentController;
}

//当前 页面 0 ~
@property (nonatomic, assign) NSInteger tempIndex;

@end

@implementation RXTabBarController


-(BOOL)shouldAutorotate
{
    return [self.selectedViewController shouldAutorotate];
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [self.selectedViewController preferredInterfaceOrientationForPresentation];
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [self.selectedViewController supportedInterfaceOrientations];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavsToTabBar];
}


- (void) addNavsToTabBar {
    self.delegate = self;
    
    //标签栏 标题的 颜色
    [self toTabBar_Font_color];
    
    _home = RXStroyBoard(@"Home", @"RXHomeController");
    [self setNavRootViewControll:_home titleStr:@"srxboys -> RX" imagePath:@"tab_0" selectedImagePath:@"tab_0_h"];
    
    _currentController = _home;
    
    _location = RXStroyBoard(@"Location", @"RXLocationController");
    [self setNavRootViewControll:_location titleStr:@"定位" imagePath:@"tab_0" selectedImagePath:@"tab_0_h"];
    
    _mine = RXStroyBoard(@"Mine", @"RXMineViewController");
    [self setNavRootViewControll:_mine titleStr:@"我" imagePath:@"tab_4" selectedImagePath:@"tab_4_h"];

}

/**
 * @author ----------, 16-05-03 13:03:01
 *
 * @brief 设置viewController并添加到UITabBarViewControll
 *
 * @param viewController    VC控制器
 * @param title             tab标题、nav标题
 * @param imagePath         默认图片
 * @param selectedImagePath 选中、点击 是的图片
 */
- (void )setNavRootViewControll:(RXBaseViewController *)viewController titleStr:(NSString *)title imagePath:(NSString *)imagePath selectedImagePath:(NSString *)selectedImagePath {
    
    //tabBar图片渲染有个默认的值，改成UIImageRenderingModeAlwaysOriginal，就是图片本身图，否则会渲染【tint.color  灰--蓝(色)】
    UIImage * image = [[UIImage imageNamed:imagePath] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage * selectImage = [[UIImage imageNamed:selectedImagePath]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //viewControll导航栏标题
    viewController.navigationItem.title = title;
    
    //标签栏的标题
    viewController.tabBarItem.title = title;
    //    //标签栏默认图片
    viewController.tabBarItem.image = image;
    //标签栏选中时的图片
    viewController.tabBarItem.selectedImage = selectImage;
    
    // 控制器放到 导航栏控制器中
    RXNavBaseController * nav = [[RXNavBaseController alloc] initWithRootViewController:viewController];
    
    //导航栏放到 标签栏
    [self addChildViewController:nav];
    
}



- (void) toTabBar_Font_color {
    
    //改变字的颜色
    
    //默认颜色
    [UITabBarItem.appearance setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:UIColorRGB(0, 0, 0), NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    
    //选中颜色
    [UITabBarItem.appearance setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:UIColorRGB(127, 16, 133), NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];
    
}



-(void)setSelectedIndex:(NSUInteger)selectedIndex{
    [super setSelectedIndex:selectedIndex];
    self.tempIndex = selectedIndex;
    RXLog(@"tabBar.selectedIndex=%zd", selectedIndex);
}

//点击tabBar上的ViewController时调用，为了以后
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    RXNavBaseController * navVC = (RXNavBaseController *)viewController;
    
    _currentController = [navVC.viewControllers firstObject];
    
    RXLog(@"tabBar didSelect class=%@", NSStringFromClass([navVC.viewControllers[0] class]));
}

-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    
    /** 默认是YES
     * 点击的不是当前页面， 有需求判断用户登录时，没有登录，并不登录，就不展示页面
     * 返回的界面是 self.tempIndex
     *  return NO;
     */
    
    return YES;
}

- (void)tabBarControllSelectedIndex:(NSInteger)index {
    if(self.viewControllers.count <= index) return;
    
    RXBaseViewController * baseCurrentController = _currentController;
    
    RXNavBaseController * navigation =((RXNavBaseController *)(self.viewControllers[index]));
    navigation.viewControllers = @[[navigation.viewControllers firstObject]];
    self.selectedIndex = index;
    
    [baseCurrentController.navigationController popToRootViewControllerAnimated:NO];
}


@end
