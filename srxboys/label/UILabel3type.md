# RXExtenstion
# iOS 项目基本框架
### `UILabel自适应高度的3种方法`
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
###看看效果
![srxboys](https://github.com/srxboys/RXExtenstion/blob/master/srxboys/label/srxboys_UILabel1.gif)
![srxboys](https://github.com/srxboys/RXExtenstion/blob/master/srxboys/label/srxboys_UILabel2.gif)
![srxboys](https://github.com/srxboys/RXExtenstion/blob/master/srxboys/label/srxboys_UILabel3.gif)