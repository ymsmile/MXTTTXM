//
//  NSDate+MXAddition.m
//  PretendLover
//
//  Created by Michael on 1/11/16.
//  Copyright © 2016年 Duidui Technology Co., Ltd. All rights reserved.
//

#import "NSDate+MXAddition.h"

@implementation NSDate (MXAddition)

- (NSString *)mx_covertToString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [dateFormatter stringFromDate:self];
}

+ (NSString *)mx_nowTimeString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [dateFormatter stringFromDate:[NSDate date]];
}

+ (NSTimeInterval)mx_nowTimeInterval {
    return [[NSDate date] timeIntervalSince1970];
}

+ (NSTimeInterval)mx_timeIntervalWithDate:(id)value {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    if ([value isKindOfClass:[NSString class]]) {
        NSDate *date = [formatter dateFromString:value];
        return [date timeIntervalSince1970];
        
    } else if ([value isKindOfClass:[NSDate class]]) {
        return [(NSDate *)value timeIntervalSince1970];
    } else {
        return 0.f;
    }
}

+ (NSString *)mx_stringWithTimeInterval:(NSNumber *)time {
    NSString *str = [NSString stringWithFormat:@"%@", time];
    NSTimeInterval timeInterval;
    if (str.length > 10) {
        timeInterval = [time longLongValue] / 1000;
    } else {
        timeInterval = [time longLongValue];
    }
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    return [dateFormatter stringFromDate:date];
}

+ (BOOL)mx_isSameDayWithDate:(id)value {
    if (!value) {
        return NO;
    }
    NSString *originString;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    if ([value isKindOfClass:[NSDate class]]) {
        originString = [formatter stringFromDate:value];
    } else if ([value isKindOfClass:[NSString class]]) {
        // @"yyyy-MM-dd HH:mm:ss"
        originString = [[value componentsSeparatedByString:@" "] firstObject];
    } else {
        return NO;
    }
    
    NSDate *nowDate = [NSDate date];
    NSString *nowString = [formatter stringFromDate:nowDate];
    
    NSInteger originYear = [[originString componentsSeparatedByString:@"-"][0] integerValue];
    NSInteger originMonth = [[originString componentsSeparatedByString:@"-"][1] integerValue];
    NSInteger originDay = [[originString componentsSeparatedByString:@"-"][2] integerValue];
    
    NSInteger nowYear = [[nowString componentsSeparatedByString:@"-"][0] integerValue];
    NSInteger nowMonth = [[nowString componentsSeparatedByString:@"-"][1] integerValue];
    NSInteger nowDay = [[nowString componentsSeparatedByString:@"-"][2] integerValue];
    
    if ((nowYear == originYear) && (nowMonth == originMonth) && (nowDay == originDay)) {
        return YES;
    } else {
        return NO;
    }
}

#pragma mark - 时间字符串处理

/** 根据时间戳，获取星期几上午下午，格式为『星期二下午』、『星期六上午』等 */
+ (NSString *)getWeekStringWithTimeInterval:(NSTimeInterval)timeInterval {
    //    NSLog(@"---%@", @(timeInterval));
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    return [NSString stringWithFormat:@"%@%@", [NSDate weekDayWithDate:date],
            [NSDate timeDayWithDate:date]];
}

