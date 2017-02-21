//
//  NSString+MXAddition.h
//  MXTTTXM
//
//  Created by Michael on 5/28/15.
//  Copyright (c) 2015 MXTTTXM UPUPUP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MXAddition)

- (NSString *)mx_md5;

/**
 *  获取字符串所占字节数
 *
 *  @return 所占字节数
 */
- (int)mx_bytesCount;

/**
 *  从字符串中提取出网址
 *
 *  @return 字符串数组，可能为nil
 */
- (NSArray *)mx_findUrls;

/**
 *  判断字符串是否是合法的网址
 *
 */
- (BOOL)mx_isUrl;

/**
 *  判断是否是合法的邮箱
 *
 */
- (BOOL)mx_isEmail;

/**
 *  判断字符串是否有空格
 *
 */
- (BOOL)mx_hasSpace;

/**
 *  判断字符串是否全部为空格
 *
 */
- (BOOL)mx_isAllSpace;

/**
 *  判断字符串是否是纯数字
 *
 */
- (BOOL)mx_isPureDigit;

/**
 *  url解码
 *
 */
- (NSString *)mx_urlDecode;

//- (NSString *)mx_convertToChinese;

/**
 *  数字字符串转换成NSNumber类型
 *
 */
- (NSNumber *)mx_covertToNumber;

/**
 *  将JSON字符串转换成字典
 *
 *  @return 字典
 */

- (NSDictionary *)mx_covertToDictionary;

/**
 *  将JSON字符串转换成数组
 *
 *  @return 数组
 */
- (NSArray *)mx_covertToArray;

/**
 *  从一串字符串中截取指定字节数的字符串，如果所传的字节数大于字符串的所有字节数，则返回本身字符串的所有字节数
 *
 *  @param specifiedByteNum 指定字节数
 *
 *  @return sub string
 */
- (NSString *)mx_subStringWithByteCount:(NSInteger)byteCount;

/**
 *  随机生成字符串
 *
 *  @param Length 字符串长度
 *
 *  @return NSString
 */
+ (NSString *)mx_randomStringWithLength:(NSInteger)length;

@end
