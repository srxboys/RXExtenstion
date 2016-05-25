# RXExtenstion
iOS 项目基本框架

![](https://github.com/srxboys/RXExtenstion/blob/master/项目目录.png) 
-
##introduction
1、简易的MVC框架;
2、主要是`扩展方法`，方便开发;
3、避免常见的bug。

-
###1）自给假数据
```objc
/// 随机日期-最近一个月随机
+ (NSString *)randomDateString;
/// 随机日期---- 几个月随机
+ (NSString *)randomDateStringWithinCount:(NSInteger)count;
/// 随机汉字--100 以内
+ (NSString *)randomChinas;
/// 随机汉字--count 以内
+ (NSString *)randomChinasWithinCount:(NSInteger)count;
/// 字符串 -- 不定长
+ (NSString *)randomString;
/// 随机字母 - 26个
+ (NSString *)randomLetter;
+ (NSString *)randomLetterWithInCount:(NSInteger)count;
/// 随机 给出 图片网址
+ (NSString *) randomImageURL;
/// 随机颜色
+ (UIColor *)randomColor;
/// 返回当前日期时间
+ (double)randomNowDate;
/// 随机倒计时日期时间 (前提是大于当前时间)
+ (NSString *)randomTimeCountdown;
```
###2）字符处理 、数组、 字典 -> 空处理
///字符处理 、数组、 字典 -> 空处理
```objc
#import "RXCharacter.h"
@implementation RXCaCheController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString * string = @"https://github.com/srxboys";
    
    if([string strBOOL]) {
        //是否为字符串
    }
    
    if([string urlBOOL]) {
        //是否为 网址
    }
    
    if([string arrBOOL]) {
        //是否为 数组
    }
    
    //参数 空处理
    string = @"0"; // or --> string = @"<null>"
    NSString * dictionaryValue = [string strNotEmptyValue];
    RXLog(@"dictValue=%@", dictionaryValue);
}
@end
```
-
###3）灵活利用 【系统 的 标识】详细说明
 多人开发 或者 版本迭代 的兼容性
```objc
//-------废弃标识--------------
//属性
@property (nonatomic, assign) BOOL isUseful __deprecated_msg("已废弃 `删除`");
//方法
- (void)rxTest __deprecated_msg("废弃");

//类方法 废弃标识
+ (void)classRxTest __deprecated_msg("废弃");
```
![](https://github.com/srxboys/RXExtenstion/blob/master/deprecatedResult.png) 
-
###4）简单的MJRefresh封装
-

我现在的项目 用的这个！！！！！！
如果你有想说的可以`issues I`。
