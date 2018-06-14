//
//  RXAlert.h
//  RXExtenstion
//
//  Created by srxboys on 2018/4/8.
//  Copyright © 2018年 https://github.com/srxboys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^CancelHandler)(void);
typedef void(^DismissHandler)(NSUInteger buttonIndex);//index默认从0开始

@interface RXAlert : NSObject

@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * message;
@property (nonatomic, copy) NSString * cancelButtonTitle;
@property (nonatomic, copy) NSArray * otherButtonTitles;

@property (nonatomic, copy) CancelHandler cancelHandler;
@property (nonatomic, copy) DismissHandler dismissHandler;

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles;
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles cancelHandler:(CancelHandler)cancelHandler dismissHandler:(DismissHandler)dismissHandler;

// 配合上面
- (void)show;







+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles cancelHandler:(CancelHandler)cancelHandler dismissHandler:(DismissHandler)dismissHandler;

@end
