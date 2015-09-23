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
//        NSLog(@"=%@=", tmpStr);
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

+ (NSString *)getCurrentTime {
    NSDate *nowUTC = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [dateFormatter stringFromDate:nowUTC];
}

@end
