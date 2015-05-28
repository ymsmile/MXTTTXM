//
//  MXTools.h
//  MXTTTXM
//
//  Created by Michael on 5/28/15.
//  Copyright (c) 2015 MXTTTXM UPUPUP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MXTools : NSObject

/**
 *  利用正则表达式找出匹配的内容
 *
 *  @param string 被匹配的字符串
 *  @param regex  正则表达式
 *
 *  @return 匹配的内容数组
 */
+ (NSArray *)match:(NSString *)string withRegex:(NSString *)regex;

@end
