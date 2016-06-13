# RXExtenstion
###iOS 项目基本框架
######1、简易的MVC框架;
######2、主要是`扩展方法`，方便开发;
######3、避免常见的bug。
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
    _textHeight = [label boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: label.font} context:nil].size.height;
```
### 1、看看效果
![srxboys](https://github.com/srxboys/RXExtenstion/blob/master/srxboys/label/srxboys_UILabel1.gif)
![srxboys](https://github.com/srxboys/RXExtenstion/blob/master/srxboys/label/srxboys_UILabel2.gif)
![srxboys](https://github.com/srxboys/RXExtenstion/blob/master/srxboys/label/srxboys_UILabel3.gif)

### [2、](http://weibo.com/1759864273/Dxsiixb4M?from=page_1005051759864273_profile&wvr=6&mod=weibotime&type=comment#_rnd1465802552136)[封装AFNetworking](http://blog.csdn.net/srxboys/article/details/50774553)

### 3、`自定义点餐的菜单功能`
###只是简简单单的框架
![srxboys](https://github.com/srxboys/RXExtenstion/blob/master/srxboys/Menu/srxboys_Menu.gif)

这里我只是做了个框架，具体的界面美化和数据等等根据需求自己完善。而这个框架主要提供思路。

### 4、`封装假数据`
上面的超链接，我不知道你点击了没有，不知道你观察了没有，很多文字、日期 + 时间、数字、图片等等 都是来自于 自动生成假数据 的类。下面介绍下:
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

### [6、我的demo 百度网盘](http://pan.baidu.com/s/1hqH9ZNI) 

### [7、不是技术的技术博客](https://weibo.com/srxboys)
-
###更新日志
2016-05-25  
增加
* 系统 的 标识 位置Home->controller-RXSystemAlertController

2016-05-26  
修改: 
* 网络状态的监听。  位置RXExtenstion->Reachability-> 
  //解决block回调的网络状态只能给最后一个调用的，改用通知，就可以全部界面接受到了  
* prefixHeader.h 全局定义文件的 修改
增加:
* xcode控制台打印[数组、字典]包括汉字的，汉字可以打印。重新打印方法。 位置Comments->Utilties->RXLog
* 增加 第三方NSDate的扩展(NSDateUtilities)  可以实现各种转换

2016-6-2  
修改: 
* 网络监听 支持ipv6

2016-6-3   
增加:   
* 增加系统功能 
* cell 展开和收缩  

2016-6-8    
增加:
* 亲测 GPS定位支持 > iOS7

2016-6-12    
增加: 
* 亲测 自定义菜单 选项

-

~ ~ ~  coding ~ ~ ~ 

此项目主要是以框架为主，方法为辅。方便开发。 
如果你有想说的可以`issues I`。
