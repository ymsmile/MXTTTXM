//
//  NSDictionary+MXAddition.h
//  MXTTTXM
//
//  Created by Michael on 5/28/15.
//  Copyright (c) 2015 MXTTTXM UPUPUP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (MXAddtion)

/**
 *  将字典转换成JSON字符串
 *
 *  @return JSON字符串
 */
- (NSString *)dictToJSONStirng;

/**
 *  判断字典是否为空，keys为空，或者不是NSDictionary类型
 *
 *  @return YES/NO
 */
//- (BOOL)isEmpty;

/**
 *  判断如果有某key的value是否为空字符串或者<null>
 *
 */
- (BOOL)hasEmptyValue;

- (BOOL)isValidValueWithKey:(NSString *)key;

#pragma mark - 取值

- (BOOL)mx_isKindOfClass:(Class)aClass forKey:(NSString *)key;
- (BOOL)mx_isMemberOfClass:(Class)aClass forKey:(NSString *)key;
- (BOOL)mx_isArrayForKey:(NSString *)key;
- (BOOL)mx_isDictionaryForKey:(NSString *)key;
- (BOOL)mx_isStringForKey:(NSString *)key;
- (BOOL)mx_isNumberForKey:(NSString *)key;

- (NSArray *)mx_arrayForKey:(NSString *)key;
- (NSDictionary *)mx_dictionaryForKey:(NSString *)key;
- (NSString *)mx_stringForKey:(NSString *)key;
- (NSNumber *)mx_numberForKey:(NSString *)key;
- (double)mx_doubleForKey:(NSString *)key;
- (float)mx_floatForKey:(NSString *)key;
- (int)mx_intForKey:(NSString *)key;
- (unsigned int)mx_unsignedIntForKey:(NSString *)key;
- (NSInteger)mx_integerForKey:(NSString *)key;
- (NSUInteger)mx_unsignedIntegerForKey:(NSString *)key;
- (long long)mx_longLongForKey:(NSString *)key;
- (unsigned long long)mx_unsignedLongLongForKey:(NSString *)key;
- (BOOL)mx_boolForKey:(NSString *)key;

@end


