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
 *  安全的获取字典里面的值
 *
 *  @param key key
 *
 *  @return value
 */
- (id)safeObjectForKey:(NSString *)key;

/**
 *  将字典转换成JSON字符串
 *
 *  @return JSON字符串
 */
- (NSString *)MXDictToJSONStirng;

/**
 *  判断字典是否为空，keys为空，或者不是NSDictionary类型
 *
 *  @return YES/NO
 */
//- (BOOL)isEmpty;

@end
