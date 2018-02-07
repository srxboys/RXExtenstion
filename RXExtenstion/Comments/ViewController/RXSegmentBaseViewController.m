//
//  RXSegmentViewController.m
//  RXExtenstion
//
//  Created by srxboys on 2018/2/6.
//  Copyright © 2018年 https://github.com/srxboys. All rights reserved.
//

#import "RXSegmentBaseViewController.h"

@interface RXSegmentBaseViewController ()
{
    UISegmentedControl * _segmentedControl;
    UIView * _lineView;
}
@end

@implementation RXSegmentBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _segmentedControl = [[UISegmentedControl alloc] initWithFrame:CGRectMake(15, 5+NavHeight, ViewWidth(self.view)-30, 30)];;
    //样式
    _segmentedControl.layer.borderColor = [UIColor blueColor].CGColor;
    _segmentedControl.layer.borderWidth = 1.0f;
    _segmentedControl.layer.cornerRadius = 4.0f;
    _segmentedControl.layer.masksToBounds = YES;
    [_segmentedControl addTarget:self action:@selector(segmentedControlValueChanged) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_segmentedControl];
    
    _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, ViewBottom(_segmentedControl)+5, ViewWidth(self.view), 0.5)];
    _lineView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_lineView];
    
    if(self.viewControllers.count > 0) {
        for (NSInteger i = 0; i < self.viewControllers.count; i++) {
            UIViewController * vc = self.viewControllers[i];
            if(!vc) continue;
            if(![vc isKindOfClass:[UIViewController class]]) continue;
            ((RXBaseViewController*)vc).showSegmentToNavHidden = YES;
            [_segmentedControl insertSegmentWithTitle:vc.title atIndex:i animated:NO];
        }
        _segmentedControl.selectedSegmentIndex = self.selectedIndex;
         [self segmentedControlValueChanged];
    }
}

- (void)setViewControllers:(NSArray<UIViewController *> *)viewControllers {
    if (_viewControllers != viewControllers) {
        for (UIViewController *vc in _viewControllers) {
            [vc removeFromParentViewController];
            if ([vc isViewLoaded])
                [vc.view removeFromSuperview];
        }
        
        _viewControllers = viewControllers;
        
        if ([self isViewLoaded]) {
            [_segmentedControl removeAllSegments];
            for (int i = 0; i < [self.viewControllers count]; ++i) {
                UIViewController *c = self.viewControllers[i];
                [self addChildViewController:c];
                ((RXBaseViewController*)c).showSegmentToNavHidden = YES;
                [_segmentedControl insertSegmentWithTitle:c.title atIndex:i animated:NO];
            }
            _segmentedControl.selectedSegmentIndex = self.selectedIndex;
            [self segmentedControlValueChanged];
        }
    }
}

- (void)segmentedControlValueChanged
{
    // http://stackoverflow.com/questions/2270526/uisegmentedcontrol-selected-segment-color
    for (UIControl *subview in _segmentedControl.subviews) {
        if ([subview respondsToSelector:@selector(isSelected)] && subview.isSelected) {
            UIColor *tintcolor = [UIColor blueColor];
            if ([subview respondsToSelector:@selector(setTintColor:)])
                [subview setTintColor:tintcolor];
        }
        else {
            if ([subview respondsToSelector:@selector(setTintColor:)])
                [subview setTintColor:nil];
        }
    }
    _selectedIndex = _segmentedControl.selectedSegmentIndex;
    UIViewController *c = self.viewControllers[_selectedIndex];
    if (c.view.superview == nil) {
        c.view.frame = CGRectMake(0, ViewBottom(_lineView), ViewWidth(self.view), ViewHeight(self.view) - ViewBottom(_lineView));
        [self.view addSubview:c.view];
    }
    [self.view bringSubviewToFront:c.view];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    _segmentedControl.frame = CGRectMake(15, 5+NavHeight, ViewWidth(self.view)-30, 30);
    _lineView.frame = CGRectMake(0, ViewBottom(_segmentedControl)+5, ViewWidth(self.view), 0.5);
    
    for (UIViewController *vc in self.viewControllers) {
        if ([vc isViewLoaded]) {
            vc.view.frame = CGRectMake(0, ViewBottom(_lineView), ViewWidth(self.view), ViewHeight(self.view) - ViewBottom(_lineView));
        }
    }
}





- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    if ([self isViewLoaded] && (selectedIndex < [self.viewControllers count])) {
        _segmentedControl.selectedSegmentIndex = selectedIndex;
        [self segmentedControlValueChanged];
    }
    _selectedIndex = selectedIndex;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end






@implementation UIViewController (RXSegmentParentViewController)

- (RXSegmentBaseViewController *)rxSegmentParentViewController {
    UIViewController *controller = self.parentViewController;
    while (controller && ![controller isKindOfClass:[RXSegmentBaseViewController class]])
        controller = [controller parentViewController];
        return (RXSegmentBaseViewController *)controller;
}

@end
