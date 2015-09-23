//
//  NSString+MXAddition.h
//  MXTTTXM
//
//  Created by Michael on 5/28/15.
//  Copyright (c) 2015 MXTTTXM UPUPUP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MXAddition)

/**
 *  将JSON字符串转换成字典
 *
 *  @return 字典
 */
- (NSDictionary *)MXJSONStringToDict;

/** 字符串md5加密 */
- (NSString *)md5;
/** sha1加密 */
- (NSString *)sha1;
/** 判断是否是合法的邮箱号 */
- (BOOL)isValidateEmail;
/** 判断字符串是否有空格 */
- (BOOL)hasSpaces;

@end
