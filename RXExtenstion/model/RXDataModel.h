//
//  RXDataModel.h
//  RXExtenstion
//
//  Created by srx on 16/5/6.
//  Copyright © 2016年 https://github.com/srxboys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSDictionary (TextNullReplace)
- (id)objectForKeyNotNull:(NSString *)key;
@end

#pragma mark ----------- [ RXUser ] ---------
@interface RXUser : NSObject
@property (nonatomic, copy) NSString * user_id; //用户id
@property (nonatomic, copy) NSString * user_avater; //用户头像
@property (nonatomic, copy) NSString * user_backImg;//背景图片
@property (nonatomic, copy) NSString * user_desc;

+ (RXUser *)userWithDict:(NSDictionary *)dict;
@end


#pragma mark ----------- [ 轮播图、焦点图 ] ---------
@interface RXFouceModel : NSObject
@property (nonatomic, copy) NSString * fouce_id;
@property (nonatomic, copy) NSString * type;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * image;

+ (RXFouceModel *)fouceModelWithDict:(NSDictionary *)dict;
@end

#pragma mark ----------- [ 我的 ] ---------
@interface RXMineModel : NSObject
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * webUrl;
@property (nonatomic, copy) NSString * image;

+ (RXMineModel *)mineModelWithDict:(NSDictionary *)dict;
@end


#pragma mark ----------- [ 展开和收缩 ] ---------
@interface RXExpansionContractionModel : NSObject
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * text;
@end

@interface RXMenuCitydistanceModel: NSObject
@property (nonatomic, copy)   NSArray  * array;
@property (nonatomic, assign) BOOL       distanceSelected;
@end


@interface RXMenuCityModel: NSObject
@property (nonatomic, copy)   NSString                 * cityName;
@property (nonatomic, copy)   RXMenuCitydistanceModel  * citydistanceModel;
@property (nonatomic, assign) BOOL                       citySelected;//无用
@end


@interface RXMenuTypeModel: NSObject
@property (nonatomic, copy)   NSString  * typeName;
@property (nonatomic, assign) BOOL        typeSelected;//无用
@end



