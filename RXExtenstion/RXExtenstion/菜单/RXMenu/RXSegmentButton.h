//
//  RXSegmentButton.h
//  Test_Menu
//
//  Created by srx on 16/6/6.
//  Copyright © 2016年 srxboys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RXSegmentButton : UIView
@property (nonatomic, copy)   NSString * title;
@property (nonatomic, assign) NSInteger  rxTag;// == tag
@property (nonatomic, assign) BOOL       selected; //是否选择
- (void)addTarget:(id)target action:(SEL)action;
@end
