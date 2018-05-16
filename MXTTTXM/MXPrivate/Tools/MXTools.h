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
 *  获取当前时间字符串，格式为yyyy-MM-dd HH:mm:ss
 */
+ (NSString *)getCurrentTime;

/**
 *  利用正则表达式找出匹配的内容
 *
 *  @param string 被匹配的字符串
 *  @param regex  正则表达式
 *
 *  @return 匹配的内容数组
 */
+ (NSArray *)match:(NSString *)string withRegex:(NSString *)regex;

/**
 *  获取当前版本号，如2.6.0
 */
+ (NSString *)getAppVersion;

/**
 *  获取手机类型，iPhone6、iPhone6s等等
 */
+ (NSString *)getPhoneMode;

/**
 *  获取Document路径
 */
+ (NSString *)getDocPath;

/**
 *  unicode码转中文
 */
+ (NSString *)convertToChinese:(NSString *)unicodeStr;

/**
 *  判断是否是主线程：http://www.jianshu.com/p/d15f4b37b0f2
 */
+ (BOOL)isMainQueue;

/**
 *  获取手机公网IP地址
 */
+ (NSString *)getIPAddress;

/**
 *  数字转化为千位字符串，若参数小鱼1000，则直接返回数字。如1876转为1.9k、如1475转为1.5k
 *
 *  @param num 数字
 *
 */
+ (NSString *)calculateThousandForInteger:(NSInteger)num;

@end