// 根据时间字符串获取格式字符串(当天时间直接返回时间，昨天的返回“昨天 + 时间”，一个星期之内的返回“星期 + 时间” 时间间隔大于一个星期的返回“xxxx年xx月xx日 + 时间”)
+ (NSString *)getDetailTimeStringWithDateString:(NSString *)dateString {
    NSDate *date = [self dateFromDateString:dateString withFormatter:@"yyyy-MM-dd HH:mm:ss"];
    if (date == nil) {
        dateString = [dateString substringToIndex:dateString.length-3];
        dateString = [NSString stringWithFormat:@"2015-%@:00",dateString];
        
        date = [self dateFromDateString:dateString withFormatter:@"yyyy-MM-dd HH:mm:ss"];
    }
    
    NSTimeInterval delta = [[self getCurrentDayLatestDate] timeIntervalSinceDate:date];
    
    
    NSString *timeString = [self getDateStringFromDateString:dateString formatterString:@"HH:mm"];
    
    NSString *year = [dateString substringToIndex:4];
    
    if ([year isEqualToString:[self getCurrentYearString]]) {
        if (delta < 60 * 60 * 24) {
            
        } else if (delta < 60 * 60 * 24 * 2) {
            timeString = [NSString stringWithFormat:@"%@ %@", @"昨天", timeString];
        } else if (delta < 60 * 60 * 24 * 7) {
            timeString = [NSString stringWithFormat:@"%@ %@", [self getDateStringFromDateString:dateString formatterString:@"MM-dd"], timeString];//[NSString stringWithFormat:@"%@ %@", [self weekDayWithDate:date],timeString];
        } else {
            timeString = [NSString stringWithFormat:@"%@ %@", [self getDateStringFromDateString:dateString formatterString:@"MM-dd"], timeString];
        }
    } else {
        timeString = [NSString stringWithFormat:@"%@ %@",[self getDateStringFromDateString:dateString formatterString:@"yyyy-MM-dd"], timeString];
    }
    
    return timeString;
}

#pragma mark 获取当天最晚的时间
+ (NSDate *)getCurrentDayLatestDate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSMutableString *currentDayString = [[formatter stringFromDate:[NSDate date]] mutableCopy];
    [currentDayString appendString:@" 23:59"];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *date = [formatter dateFromString:currentDayString];
    return date;
}

#pragma mark 根据时间字符串和时间格式转换时间字符串
+(NSString *)getDateStringFromDateString:(NSString *)dateString formatterString:(NSString *)formatterString {
    NSDate *date = [self dateFromDateString:dateString withFormatter:@"yyyy-MM-dd HH:mm:ss"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:formatterString];
    NSString *dateStr = [formatter stringFromDate:date];
    
    return dateStr;
}

#pragma mark 根据时间字符串格式化日期
+ (NSDate *)dateFromDateString:(NSString *)dateString withFormatter:(NSString *)fromatterString {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:fromatterString];
    NSDate *date = [formatter dateFromString:dateString];
    return date;
}

#pragma mark 根据日期获得星期
+ (NSString *)weekDayWithDate:(NSDate *)date
{
    NSArray *week = @[@"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六"];
    NSDateComponents *weekdayComponents = [[self createCalendar] components:(NSCalendarUnitDay | NSCalendarUnitWeekday) fromDate:date];
    
    return week[[weekdayComponents weekday] - 1];
}

+ (NSString *)timeDayWithDate:(NSDate *)date {
    NSDateComponents *weekdayComponents = [[self createCalendar] components:(NSCalendarUnitHour | NSCalendarUnitMinute|NSCalendarUnitSecond) fromDate:date];
    
    NSString *str = @"";
    NSInteger hour = [weekdayComponents hour];
    if (hour >= 6 && hour < 12) {
        str = @"上午";
    } else if (hour >= 12 && hour < 13) {
        str = @"中午";
    } else if (hour >= 13 && hour < 18) {
        str = @"下午";
    } else if (hour >= 19 && hour < 24) {
        str = @"晚上";
    } else {
        str = @"凌晨";
    }
    
    return str;
}

#pragma mark 创建日历
+ (NSCalendar *)createCalendar {
    //创建calendar
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    //设置周的开始，1代表星期日，后面以此类推
    [calendar setFirstWeekday:2];
    
    //设置设置区域，@"zh_CN"代表中国
    [calendar setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    
    //设定作为(每年及每月)第一周必须包含的最少天数，比如:.  如需设定第一周最少包括7天，则value传入7
    [calendar setMinimumDaysInFirstWeek:7];
    
    //设置时区
    [calendar setTimeZone:[NSTimeZone defaultTimeZone]];
    
    return calendar;
}

+ (NSString *)getCurrentYearString {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    
    return [formatter stringFromDate:[NSDate date]];
}

@end
