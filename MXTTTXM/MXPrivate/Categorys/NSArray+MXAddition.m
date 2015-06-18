//
//  NSArray+MXAddtion.m
//  MXTTTXM
//
//  Created by Michael on 5/28/15.
//  Copyright (c) 2015 MXTTTXM UPUPUP. All rights reserved.
//

#import "NSArray+MXAddition.h"

@implementation NSArray (MXAddition)

- (BOOL)isEmpty {
    if (self == nil)
        return YES;
    if ([self isKindOfClass:[NSArray class]]) {
        if ([self count] == 0) {
            return YES;
        } else {
            return NO;
        }
    }
    return YES;
}

- (BOOL)hasSameContents:(NSArray *)array {
    if (self.count == 0 || array == nil) {
        return NO;
    }
    
    if (![array isKindOfClass:[NSArray class]] && [array count] == 0) {
        return NO;
    }
    
    NSSet *a = [NSSet setWithArray:self];
    NSSet *b = [NSSet setWithArray:array];
    
    return [a isEqualToSet:b];
}

@end
