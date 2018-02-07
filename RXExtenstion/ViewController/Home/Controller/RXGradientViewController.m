//
//  RXGradientViewController.m
//  RXExtenstion
//
//  Created by srxboys on 2018/1/30.
//  Copyright © 2018年 https://github.com/srxboys. All rights reserved.
//
//渐变

#import "RXGradientViewController.h"

#import "RXGradient_Graphics.h"
#import "RXGradient_LayerColor.h"

@interface RXGradientViewController ()
@property (nonatomic, strong) UIImageView * gradientImgView0;

@property (nonatomic, strong) UIImageView * gradientImgView1;
@property (nonatomic, strong) UIImageView * gradientImgView2;
@end

@implementation RXGradientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"渐变";
    [self configUI];
}

- (void)configUI {
    self.gradientImgView0 = [self getImgView];
    SET_VIEW_TOP(self.gradientImgView0, 100);
//    self.gradientImgView0.image = [RXGradient_Graphics imageBgCoreGraphicsWithSize:self.gradientImgView0.frame.size];
    self.gradientImgView0.image = [RXGradient_Graphics imageBgCoreGraphicsHorizontalStyleWithSize:self.gradientImgView0.frame.size];
    
    
    self.gradientImgView1 = [self getImgView];
    SET_VIEW_TOP(self.gradientImgView1, 180);
    CAGradientLayer *gradientLayer = [RXGradient_LayerColor gradientLayerWithHorizontalStyle];
    gradientLayer.frame = self.gradientImgView1.bounds;
//    gradientLayer.colors = @[(__bridge id)UIColorHex(0x2e8cda).CGColor, (__bridge id)UIColorHex(0x1bb1ff).CGColor];
    gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor, (__bridge id)[UIColor orangeColor].CGColor];
    [self.gradientImgView1.layer insertSublayer:gradientLayer atIndex:0];
    
    
    
    
    self.gradientImgView2 = [self getImgView];
    SET_VIEW_TOP(self.gradientImgView2, 260);
    CAGradientLayer *gradientLayer2 = [RXGradient_LayerColor gradientLayerWithVerticalStyle];
    gradientLayer2.frame = self.gradientImgView2.bounds;
//    gradientLayer2.colors = @[(__bridge id)UIColorHex(0x2e8cda).CGColor, (__bridge id)UIColorHex(0x1bb1ff).CGColor];
    gradientLayer2.colors = @[(__bridge id)[UIColor redColor].CGColor, (__bridge id)[UIColor orangeColor].CGColor];
    [self.gradientImgView2.layer insertSublayer:gradientLayer2 atIndex:0];
    
    
    UIButton * changeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    changeButton.frame = CGRectMake(10, 340, 70, 50);
    [changeButton setTitle:@"去改变" forState:UIControlStateNormal];
    [changeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    changeButton.backgroundColor = [UIColor blueColor];
    [changeButton addTarget:self action:@selector(changeGradient:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:changeButton];
}

- (UIImageView *)getImgView {
    UIImageView * imgView = [UIImageView new];
    imgView.frame = CGRectMake(10, 0, 200, 60);
    [self.view addSubview:imgView];
    return imgView;
}


- (void)changeGradient:(UIButton *)btn {
    CAGradientLayer *gradientLayer = (CAGradientLayer *)[self.gradientImgView1.layer.sublayers firstObject];
    if(!gradientLayer) return;
    if(!btn.isSelected) {
        gradientLayer.colors = @[(__bridge id)UIColorHex(0x2e8cda).CGColor, (__bridge id)UIColorHex(0x1bb1ff).CGColor];
        btn.backgroundColor = [UIColor redColor];
    }
    else {
        gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor, (__bridge id)[UIColor orangeColor].CGColor];
        btn.backgroundColor = [UIColor blueColor];
    }
    btn.selected = !btn.isSelected;
    
        /*
         RXGradient_Graphics.h
         RXGradient_LayerColor.h
         
         这两个都是用底层的 CGGradientRef
         
         可以去封装自己的东西(不只这些)
     */
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
