//
//  NSDate+Util.m
//  DeviseHome
//
//  Created by 魏太山 on 16/12/6.
//  Copyright © 2016年 weitaishan. All rights reserved.
//

#import "NSDate+Util.h"

@implementation NSDate (Util)

+(NSString *)stringFromCtStr:(NSInteger)created_at{
    NSString * publishTime = [NSString stringWithFormat:@"%ld",created_at];
    
    float timeV=[publishTime floatValue];
    //将对象类型的时间转换为NSDate类型
    NSDate * myDate=[NSDate dateWithTimeIntervalSince1970:timeV];
    
    //1.获取创建时间
    //    Thu Apr 21 11:01:03 +0800 2016
    //    EEE MMM dd HH:mm:ss Z yyyy
    //创建时间格式
    NSDateFormatter * dateFormat=[[NSDateFormatter alloc] init];
    //设置本地化
    dateFormat.locale=[NSLocale localeWithLocaleIdentifier:@"CN"];
    [dateFormat setDateFormat:@"EEE MMM dd HH:mm:ss Z yyyy"];
    NSString * mydateStr = [dateFormat stringFromDate:myDate];
    NSDate * ctDate = [dateFormat dateFromString:mydateStr];
    
    //2.获取当前时间
    NSDate * nowDate=[NSDate date];
    
    //3.获取时间差
    //3.1 创建一个日历,获取当前日历
    NSCalendar * calendar=[NSCalendar currentCalendar];
    //3.2 设置日历筛选组件
    int unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    //3.3 通过日历获取时间差
    NSDateComponents * components=[calendar components:unit fromDate:ctDate toDate:nowDate options:NSCalendarWrapComponents];
    NSString * absluteStr=nil;
    
    BOOL isToday=[calendar isDateInToday:ctDate];
    if (isToday) {
        //是否是一个小时内
        if (components.hour<1) {
            //是否是一分钟内
            if (components.minute<1) {
                //是否是10秒内
                if (components.second<=10) {
                    absluteStr=@"刚刚";
                }else{
                    //显示成： 34秒前
                    absluteStr=[NSString stringWithFormat:@"%ld秒前",components.second];
                }
            }else{
                //显示成： 34分钟前
                absluteStr=[NSString stringWithFormat:@"%ld分钟前",components.minute];
            }
        }else{
            //显示成： 今天 11:34
            [dateFormat setDateFormat:@"今天:HH:mm"];
            absluteStr=[dateFormat stringFromDate:ctDate];
        }
    }else{
        //判断是否为今年
        int yearUnit=NSCalendarUnitYear;
        //1.获取创建时间的时间组件
        NSDateComponents * ctComp=[calendar components:yearUnit fromDate:ctDate];
        //2.获取当前时间的时间组件
        NSDateComponents * nowComp=[calendar components:yearUnit fromDate:nowDate];
        //如果年份相等，就是同一年
        if (ctComp.year==nowComp.year) {
            [dateFormat setDateFormat:@"MM月dd日 HH:mm"];
            absluteStr=[dateFormat stringFromDate:ctDate];
        }else{
            //
            [dateFormat setDateFormat:@"yyyy年MM月dd日 HH:mm"];
            absluteStr=[dateFormat stringFromDate:ctDate];
        }
    }
    
    return absluteStr;
}


