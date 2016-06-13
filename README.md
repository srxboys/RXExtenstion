# RXExtenstion
##iOS 项目基本框架
###1、简易的MVC框架;
###2、主要是扩展方法，方便开发;
###3、避免常见的bug。
-
##带有效果展示
### [1、UILabel自适应高度的3种方法](https://github.com/srxboys/RXExtenstion/blob/master/srxboys/label/UILabel3type.md) 

### [2、](http://weibo.com/1759864273/Dxsiixb4M?from=page_1005051759864273_profile&wvr=6&mod=weibotime&type=comment#_rnd1465802552136)[封装AFNetworking](http://blog.csdn.net/srxboys/article/details/50774553)

### [3、自定义点餐的菜单功能](https://github.com/srxboys/RXExtenstion/blob/master/srxboys/Menu/menu.md)

### [4、封装假数据](https://github.com/srxboys/RXExtenstion/tree/master/srxboys/falseData/falseData.md)

### [5、我的demo 百度网盘](http://pan.baidu.com/s/1hqH9ZNI) 

### [6、不是技术的技术博客](https://weibo.com/srxboys)

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
