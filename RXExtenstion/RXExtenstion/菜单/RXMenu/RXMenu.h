//
//  RXMenu.h
//  RXExtenstion
//
//  Created by srx on 16/6/6.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//


//详看 https://github.com/srxboys/RXExtenstion

//菜单选项封装

#import <UIKit/UIKit.h>

#define SegmentHeight 40 /// 自定义分段控制器的高度

@interface RXMenu : UIView
//1、正常初始化

//2、给出数据源
@property (nonatomic, strong) NSArray * array;
@property (nonatomic, strong) NSArray * menuSegmentArray;
@property (nonatomic, strong) NSArray * menuCityArray;
@end