+(NSString *)stringFromActTime:(NSInteger)created_at{
    NSString * publishTime = [NSString stringWithFormat:@"%ld",created_at];
    
    float timeV=[publishTime floatValue];
    //将对象类型的时间转换为NSDate类型
    NSDate * myDate=[NSDate dateWithTimeIntervalSince1970:timeV];
    
    //1.获取创建时间
    //    Thu Apr 21 11:01:03 +0800 2016
    //    EEE MMM dd HH:mm:ss Z yyyy
    //创建时间格式
    NSDateFormatter * dateFormat=[[NSDateFormatter alloc] init];
    //设置本地化
    dateFormat.locale=[NSLocale localeWithLocaleIdentifier:@"CN"];
    [dateFormat setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSString * mydateStr = [dateFormat stringFromDate:myDate];
    
    
    return mydateStr;
}


+(NSString *)stringFromLiveTime:(NSInteger)startTime{
    NSString * publishTime = [NSString stringWithFormat:@"%ld",startTime];
    
    float timeV=[publishTime floatValue];
    //将对象类型的时间转换为NSDate类型
    NSDate * myDate=[NSDate dateWithTimeIntervalSince1970:timeV];
    
    //1.获取创建时间
    //    Thu Apr 21 11:01:03 +0800 2016
    //    EEE MMM dd HH:mm:ss Z yyyy
    //创建时间格式
    NSDateFormatter * dateFormat=[[NSDateFormatter alloc] init];
    //设置本地化
    dateFormat.locale=[NSLocale localeWithLocaleIdentifier:@"CN"];
    [dateFormat setDateFormat:@"MM/dd EEEE HH:mm"];
    NSString * mydateStr = [dateFormat stringFromDate:myDate];
    
    [dateFormat setDateFormat:@"EEEE"];
    NSString * week = [dateFormat stringFromDate:myDate];
    if ([week isEqualToString:@"Monday"]) {
        mydateStr = [mydateStr stringByReplacingOccurrencesOfString:week withString:@"星期一"];
    }else if ([week isEqualToString:@"Tuesday"]){
        mydateStr = [mydateStr stringByReplacingOccurrencesOfString:week withString:@"星期二"];
    }else if ([week isEqualToString:@"Wednesday"]){
        mydateStr = [mydateStr stringByReplacingOccurrencesOfString:week withString:@"星期三"];
    }else if ([week isEqualToString:@"Thursday"]){
        mydateStr = [mydateStr stringByReplacingOccurrencesOfString:week withString:@"星期四"];
    }else if ([week isEqualToString:@"Friday"]){
        mydateStr = [mydateStr stringByReplacingOccurrencesOfString:week withString:@"星期五"];
    }else if ([week isEqualToString:@"Saturday"]){
        mydateStr = [mydateStr stringByReplacingOccurrencesOfString:week withString:@"星期六"];
    }else if ([week isEqualToString:@"Sunday"]){
        mydateStr = [mydateStr stringByReplacingOccurrencesOfString:week withString:@"星期天"];
    }
    
    
    return mydateStr;
}


+(BOOL)isTimeToLive:(NSInteger)startTime{
    
    NSString * publishTime = [NSString stringWithFormat:@"%ld",startTime];
    
    float timeV=[publishTime floatValue];
    //将对象类型的时间转换为NSDate类型
    NSDate * myDate=[NSDate dateWithTimeIntervalSince1970:timeV];
    
    //1.获取创建时间
    //    Thu Apr 21 11:01:03 +0800 2016
    //    EEE MMM dd HH:mm:ss Z yyyy
    //创建时间格式
    NSDateFormatter * dateFormat=[[NSDateFormatter alloc] init];
    //设置本地化
    dateFormat.locale=[NSLocale localeWithLocaleIdentifier:@"CN"];
    [dateFormat setDateFormat:@"EEE MMM dd HH:mm:ss Z yyyy"];
    NSString * mydateStr = [dateFormat stringFromDate:myDate];
    NSDate * ctDate = [dateFormat dateFromString:mydateStr];
    
    //2.获取当前时间
    NSDate * nowDate=[NSDate date];
    
    //3.获取时间差
    //3.1 创建一个日历,获取当前日历
    NSCalendar * calendar=[NSCalendar currentCalendar];
    //3.2 设置日历筛选组件
    int unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    //3.3 通过日历获取时间差
    NSDateComponents * components=[calendar components:unit fromDate:ctDate toDate:nowDate options:NSCalendarWrapComponents];
    
    BOOL isToday=[calendar isDateInToday:ctDate];
    if (isToday) {
        if (components.hour == 0) {
            if (components.minute <= 30 && components.minute >= -30) {
                return YES;
            }else{
                return NO;
            }
        }else{
            return NO;
        }
    }else{
        return NO;
    }
    
}


+(NSString *)dateToString:(NSString *)time{
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY年MM月dd日 - HH时mm分"];
    NSDate * date = [formatter dateFromString:time];
    NSString * dateStr = [NSString stringWithFormat:@"%ld",(long)[date timeIntervalSince1970]];
    NSLog(@"startDateStr = %@",dateStr);
    return dateStr;
}

+(BOOL)isTimeToCreateLive:(NSString *)startTime{
    NSString * publishTime = [NSDate dateToString:startTime];
    float timeV=[publishTime floatValue];
    //将对象类型的时间转换为NSDate类型
    NSDate * myDate=[NSDate dateWithTimeIntervalSince1970:timeV];
    
    //1.获取创建时间
    //    Thu Apr 21 11:01:03 +0800 2016
    //    EEE MMM dd HH:mm:ss Z yyyy
    //创建时间格式
    NSDateFormatter * dateFormat=[[NSDateFormatter alloc] init];
    //设置本地化
    dateFormat.locale=[NSLocale localeWithLocaleIdentifier:@"CN"];
    [dateFormat setDateFormat:@"EEE MMM dd HH:mm:ss Z yyyy"];
    NSString * mydateStr = [dateFormat stringFromDate:myDate];
    NSDate * ctDate = [dateFormat dateFromString:mydateStr];
    
    //2.获取当前时间
    NSDate * nowDate=[NSDate date];
    
    //3.获取时间差
    //3.1 创建一个日历,获取当前日历
    NSCalendar * calendar=[NSCalendar currentCalendar];
    //3.2 设置日历筛选组件
    int unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    //3.3 通过日历获取时间差
    NSDateComponents * components=[calendar components:unit fromDate:ctDate toDate:nowDate options:NSCalendarWrapComponents];
    NSLog(@"%@",components);
    if (components.year < 1) {
        if (components.month < 1) {
            if (components.day <= 7) {
                return YES;
            }else{
                return NO;
            }
        }else{
            return NO;
        }
    }else{
        return NO;
    }
    
    
    //    //判断是否为今年
    //    int yearUnit=NSCalendarUnitYear;
    //    //1.获取创建时间的时间组件
    //    NSDateComponents * ctComp=[calendar components:yearUnit fromDate:ctDate];
    //    //2.获取当前时间的时间组件
    //    NSDateComponents * nowComp=[calendar components:yearUnit fromDate:nowDate];
    //    //如果年份相等，就是同一年
    //    if (ctComp.year==nowComp.year) {
    //        int monthUnit = NSCalendarUnitMonth;
    //        NSDateComponents * ctComp=[calendar components:monthUnit fromDate:ctDate];
    //        NSDateComponents * nowComp=[calendar components:monthUnit fromDate:nowDate];
    //        if (ctComp.month == nowComp.month) {
    //
    //        }else{
    //            return NO;
    //        }
    //    }else{
    //        return NO;
    //    }
    
}


+(NSDate *)utcTimeToLocaleDate{ //utc毫秒数转化为本地日期
    
    NSDate * date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date dateByAddingTimeInterval: interval];
    return localeDate;
}


