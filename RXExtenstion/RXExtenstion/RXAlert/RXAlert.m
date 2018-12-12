//
//  RXAlert.m
//  RXExtenstion
//
//  Created by srxboys on 2018/4/8.
//  Copyright © 2018年 https://github.com/srxboys. All rights reserved.
//

#import "RXAlert.h"

#pragma mark - UIAlertView
@interface RXAlertView : UIAlertView
@property (nonatomic, copy) CancelHandler cancelHandler;
@property (nonatomic, copy) DismissHandler dismissHandler;
@end

@implementation RXAlertView
+ (void)showWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles cancelHandler:(CancelHandler)cancelHandler dismissHandler:(DismissHandler)dismissHandler
{
    RXAlertView * alertView = [[RXAlertView alloc] initWithTitle:title message:message cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles cancelHandler:cancelHandler dismissHandler:dismissHandler];
    [alertView show];
}

- (id)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles cancelHandler:(CancelHandler)cancelHandler dismissHandler:(DismissHandler)dismissHandler {
    
    self = [super initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
    if (self) {
        for (NSString *otherTitle in otherButtonTitles) {
            [self addButtonWithTitle:otherTitle];
        }
        _cancelHandler = [cancelHandler copy];
        _dismissHandler = [dismissHandler copy];
        
    }
    return self;
}

- (void)forceDismiss {
    [self dismissWithClickedButtonIndex:-1 animated:YES];
}

#pragma mark - - UIAlertView Delegate
- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == self.cancelButtonIndex) {
        if (_cancelHandler)
            _cancelHandler();
    }
    else {
        if (_dismissHandler)
            _dismissHandler(buttonIndex - self.cancelButtonIndex);
    }
}

@end






#pragma mark - UIAlertController
@interface RXAlertController : UIAlertController
@end

@implementation RXAlertController
@end



#pragma mark - RXAlert
@implementation RXAlert

+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles cancelHandler:(CancelHandler)cancelHandler dismissHandler:(DismissHandler)dismissHandler {
    RXAlert * alert = [[RXAlert alloc] initWithTitle:title message:message cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles cancelHandler:cancelHandler dismissHandler:dismissHandler];
    [alert show];
}

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles {
    self = [self initWithTitle:title message:message cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles cancelHandler:nil dismissHandler:nil];
    return self;
}

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles cancelHandler:(CancelHandler)cancelHandler dismissHandler:(DismissHandler)dismissHandler {
    self = [super init];
    if(self) {
        self.title = title;
        self.message = message;
        self.cancelButtonTitle = cancelButtonTitle;
        self.otherButtonTitles = otherButtonTitles;
        self.cancelHandler = cancelHandler;
        self.dismissHandler = dismissHandler;
    }
    return self;
}

- (void)show {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0f) {
        [RXAlertView showWithTitle:self.title message:self.message cancelButtonTitle:self.cancelButtonTitle otherButtonTitles:self.otherButtonTitles cancelHandler:self.cancelHandler dismissHandler:self.dismissHandler];
    }
    else {
        RXAlertController * alert = [RXAlertController alertControllerWithTitle:self.title message:self.message preferredStyle:UIAlertControllerStyleAlert];
        if(self.cancelButtonTitle.length > 0) {
            [alert addAction:[UIAlertAction actionWithTitle:self.cancelButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [alert dismissViewControllerAnimated:YES completion:nil];
                if(self.cancelHandler) {
                    self.cancelHandler();
                }
            }]];
        }
        
        for(NSUInteger i = 0; i < self.otherButtonTitles.count; i ++) {
            NSString * buttonTitle = self.otherButtonTitles[i];
            if(buttonTitle.length > 0) {
                [alert addAction:[UIAlertAction actionWithTitle:buttonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [alert dismissViewControllerAnimated:YES completion:nil];
                    if(self.dismissHandler) {
                        self.dismissHandler(i);
                    }
                }]];
            }
        }
        
        UIWindow * window = [UIApplication sharedApplication].keyWindow;
        if(window.rootViewController) {
            [window.rootViewController presentViewController:alert animated:YES completion:nil];
        }
    }
}

@end
