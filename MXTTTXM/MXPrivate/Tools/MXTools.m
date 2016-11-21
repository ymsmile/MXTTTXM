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

@end
