//
//  RXExpanCCellHeightModel.h
//  RXExtenstion
//
//  Created by srx on 16/6/3.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

//计算cell的高度以及需要改变的高度

#import <Foundation/Foundation.h>
#define TextFontSize 14 //字体大小
#define Text_lineHight 5 //行间距

@class RXExpansionContractionModel;



@interface RXExpanCCellHeightModel : NSObject
//赋值 -- 计算高度
@property (nonatomic, copy) RXExpansionContractionModel * model;

// -- tableView取值、cell取值 -- 调取以下属性
@property (nonatomic, assign, readonly) BOOL  cellEnable; //是否能用展开
@property (nonatomic, copy, readonly) NSAttributedString * attri;
@property (nonatomic, assign, readonly) CGFloat textHeight; //文本默认高度
@property (nonatomic, assign, readonly) CGFloat textHighHeight; //文本展开高度
@property (nonatomic, assign, readonly) CGFloat cellHeight; //cell默认高度
@property (nonatomic, assign, readonly) CGFloat cellHighHeight; //cell展开高度

@property (nonatomic, assign) BOOL isShowHigh; //点击后判断 展开、收起
@end