+(NSString *)dateToDateString:(NSDate *)date{ //日期转化为字符串
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
//    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'hh:mm:ss'Z'"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    dateFormatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT-0800"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}


+(NSString *)utcTimeToDataString{
    NSDate *date = [NSDate utcTimeToLocaleDate];
    return [NSDate dateToDateString:date];
    //    //实例化一个NSDateFormatter对象
    //    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //    //设定时间格式,这里可以设置成自己需要的格式
    //    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
    //    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT-1200"]];
    //    NSDate * date = [NSDate date];
    //    NSString * dateString = [dateFormatter stringFromDate:date];
    //    return dateString;
}

+ (NSDate *)dateFromString:(NSString *)timeStr
                    format:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:format];
    NSDate *date = [dateFormatter dateFromString:timeStr];
    return date;
}
+ (NSInteger)cTimestampFromDate:(NSDate *)date{
    
    return (long)[date timeIntervalSince1970]  * 1000;
}

+(NSInteger)cTimestampFromString:(NSString *)timeStr
                          format:(NSString *)format{
    
    NSDate *date = [NSDate dateFromString:timeStr format:format];
    return [NSDate cTimestampFromDate:date];
}

+ (NSString *)dateStrFromCstampTime:(NSInteger)timeStamp
                     withDateFormat:(NSString *)format
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    return [NSDate datestrFromDate:date withDateFormat:format];
}

+ (NSString *)datestrFromDate:(NSDate *)date
               withDateFormat:(NSString *)format
{
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:format];
    return [dateFormat stringFromDate:date];
}



/**
 *  是否为今天
 */
- (BOOL)isToday
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear;
    
    // 1.获得当前时间的年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    
    // 2.获得self的年月日
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    return
    (selfCmps.year == nowCmps.year) &&
    (selfCmps.month == nowCmps.month) &&
    (selfCmps.day == nowCmps.day);
}

/**
 *  获得与当前时间的差距
 */
- (NSDateComponents *)deltaWithNow
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calendar components:unit fromDate:self toDate:[NSDate date] options:0];
}

/**
 * @method
 *
 * @brief 获取两个日期之间的天数
 * @param fromDate       起始日期
 * @param toDate         终止日期
 * @return    总天数
 */
+ (NSInteger)numberOfDaysWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents    * comp = [calendar components:NSCalendarUnitDay
                                             fromDate:fromDate
                                               toDate:toDate
                                              options:NSCalendarWrapComponents];
    return comp.day;
}

/**
 * @method
 *
 * @brief 获取两个日期之间的小时数
 * @param fromDate       起始日期
 * @param toDate         终止日期
 * @return   相差小时
 */
+ (NSInteger)numberOfHoursWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents    * comp = [calendar components:NSCalendarUnitHour
                                             fromDate:fromDate
                                               toDate:toDate
                                              options:NSCalendarWrapComponents];
    return comp.hour;
}

//获取当天0点时间
- (NSDate *)zeroOfDate
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSUIntegerMax fromDate:self];
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    
    // components.nanosecond = 0 not available in iOS
    NSTimeInterval ts = (double)(int)[[calendar dateFromComponents:components] timeIntervalSince1970];
    return [NSDate dateWithTimeIntervalSince1970:ts];
}
@end
