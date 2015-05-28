//
//  NSString+MXAddtion.h
//  MXTTTXM
//
//  Created by Michael on 5/28/15.
//  Copyright (c) 2015 MXTTTXM UPUPUP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MXAddtion)

/**
 *  将JSON字符串转换成字典
 *
 *  @return 字典
 */
- (NSDictionary *)MXJSONStringToDict;

/**
 *  字符串md5加密
 *
 *  @return 加密后的字符串
 */
- (NSString *)MXMD5;

@end
