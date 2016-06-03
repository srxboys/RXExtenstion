//
//  RXSystemAlertController.m
//  RXExtenstion
//
//  Created by srx on 16/5/25.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

/*
 *  灵活利用 【系统 的 标识】，
 *  -- 多人开发 或者 版本迭代 的兼容性
 */

#import "RXSystemAlertController.h"


// 在某个版本 过期提醒
#define RXDeprecated(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)


//枚举 废弃标识
typedef NS_ENUM(NSInteger, RXType) {
    RXTypeOne,
    RXTypeTwo
}__deprecated_enum_msg("已废弃");



@interface RXSystemAlertController ()
{
    BOOL _isSrxboys __deprecated_msg("废弃");
    BOOL _isBoys __dead;
}

/*
    //--用了，会导致崩溃---
    __dead;  //标识 属性
    __dead2; //标识 方法
 */

//-------废弃标识--------------
//属性
@property (nonatomic, assign) BOOL isUseful __deprecated_msg("已废弃 `删除`");
@property (nonatomic, assign) RXType type;

//方法
- (void)rxTest __deprecated_msg("废弃");

//类方法 废弃标识
+ (void)classRxTest __deprecated_msg("废弃");

//-------------------------------------------------
//-------不可用 标识--------------
- (void)rxTextOne __unavailable;

//-------可使用、不可使用的 只能是 方法，不可属性--------------
- (void)rxTextTwo __used; //__unused 不可使用
//@property (nonatomic, assign) NSInteger row __used; //__unused 不可使用



/**
  * 自定义每个版本控制的 废弃方法
  */
- (void)rxTextThree RXDeprecated("废弃说明");

//系统版本 可以使用的 方法

// iOS 2_0引入的方法, 7_0是被废弃的方法
- (void)rxSysTestFor NS_DEPRECATED_IOS(2_0, 7_0);

// OX S 和 iOS
// NS_AVAILABLE(_mac, _ios)
- (void)rxSysTestFive NS_AVAILABLE(10_8, 6_0);


//NS_DEPRECATED
/**
 *  OX S -> mac: 10.0系统中导入的   10.6系统中废弃的
 *  iOS  -> iOS: 2.0系统中导入的    4.0系统中废弃了
 */
- (void)rxSysTestSix NS_DEPRECATED(10_0, 10_6, 2_0, 4_0);

//过期并，添加说明信息
- (void)rxSysTestSeven NS_DEPRECATED(10_0, 10_6, 2_0, 4_0, "这个方法已过期了`废弃了`");

@end






@implementation RXSystemAlertController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //最好跟着每个字母 都手打一下，看下变化
    
    //属性  废弃 展示
    self.isUseful = YES;
    _isUseful = YES;
    
    self.type = RXTypeOne;
    _type = RXTypeOne;
    
    
    [self rxTest];
    
    _isBoys;
    
    [self rxTextThree];
    
    [self rxSysTestFor];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
