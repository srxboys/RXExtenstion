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

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.rxIconType = [[aDecoder decodeObjectForKey:@"rxIconType"] integerValue];
        self.rxIconImageName = [aDecoder decodeObjectForKey:@"rxIconImageName"];
        self.rxItemType = [aDecoder decodeObjectForKey:@"rxItemType"];
        self.rxItemTitle = [aDecoder decodeObjectForKey:@"rxItemTitle"];
        self.rxItemSubTitle = [aDecoder decodeObjectForKey:@"rxItemSubTitle"];
        self.rxHidden = [aDecoder decodeObjectForKey:@"rxHidden"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeInteger:self.rxIconType forKey:@"rxIconType"];
    [aCoder encodeObject:self.rxIconImageName forKey:@"rxIconImageName"];
    [aCoder encodeObject:self.rxItemType forKey:@"rxItemType"];
    [aCoder encodeObject:self.rxItemTitle forKey:@"rxItemTitle"];
    [aCoder encodeObject:self.rxItemSubTitle forKey:@"rxItemSubTitle"];
    [aCoder encodeBool:self.rxHidden forKey:@"rxHidden"];
}

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

+ (NSArray *)readerCanSettingAllReject:(NSArray *)array {
    // 3D-Touch 默认值
    NSMutableArray * mutableArray = [[NSMutableArray alloc] init];
    
    for(NSInteger i = 0; i < 6; i++) {
        //最好用自定义图片的，不然还需要判断版本
        RXShortcutItem * model = [[RXShortcutItem alloc] init];
        
        NSInteger  rxIconType = 0;
        NSString * rxItemTitle = nil;
        NSString * rxItemSubTitle = nil;
        
        if(i == 0) {
            //iOS > 9.1
            rxIconType = UIApplicationShortcutIconTypeHome;
            rxItemTitle = @"首页";
            rxItemSubTitle = @"0";
        }
        else if(i == 1) {
            //iOS > 9.0
            rxIconType = UIApplicationShortcutIconTypeSearch;
            rxItemTitle = @"搜索";
            rxItemSubTitle = @"1";
        }
        else if(i == 2) {
            //iOS > 9.0
            rxIconType = UIApplicationShortcutIconTypeProhibit;
            rxItemTitle = @"什么";
            rxItemSubTitle = @"2";
        }
        else if (i == 3) {
            //iOS > 9.1
            rxIconType = UIApplicationShortcutIconTypeContact;
            rxItemTitle = @"3D-Touch定制";
            rxItemSubTitle = @"我的-3D touch 定制";
        }
        else if (i == 4) {
            //iOS > 9.1
            rxIconType = UIApplicationShortcutIconTypeAlarm;
            rxItemTitle = @"警告";
            rxItemSubTitle = @"安装警报器";
        }
        else if (i == 5) {
            //iOS > 9.1
            rxIconType = UIApplicationShortcutIconTypeConfirmation;
            rxItemTitle = @"确认";
            rxItemSubTitle = @"确认确认确认";
        }
        
        model.rxIconType = rxIconType;
        model.rxItemTitle = rxItemTitle;
        model.rxItemSubTitle = rxItemSubTitle;
        
        __block BOOL is_existence = YES;
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            RXShortcutItem * model2 = array[idx];
            RXLog(@"--idx=%zd==model.rxItemTitle=%@=model2.rxItemTitle=%@", idx, model.rxItemTitle, model2.rxItemTitle);
            if([model2.rxItemTitle isEqualToString:model.rxItemTitle]) {
                is_existence = NO;
                return ;
            }
        }];
        
        
        if(is_existence) {
            [mutableArray addObject:model];
        }
    }
    
    
    return mutableArray;
}

+ (BOOL)writeLocalDataWithArray:(NSArray *)array {
    NSData * newData = [NSKeyedArchiver archivedDataWithRootObject:array];
    [NSKeyedArchiver archiveRootObject:newData toFile:[self getFilePath:NSStringFromClass([self class])]];
    return NO;
}

+ (NSArray *)readerLocalData {
    NSData * logData = [NSKeyedUnarchiver unarchiveObjectWithFile:[self getFilePath:NSStringFromClass([self class])]];
    
    if(logData == nil) return nil;
    
    NSArray* array = [NSKeyedUnarchiver unarchiveObjectWithData:logData];    
    return array;
}

+ (BOOL)removeLocalData {
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *directory = [[array objectAtIndex:0]stringByAppendingPathComponent:@"RXShortcutItem_Cache_Log"];
    NSFileManager *fm = [NSFileManager defaultManager];
    NSError * error;
    if ([fm fileExistsAtPath:directory]) {
        [fm removeItemAtPath:directory error:&error];
    }
    if(error != nil) {
        RXLog(@"删除失败");
        return NO;
    }
    return YES;
}

#pragma mark - ~~~~~~~~~~~ file utils ~~~~~~~~~~~~~~~
+ (NSString *)getFilePath:(NSString*)fileName {
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *directory = [[array objectAtIndex:0]stringByAppendingPathComponent:@"RXShortcutItem_Cache_Log"];
    NSFileManager *fm = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:directory]) {
        [fm createDirectoryAtPath:directory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *result = [directory stringByAppendingPathComponent:fileName];
    return result;
}


@end
