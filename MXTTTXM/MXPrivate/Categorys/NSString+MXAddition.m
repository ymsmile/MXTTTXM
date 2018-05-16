//
//  NSString+MXAddition.m
//  MXTTTXM
//
//  Created by Michael on 5/28/15.
//  Copyright (c) 2015 MXTTTXM UPUPUP. All rights reserved.
//

#import "NSString+MXAddition.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (MXAddition)

- (NSString *)mx_md5 {
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [[NSString stringWithFormat:
             @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}

- (int)mx_bytesCount {
    int strlength = 0;
    char *p = (char *)[self cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i = 0; i < [self lengthOfBytesUsingEncoding:NSUnicodeStringEncoding]; i++) {
        if (*p) {
            p++;
            strlength++;
        } else {
            p++;
        }
    }
    return strlength;
}

- (NSArray *)mx_findUrls {
    if (self.length == 0) {
        return nil;
    }
    
    NSError *error;
    NSString *regulaStr = @"((http|ftp|https)://)(([a-zA-Z0-9\\._-]+\\.[a-zA-Z]{2,6})|([0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}))(:[0-9]{1,4})*(/[a-zA-Z0-9\\&%_\\./-~-]*)?";
    //    NSString *regulaStr = @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    NSArray *arrayOfAllMatches = [regex matchesInString:self options:0 range:NSMakeRange(0, [self length])];
    
    NSMutableArray *arr = [NSMutableArray array];
    for (NSTextCheckingResult *match in arrayOfAllMatches) {
        NSString *substringForMatch = [self substringWithRange:match.range];
        [arr addObject:substringForMatch];
    }
    
    return [arr copy];
}

- (BOOL)mx_isUrl {
    if (self.length == 0) {
        return NO;
    }
    NSString *regex = @"((http|ftp|https)://)(([a-zA-Z0-9\\._-]+\\.[a-zA-Z]{2,6})|([0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}))(:[0-9]{1,4})*(/[a-zA-Z0-9\\&%_\\./-~-]*)?";
    //    NSString *regex = @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}

- (BOOL)mx_isEmail {
    NSString *regex = @"\\b([a-zA-Z0-9%_.+\\-]+)@([a-zA-Z0-9.\\-]+?\\.[a-zA-Z]{2,6})\\b";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

- (BOOL)mx_hasSpace {
    NSRange range = [self rangeOfString:@" "];
    if (range.location != NSNotFound) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)mx_isAllSpace {
    if (!self) {
        return YES;
    } else {
        //A character set containing only the whitespace characters space (U+0020) and tab (U+0009) and the newline and nextline characters (U+000A–U+000D, U+0085).
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        
        //Returns a new string made by removing from both ends of the receiver characters contained in a given character set.
        NSString *trimedString = [self stringByTrimmingCharactersInSet:set];
        
        if ([trimedString length] == 0) {
            return YES;
        } else {
            return NO;
        }
    }
}

- (BOOL)mx_isPureDigit {
    NSScanner *scan = [NSScanner scannerWithString:self];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

- (NSString *)mx_urlDecode {
    NSString *decodedString = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                                                     (__bridge CFStringRef)self,
                                                                                                                     CFSTR(""),
                                                                                                                     CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    return decodedString;
}

- (NSNumber *)mx_covertToNumber {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    NSNumber *tmpNum = [formatter numberFromString:self];
    
    return tmpNum;
}

- (NSDictionary *)mx_covertToDictionary {
    if (self == nil) {
        return nil;
    }
    
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData
                                                         options:NSJSONReadingMutableContainers
                                                           error:&error];
    if (error) {
#if DEBUG
        NSLog(@"%s--Parse failed：%@", __PRETTY_FUNCTION__, error);
        return nil;
#endif
    }
    return dict;
}

- (NSArray *)mx_covertToArray {
    if (self == nil) {
        return nil;
    }
    
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSArray *arr = [NSJSONSerialization JSONObjectWithData:jsonData
                                                   options:NSJSONReadingMutableContainers
                                                     error:&error];
    if (error) {
#if DEBUG
        NSLog(@"%s--Parse failed：%@", __PRETTY_FUNCTION__, error);
#endif
        return nil;
    }
    return arr;
}

- (NSString *)mx_subStringWithByteCount:(NSInteger)byteCount {
    NSInteger sum = 0;
    NSString *subStr = [[NSString alloc] init];
    for(int i = 0; i < [self length]; i++) {
        unichar strChar = [self characterAtIndex:i];
        if(strChar < 256) {
            sum += 1;
        } else {
            sum += 2;
        }
        if (sum >= byteCount) {
            subStr = [self substringToIndex:i+1];
            return subStr;
        }
    }
    if (subStr.length > 0) {
        return subStr;
    } else {
        return self;
    }
}

+ (NSString *)mx_randomStringWithLength:(NSInteger)length {
    NSMutableString *randomString = [NSMutableString stringWithCapacity:length];
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    for (NSInteger i = 0; i < length; i++) {
        [randomString appendFormat:@"%c", [letters characterAtIndex:arc4random_uniform((int)[letters length])]];
    }
    return randomString;
}

- (CGSize)mx_sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)constrainedSize {
    if (!self) {
        return CGSizeZero;
    }
    
    NSMutableAttributedString *contentAttributedString = [[NSMutableAttributedString alloc] initWithString:self];
    [contentAttributedString addAttributes:@{NSFontAttributeName : font}
                                     range:NSMakeRange(0, self.length)];
    CGSize contentSize = [contentAttributedString boundingRectWithSize:constrainedSize
                                                               options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin
                                                               context:nil].size;
    return contentSize;
}

@end
