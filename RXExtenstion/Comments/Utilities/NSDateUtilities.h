/*
 Erica Sadun, http://ericasadun.com
 iPhone Developer's Cookbook 3.x and beyond
 BSD License, Use at your own risk
 */

#import <Foundation/Foundation.h>

#define D_MINUTE	60
#define D_HOUR		3600
#define D_DAY		86400
#define D_WEEK		604800
#define D_YEAR		31556926

#define D_BII_DATE_Format @"yyyy-MM-dd"
#define D_BII_TIME_Format @"HH:mm:ss"



typedef NS_ENUM(NSInteger, MBExecuteType) {
    MBExecuteTypeMonth = 1,
    MBExecuteTypeDoubleWeek,
    MBExecuteTypeWeek
};

@interface NSDate (Utilities)

// Decomposing dates
@property (readonly) NSInteger year;
@property (readonly) NSInteger month;
@property (readonly) NSInteger week;        //week of the year
@property (readonly) NSInteger weekday;     //1 for monday...
@property (readonly) NSInteger day;
@property (readonly) NSInteger hour;
@property (readonly) NSInteger minute;
@property (readonly) NSInteger seconds;

- (NSDate *) monthsAgo:(NSInteger)months;       //几个月前
- (NSDate *) monthsLater:(NSInteger)months;     //几个月后

- (NSDate *) daysAgo:(NSInteger)days;           //几天前
- (NSDate *) daysLater:(NSInteger)days;         //几天后

- (NSDate *) hoursAgo:(NSInteger)hours;         //几小时前
- (NSDate *) hoursLater:(NSInteger)hours;       //几小时后
    
- (NSDate *) minutesAgo:(NSInteger)minutes;     //几分钟前
- (NSDate *) minutesLater:(NSInteger)minutes;   //几分钟后

+ (NSDate *)dateWithTimeIntervalString:(NSString *)string;

+ (NSDate *) dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

+ (NSDate *) dateWithYear:(NSInteger)year
                    month:(NSInteger)month
                      day:(NSInteger)day
                     hour:(NSInteger)hour
                   minute:(NSInteger)minute
                   second:(NSInteger)second;

+ (NSInteger)daysOfMonth:(NSInteger)month ofYear:(NSInteger)year;
+ (NSInteger)daysOfMonth:(NSInteger)month;     //默认今年

//字符串转NSDate
+ (NSDate *)dateWithString:(NSString *)dateString;

//返回格式： yyyy/MM/dd HH:mm:ss
- (NSString *)dateTimeString;

//返回格式：yyyy/MM/dd
- (NSString *)dateString;

//返回格式：HH:mm:ss
- (NSString *)timeString;


//执行次数计算
+ (NSUInteger)executeTimesWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate type:(MBExecuteType)type;

////////////////////////////////////////////////////////////////////////////////////////////////////
// Comparing dates
- (BOOL) isEqualToDateIgnoringTime: (NSDate *) aDate;
- (BOOL) isSameWeekAsDate: (NSDate *) aDate;
- (BOOL) isSameMonthAsDate: (NSDate *) aDate;
- (BOOL) isSameYearAsDate: (NSDate *) aDate;
- (BOOL) isEarlierThanDate: (NSDate *) aDate;
- (BOOL) isLaterThanDate: (NSDate *) aDate;
- (BOOL) isLeapYear;

+ (NSDate *) tomorrow;
+ (NSDate *) yesterday;

//Roles
- (BOOL) isTypicallyWeekend;
- (BOOL) isTypicallyWorkday;

@end
