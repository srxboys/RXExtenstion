# RXExtenstion
[![Platform](https://img.shields.io/badge/platform-iOS-red.svg)](https://developer.apple.com/iphone/index.action)
[![Language](http://img.shields.io/badge/language-OC-yellow.svg?style=flat)](https://en.wikipedia.org/wiki/Objective-C)
[![Language_swift](https://img.shields.io/badge/language-Swift-orange.svg)](https://en.wikipedia.org/wiki/Swift)
[![Language_C](https://img.shields.io/badge/language-C-orange.svg)](https://en.wikipedia.org/wiki/C)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](http://mit-license.org)
<br> `图片来源: http://shields.io`
<br>

- 基于 \>= iOS7 

### Wiki
- [中文文档](https://github.com/srxboys/RXExtenstion/wiki/中文文档)
- [English Home](https://github.com/srxboys/RXExtenstion/wiki/English-Home-page)

-

## iOS 项目基本框架 <br>
### 1、简易的MVC框架; <br>
### 2、主要是`扩展方法`，方便开发; <br>
### 3、避免常见的bug。 <br>

-

### 带有效果展示
### 1、`UILabel自适应高度的3种方法`
```objc

    //label高度
    CGFloat _textHeight = 0;

    //第一种 -- 可以得到宽高 -- 前提一个无线大
    //不能对富文本赋值后的计算
    _textHeight = [label textRectForBounds:frame limitedToNumberOfLines:1].size.height;

    //第二种 -- 可以得到宽高
    //1)确定行数，进行剪切
    //2)不确定行数，宽高一个无限大，进行剪切
    [label sizeToFit];
    _textHeight = label.frame.size.height;
    _textWidth = label.frame.size.width;

    //第三种 对于特殊文字、字符，计算的结果并不满人意
    CGFloat width = 200;//当宽度是已知的。
    _textHeight = [label boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) 
                  options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading
                  attributes: @{NSFontAttributeName: label.font} 
                  context:nil].size.height;
```
### 1、看看效果
![srxboys](https://github.com/srxboys/RXExtenstion/blob/master/srxboys/label/srxboys_UILabel1.gif)
![srxboys](https://github.com/srxboys/RXExtenstion/blob/master/srxboys/label/srxboys_UILabel2.gif)
![srxboys](https://github.com/srxboys/RXExtenstion/blob/master/srxboys/label/srxboys_UILabel3.gif)

-

### [2、](http://weibo.com/1759864273/Dxsiixb4M?from=page_1005051759864273_profile&wvr=6&mod=weibotime&type=comment#_rnd1465802552136)[封装AFNetworking](http://blog.csdn.net/srxboys/article/details/50774553)
-
### 3、`自定义点餐的菜单功能`
###只是简简单单的框架
![srxboys](https://github.com/srxboys/RXExtenstion/blob/master/srxboys/Menu/srxboys_Menu.gif)

这里我只是做了个框架，具体的界面美化和数据等等根据需求自己完善。而这个框架主要提供思路。

-

### 4、`封装假数据`
上面的不知道你观察了没有，很多文字、日期 + 时间、数字、图片等等 都是来自于 自动生成假数据 的类。下面介绍下:
```objc
    @interface RXRandom : NSObject
    /// 随机日期-最近一个月随机 
    + (NSString *)randomDateString;
    /// 随机日期---- 几个月随机
    + (NSString *)randomDateStringWithinCount:(NSInteger)count;
    ///可以返回最近30天，最近几个小时等等操作，需要改内部

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
    @end
```
![srxboys](https://github.com/srxboys/RXExtenstion/blob/master/srxboys/falseData/srxboys_falseData.gif)

-

### 5、`字符处理 、数组、 字典 -> 空处理`
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

### 6、`收货地址 地区 选择样式`
```objc
//导入封装的UIView
#import "RXOneLinkageTreeAddress.h"
#import "RXThreeLinkageAddress.h"
#import "RXJDAddressPickerView.h"

//初始化 并 实现block回调方法
    weak(weakSelf);

    _onePicker = [[RXOneLinkageTreeAddress alloc] init];
    _onePicker.isShow = ^ (BOOL isShow, NSString *address, 
                        NSString * addressCode){
            RXLog(@"_onePicker\nisShow=%@, address=%@, 
                        addressCode=%@\n\n", isShow ? @"是" : @"否`", 
                        address, addressCode);

            weakSelf.addressLabel.text = [NSString stringWithFormat:
                        @"_onePicker isShow=%@, address=%@, addressCode=%@", 
                        isShow ? @"是" : @"否`", address, addressCode];
    };


    _twoPicker = [[RXThreeLinkageAddress alloc] init];
    _twoPicker.isShow = ^ (BOOL isShow, NSString *address, 
                            NSString * addressCode){
            RXLog(@"_twoPicker\nisShow=%@, address=%@, 
                        addressCode=%@\n\n", isShow ? @"是" : @"否",
                        address, addressCode);

            weakSelf.addressLabel.text = [NSString stringWithFormat:
                        @"_twoPicker  isShow=%@, address=%@, addressCode=%@",
                        isShow ? @"是" : @"否", address, addressCode];

    };


    _threePicker = [[RXJDAddressPickerView alloc] init];
    _threePicker.completion = ^(NSString *address,
                                NSString * addressCode){
            RXLog(@"_threePicker\n, address=%@, addressCode=%@\n\n", address, addressCode);

            weakSelf.addressLabel.text = [NSString stringWithFormat:@"_threePicker , 
                        address=%@, addressCode=%@",address, addressCode];
    };

    // -- 我的项目 是把 这些 添加 appDelegate.window 上 --


//调用 收货地址 选择 省/市/区 显示控件
    // 1级 3联动
    [_onePicker showAddressView];

    // 3级联动
    [_twoPicker show];

    //仿照京东v1.5.0
    [_threePicker showAddress];

```
![srxboys](https://github.com/srxboys/RXExtenstion/blob/master/srxboys/address/address.gif)

-

### 7、`日期、时间 选择样式`
```objc
    _nomalDatePicker  = [[RXNomalDatePicker alloc] init];
    _nomalDatePicker.isShow = ^(BOOL isShow, NSDate * date) {
        RXLog(@"%d %@", isShow, date);
        weakSelf.resultLabel.text = [NSString stringWithFormat:@"%@", date];
    };

    _datePicker = [[RXDatePicker alloc] init];
    _datePicker.isShow = ^(BOOL isShow, NSDate * date) {
        RXLog(@"%d %@", isShow, date);
        weakSelf.resultLabel.text = [NSString stringWithFormat:@"%@", date];
    };

    _dateTimePicker = [[RXDateTimePicker alloc] init];
    _dateTimePicker.pickerComple = ^(BOOL isShow, NSString * dateString) {
        RXLog(@"%d %@", isShow, dateString);
        weakSelf.resultLabel.text = dateString;
    };


    [self.view addSubview:_nomalDatePicker];
    [self.view addSubview:_datePicker];
    [self.view addSubview:_dateTimePicker];

//调用 日期、时间 选择样式 显示控件
    [_nomalDatePicker show];
    [_datePicker show];
    [_dateTimePicker showDatePickerView];

```
![srxboys](https://github.com/srxboys/RXExtenstion/blob/master/srxboys/datePicker/datePicker.gif)

-

### 8、`3D Touch 自定制`
![srxboys](https://github.com/srxboys/RXExtenstion/blob/master/srxboys/3DTouch/srxboys_3DTouch.gif)

-

### [我的demo 百度网盘](http://pan.baidu.com/s/1hqH9ZNI) 

### [不是技术的技术博客](http://weibo.com/srxboys)

-

### 接口必传字段处理
![srxboys](https://github.com/srxboys/RXExtenstion/blob/master/AFNS.png)

### RXLog
![srxboys_rxlog](https://github.com/srxboys/RXExtenstion/blob/master/srxboys/RXLog/RXLog.png)

### [更新日志](https://github.com/srxboys/RXExtenstion/wiki/更新日志) -> [WIKI](https://github.com/srxboys/RXExtenstion/wiki)

~ ~ ~  coding ~ ~ ~ 

此项目主要是以框架为主，方法为辅。方便开发。 
如果你有想说的可以 [issues I](https://github.com/srxboys/RXExtenstion/issues/new) 。<br>
如果你有更好的改进，please pull reqeust me <br>
:sweat_smile::sweat_smile::sweat_smile::sweat_smile::sweat_smile:
