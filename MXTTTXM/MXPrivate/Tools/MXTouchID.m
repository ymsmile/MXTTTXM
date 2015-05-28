//
//  MXTouchID.m
//  MXTTTXM
//
//  Created by Michael on 5/28/15.
//  Copyright (c) 2015 MXTTTXM UPUPUP. All rights reserved.
//

#import "MXTouchID.h"
#import <LocalAuthentication/LocalAuthentication.h>

@implementation MXTouchID

+ (MXTouchID *)shareInstance {
    static MXTouchID *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [MXTouchID new];
    });
    return instance;
}

- (BOOL)isValid {
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    LAContext *context = [[LAContext alloc] init];
    NSError *error;
    // test if we can evaluate the policy, this test will tell us if Touch ID is available and enrolled
    return [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                                        error:&error];
#else
    printf("System version is less than 8.0");
    return NO;
#endif
}

- (void)verify:(void(^)(BOOL success))block {
    if ([self isValid]) {
        LAContext *context = [[LAContext alloc] init];
        // A default title "Enter Password" is used when this property is left nil. If set to empty string, the button will be hidden.
        context.localizedFallbackTitle = @"";
        // show the authentication UI with our reason string
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                localizedReason:@"Custom reasons you need"
                          reply:^(BOOL success, NSError *error) {
                              dispatch_async(dispatch_get_main_queue(), ^{
                                  block(success);
                              });
                          }];
    } else {
        block(NO);
    }
}

@end
