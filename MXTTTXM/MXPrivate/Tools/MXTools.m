//
//  MXTools.m
//  MXTTTXM
//
//  Created by Michael on 5/28/15.
//  Copyright (c) 2015 MXTTTXM UPUPUP. All rights reserved.
//

#import "MXTools.h"
#import <CommonCrypto/CommonDigest.h>

@implementation MXTools

+ (NSArray *)match:(NSString *)string withRegex:(NSString *)regex {
    NSError *error;
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:regex
                                                                                       options:NSRegularExpressionCaseInsensitive
                                                                                         error:&error];
    NSArray *matchResults = [regularExpression matchesInString:string options:0 range:NSMakeRange(0, string.length)];
    NSString *tmpStr = @"";
    NSMutableArray *matchs = [NSMutableArray array];
    for (NSTextCheckingResult *match in matchResults) {
        NSRange matchRange = [match range];
        tmpStr = [string substringWithRange:matchRange];
        [matchs addObject:tmpStr];
    }
    return matchs;
}

+ (NSString *)getAppVersion {
    NSString *v = [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return v;
}

+ (NSString *)convertToChinese:(NSString *)unicodeStr {
    if (!unicodeStr)
        return @"can not convert!";
    NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
    NSString *tempStr3 = [[@"\""stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                                                           mutabilityOption:NSPropertyListImmutable
                                                                     format:NULL
                                                           errorDescription:NULL];
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];
}

+ (NSString *)getPhoneMode {
    NSString *str = [[UIDevice currentDevice] hardwareSimpleDescription];
    str = [str stringByReplacingOccurrencesOfString:@" " withString:@"_"];
    
    return str;
}

+ (BOOL)isMainQueue {
    static const void* mainQueueKey = @"mainQueue";
    static void* mainQueueContext = @"mainQueue";
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dispatch_queue_set_specific(dispatch_get_main_queue(), mainQueueKey, mainQueueContext, nil);
    });
    
    return dispatch_get_specific(mainQueueKey) == mainQueueContext;
}

+ (NSString *)getIPAddress {
    // http://superdanny.link/2016/01/27/iOS-get-device-ip-address/
    NSURL *ipURL = [NSURL URLWithString:@"http://ipof.in/txt"];
    NSString *ip = [NSString stringWithContentsOfURL:ipURL encoding:NSUTF8StringEncoding error:NULL];
    return ip;
}

+ (NSString *)calculateThousandForInteger:(NSInteger)num {
    if (num < 1000) {
        return [NSString stringWithFormat:@"%@", @(num)];
    } else {
        NSInteger qian = num / 1000;
        NSInteger qian_yu = num % 1000;
        NSInteger bai = 0;
        NSInteger shi = 0;
        NSInteger bai_yu = 0;
        if (qian_yu > 100) {
            bai = qian_yu / 100;
            bai_yu = qian_yu % 100;
            if (bai_yu > 10) {
                shi = bai_yu / 10;
            }
        }
        if (bai == 0) {
            if (shi >= 5) {
                return [NSString stringWithFormat:@"%@.1k", @(qian)];
            } else {
                return [NSString stringWithFormat:@"%@k", @(qian)];
            }
        }
        else if (bai == 9) {
            if (shi >= 5) {
                return [NSString stringWithFormat:@"%@k", @(qian+1)];
            } else {
                return [NSString stringWithFormat:@"%@.%@k", @(qian), @(bai)];
            }
        }
        else {
            if (shi >= 5) {
                return [NSString stringWithFormat:@"%@.%@k", @(qian), @(bai+1)];
            } else {
                return [NSString stringWithFormat:@"%@.%@k", @(qian), @(bai)];
            }
        }
    }
}

@end
