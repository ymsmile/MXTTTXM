//
//  NSObject+MXAddition.m
//  MXTTTXM
//
//  Created by Michael on 6/4/15.
//  Copyright (c) 2015 MXTTTXM UPUPUP. All rights reserved.
//

#import "NSObject+MXAddition.h"

@implementation NSObject (MXAddition)

- (BOOL)isEmptyObject {
    
    if (self == nil) {
        return YES;
    }
    
    if ([self isEqual:[NSNull null]]) {
        return YES;
    }
    
    if ([self isKindOfClass:[NSString class]]) {
        if ([(NSString *)self length] == 0) {
            return YES;
        }
    }
    
    if ([self isKindOfClass:[NSArray class]]) {
        if ([(NSArray *)self count] == 0) {
            return YES;
        }
    }
    
    if ([self isKindOfClass:[NSDictionary class]]) {
        if ([(NSDictionary *)self count] == 0) {
            return YES;
        }
    }
    
    return NO;
}

@end
