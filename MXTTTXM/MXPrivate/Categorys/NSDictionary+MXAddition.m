//
//  NSDictionary+MXAddition.m
//  MXTTTXM
//
//  Created by Michael on 5/28/15.
//  Copyright (c) 2015 MXTTTXM UPUPUP. All rights reserved.
//

#import "NSDictionary+MXAddition.h"

@implementation NSDictionary (MXAddition)

- (id)safeObjectForKey:(NSString *)key {
    id value = [self valueForKey:key];
    if ([value isEqual:[NSNull null]]) {
        return nil;
    }
    return value;
}

- (NSString *)MXDictToJSONStirng {
    NSError *parseError = nil;
    NSData  *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                        options:NSJSONWritingPrettyPrinted
                                                          error:&parseError];
    return [[NSString alloc] initWithData:jsonData
                                 encoding:NSUTF8StringEncoding];
}

- (BOOL)isEmpty {
    if (self == nil)
        return YES;
    if ([self isKindOfClass:[NSDictionary class]]) {
        if ([self count] == 0) {
            return YES;
        } else {
            return NO;
        }
    }
    return YES;
}

@end
