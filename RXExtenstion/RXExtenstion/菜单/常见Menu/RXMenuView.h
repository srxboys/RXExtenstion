//
//  RXMenuView.h
//  RXExtenstion
//
//  Created by srx on 16/9/5.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RXMenuView : UIView
@property (nonatomic, assign, readonly)NSInteger pageNumber;
//数组里 放 RXSeckillMenuMode 多个数据模型
@property (nonatomic, assign)NSArray * menuListArray;

//数据个数
- (void)addTarget:(id)target action:(SEL)action;

- (void)seckillMenuSelectPageNum:(NSInteger)num;
- (void)seckillMenuSelectPageAdd;
- (void)seckillMenuSelectPageSub;
@end
