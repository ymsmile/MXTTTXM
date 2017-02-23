//
//  NSDate+MXAddition.h
//  MXTTTXM
//
//  Created by Michael on 1/11/16.
//  Copyright © 2016年 MXTTTXM UPUPUP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (MXAddition)

/**
 *  NSDate类型转换为时间字符串，格式为：yyyy-MM-dd HH:mm:ss
 */
- (NSString *)mx_covertToString;

/**
 *  获取当前时间，格式为：yyyy-MM-dd HH:mm:ss
 */
+ (NSString *)mx_nowTimeString;

/**
 *  获取当前时间戳
 */
+ (NSTimeInterval)mx_nowTimeInterval;

/**
 *  根据指定的时间（NSDate或NSString）获取时间戳
 *
 *  @param value 可能是NSDate类型，可能是时间字符串；如果都不是这两种类型，则返回0
 *
 */
+ (NSTimeInterval)mx_timeIntervalWithDate:(id)value;

/**
 *  根据时间戳获取时间字符串
 */
+ (NSString *)mx_stringWithTimeInterval:(NSNumber *)time;

/**
 *  判断与今天是否为同一天
 *
 *  @param value 可能是NSDate类型，可能是时间字符串；如果都不是这两种类型，则返回NO
 *
 */
+ (BOOL)mx_isSameDayWithDate:(id)value;

@end
