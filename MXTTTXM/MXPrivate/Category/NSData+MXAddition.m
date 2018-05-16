//
//  NSData+MXAddition.m
//  MXTTTXM
//
//  Created by Michael on 5/28/15.
//  Copyright (c) 2015 MXTTTXM UPUPUP. All rights reserved.
//

#import "NSData+MXAddition.h"

@implementation NSData (MXAddition)

- (NSDictionary *)mx_covertToDictionary {
    NSError *parseError = nil;
    id value = [NSJSONSerialization JSONObjectWithData:self options:NSJSONReadingMutableContainers error:&parseError];
    
    if (parseError) {
#if DEBUG
        NSLog(@"%s--Parse failed：%@", __PRETTY_FUNCTION__, parseError);
        return nil;
#endif
    }
    
    if (value && [value isKindOfClass:[NSDictionary class]]) {
        return value;
    } else {
        return nil;
    }
}

@end
