# RXExtenstion
# iOS 项目基本框架
## `封装假数据`
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