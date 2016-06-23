//
//  RXShortcutItem.h
//  RXExtenstion
//
//  Created by srx on 16/6/15.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

//完全自定义的 3DTouch 数据模型 -- 灵感来自 《天猫》APP

//初学者建议去 github搜索看下基础
//1、静态设置 info.plist添加3D touch 选项
//2、动态设置 

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, RXItemType) {
    RXItemTypeController = 0, //首页 跳转到 -->自定义跳转到哪个Controller
    RXItemTypeHome       = 1, //首页
    RXItemTypeLocation   = 2, //定位
    RXItemTypeUser       = 3, //我的
    RXItemTypeSrxboysURL = 4, //我的 跳转到 --> github/baiDuYun/weibo/jianShu
    RXItemTypeUserURL    = 5  //我的 跳转到 --> 自定义的URL
};

@interface RXItemTypeModel : NSObject
@property (nonatomic, copy)   NSString * ItemTitle;
@property (nonatomic, assign) RXItemType ItemType;
            ///根据 itemType 自定义的 是controller、URL
@property (nonatomic, copy)   NSString * ItemCoustomString;
@end

#pragma mark --------------上面的还没用到-------------------------------
@interface RXShortcutItem : NSObject
@property (nonatomic, assign) UIApplicationShortcutIconType rxIconType;
                                            //用户自定义图片
@property (nonatomic, copy)   NSString        * rxIconImageName;
@property (nonatomic, copy)   NSString        * rxItemType;
@property (nonatomic, copy)   NSString        * rxItemTitle;
@property (nonatomic, copy)   NSString        * rxItemSubTitle;
@property (nonatomic, assign) BOOL              rxHidden;//是否隐藏

///系统风格的icon
- (void)setShortcutItemWithIconType:(UIApplicationShortcutIconType)iconType ItemTypeString:(NSString *)itemTypeString ItemTitle:(NSString *)itemTitle ItemSubTitle:(NSString *)itemSubTitle hidden:(BOOL)hidden;

///自定义图标的icon
- (void)setShortcutItemWithIconImageName:(NSString *)iconImageName ItemTypeString:(NSString *)itemTypeString ItemTitle:(NSString *)itemTitle ItemSubTitle:(NSString *)itemSubTitle hidden:(BOOL)hidden;
@end
