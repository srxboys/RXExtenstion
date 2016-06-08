//
//  RXLocationController.h
//  RXExtenstion
//
//  Created by srx on 16/6/8.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import "RXBaseViewController.h"

@interface RXLocationController : RXBaseViewController

@end


/*
 //来源
 http://www.tuicool.com/articles/3URFZ3y
 
 今天做iOS项目的时候，需要通过定位来拿到当期城市的名称。
 
 百度地图SDK有这个功能，但为了不依赖第三方，这里我用iOS自带框架CoreLocation来实现这个需求。
 
 iOS8出来之后，针对定位需要多一点处理，才可以正常定位，这点会在文章末尾部分作出补充，在声明补充之前的部分都是默认iOS7处理。
 

 */