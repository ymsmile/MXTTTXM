//
//  MXTouchID.h
//  MXTTTXM
//
//  Created by Michael on 5/28/15.
//  Copyright (c) 2015 MXTTTXM UPUPUP. All rights reserved.
//
// https://developer.apple.com/library/ios/samplecode/KeychainTouchID/Listings/KeychainTouchID_AAPLAppDelegate_h.html#//apple_ref/doc/uid/TP40014530-KeychainTouchID_AAPLAppDelegate_h-DontLinkElementID_3

#import <Foundation/Foundation.h>

@interface MXTouchID : NSObject

+ (MXTouchID *)shareInstance;

/**
 *  To detect whether the device support fingerprint unlocked
 */
- (BOOL)isValid;

/**
 *  Verify fingerprint
 *
 *  @param block callback if verify successful or failed
 */
- (void)verify:(void(^)(BOOL success))block;

@end
