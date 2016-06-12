//
//  RXMenu.h
//  Test_Menu
//
//  Created by srx on 16/6/6.
//  Copyright © 2016年 srxboys. All rights reserved.
//

//详看 https://github.com/srxboys/RXExtenstion

//菜单选项封装

#import <UIKit/UIKit.h>

@interface RXMenu : UIView
//1、正常初始化

//2、给出数据源
@property (nonatomic, strong) NSArray * array;
@property (nonatomic, strong) NSArray * menuSegmentArray;
@property (nonatomic, strong) NSArray * menuCityArray;
@end
