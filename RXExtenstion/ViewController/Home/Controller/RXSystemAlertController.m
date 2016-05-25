//
//  RXSystemAlertController.m
//  RXExtenstion
//
//  Created by srx on 16/5/25.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

/*
 *  灵活利用 【系统 的 标识】，
 *  -- 多人同步 或者 版本迭代 的兼容性
 */

#import "RXSystemAlertController.h"


// 在某个版本   过期提醒(这个借鉴于MJRefresh中的定义)
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
