//
//  RXShortcutItem.m
//  RXExtenstion
//
//  Created by srx on 16/6/15.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import "RXShortcutItem.h"


@implementation RXItemTypeModel

@end

@implementation RXShortcutItem

///通用创建
- (void)setRXItemTypeString:(NSString *)itemTypeString ItemTitle:(NSString *)itemTitle ItemSubTitle:(NSString *)itemSubTitle hidden:(BOOL)hidden {
    
    self.rxIconImageName = itemTypeString;
    self.rxItemTitle = itemTitle;
    self.rxItemSubTitle = itemSubTitle;
    self.rxHidden = hidden;
}

///系统风格的icon
- (void)setShortcutItemWithIconType:(UIApplicationShortcutIconType)iconType ItemTypeString:(NSString *)itemTypeString ItemTitle:(NSString *)itemTitle ItemSubTitle:(NSString *)itemSubTitle hidden:(BOOL)hidden {
    
    self.rxIconType = iconType;
    
    [self setRXItemTypeString:itemTypeString ItemTitle:itemTitle ItemSubTitle:itemSubTitle hidden:hidden];
}

///自定义图标的icon
- (void)setShortcutItemWithIconImageName:(NSString *)iconImageName ItemTypeString:(NSString *)itemTypeString ItemTitle:(NSString *)itemTitle ItemSubTitle:(NSString *)itemSubTitle hidden:(BOOL)hidden {
    
    self.rxIconImageName = iconImageName;
    
    [self setRXItemTypeString:itemTypeString ItemTitle:itemTitle ItemSubTitle:itemSubTitle hidden:hidden];
    
}

@end
