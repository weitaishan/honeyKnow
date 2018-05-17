//
//  NSDate+Util.h
//  DeviseHome
//
//  Created by 魏太山 on 16/12/6.
//  Copyright © 2016年 weitaishan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Util)

//通过时间获取一个字段，只能在我的当前项目里面使用
+(NSString *)stringFromCtStr:(NSInteger)created_at;

+(NSString *)stringFromActTime:(NSInteger)created_at;

+(NSString *)stringFromLiveTime:(NSInteger)startTime;

+(BOOL)isTimeToLive:(NSInteger)startTime;

+(NSString *)utcTimeToDataString;

+(BOOL)isTimeToCreateLive:(NSString *)startTime;
+(NSString *)dateToDateString:(NSDate *)date;

+ (NSInteger)cTimestampFromDate:(NSDate *)date;

+(NSInteger)cTimestampFromString:(NSString *)timeStr
                          format:(NSString *)format;
+ (NSString *)dateStrFromCstampTime:(NSInteger)timeStamp
                     withDateFormat:(NSString *)format;

+ (NSDate *)dateFromString:(NSString *)timeStr
                    format:(NSString *)format;

+ (NSString *)datestrFromDate:(NSDate *)date
               withDateFormat:(NSString *)format;
/**
 *  是否为今天
 */
- (BOOL)isToday;

/**
 *  获得与当前时间的差距
 */
- (NSDateComponents *)deltaWithNow;

/**
 * @method
 *
 * @brief 获取两个日期之间的天数
 * @param fromDate       起始日期
 * @param toDate         终止日期
 * @return    总天数
 */
+ (NSInteger)numberOfDaysWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;
/**
 * @method
 *
 * @brief 获取两个日期之间的小时数
 * @param fromDate       起始日期
 * @param toDate         终止日期
 * @return   相差小时
 */
+ (NSInteger)numberOfHoursWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;
- (NSDate *)zeroOfDate;
@end
