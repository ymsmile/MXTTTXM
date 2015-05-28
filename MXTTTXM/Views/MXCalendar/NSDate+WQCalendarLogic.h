//
//  NSDate+WQCalendarLogic.h
//  WQCalendar
//
//  Created by Jason Lee on 14-3-4.
//  Copyright (c) 2014年 Jason Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (WQCalendarLogic)
// 这个月有多少天
- (NSUInteger)numberOfDaysInCurrentMonth;
// 这个月有多少周
- (NSUInteger)numberOfWeeksInCurrentMonth;
//
- (NSUInteger)weeklyOrdinality;

- (NSUInteger)monthlyOrdinality;

- (NSDate *)firstDayOfCurrentMonth;

- (NSDate *)lastDayOfCurrentMonth;

- (NSDate *)dayInThePreviousMonth;

- (NSDate *)dayInTheFollowingMonth;

- (NSDateComponents *)YMDComponents;

- (NSUInteger)weekNumberInCurrentMonth;

@end
