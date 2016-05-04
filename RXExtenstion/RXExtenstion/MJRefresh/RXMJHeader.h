//
//  RXMJHeader.h
//  RXExtenstion
//
//  Created by srx on 16/4/29.
//  Copyright © 2016年 srxboys. All rights reserved.
//
/*
 https://github.com/srxboys
 
 项目基本框架
 */

//自定义 tableView headView的转圈
#import <UIKit/UIKit.h>

@interface RXMJHeader : UIView
@property (nonatomic, copy)UIColor * textColor;

- (void)animationStop;

- (void)animationStart;
@end
