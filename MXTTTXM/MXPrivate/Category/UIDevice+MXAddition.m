//
//  UIDevice+Hardware.m
//  EnjoyHomePlus
//
//  Created by Michael on 2017/09/30.
//  Copyright © 2017年 Tianlin Inc. All rights reserved.
//

#import "UIDevice+MXAddition.h"

#include <sys/types.h>
#include <sys/sysctl.h>

@implementation UIDevice (MXAddition)

- (NSString *)hardwareModeID {
    int name[] = {CTL_HW,HW_MACHINE};
    size_t size = 100;
    sysctl(name, 2, NULL, &size, NULL, 0); // getting size of answer
    char *hw_machine = malloc(size);
    
    sysctl(name, 2, hw_machine, &size, NULL, 0);
    NSString *modeID = [NSString stringWithUTF8String:hw_machine];
    free(hw_machine);
    return modeID;
}

- (Hardware)hardware {
    NSString *modeID = [self hardwareModeID];
    if ([modeID isEqualToString:@"iPhone1,1"])    return IPHONE_2G;
    if ([modeID isEqualToString:@"iPhone1,2"])    return IPHONE_3G;
    if ([modeID isEqualToString:@"iPhone2,1"])    return IPHONE_3GS;
    if ([modeID isEqualToString:@"iPhone3,1"])    return IPHONE_4;
    if ([modeID isEqualToString:@"iPhone3,2"])    return IPHONE_4;
    if ([modeID isEqualToString:@"iPhone3,3"])    return IPHONE_4;
    if ([modeID isEqualToString:@"iPhone4,1"])    return IPHONE_4S;
    if ([modeID isEqualToString:@"iPhone5,1"])    return IPHONE_5;
    if ([modeID isEqualToString:@"iPhone5,2"])    return IPHONE_5;
    if ([modeID isEqualToString:@"iPhone5,3"])    return IPHONE_5C;
    if ([modeID isEqualToString:@"iPhone5,4"])    return IPHONE_5C;
    if ([modeID isEqualToString:@"iPhone6,1"])    return IPHONE_5S;
    if ([modeID isEqualToString:@"iPhone6,2"])    return IPHONE_5S;
    if ([modeID isEqualToString:@"iPhone7,1"])    return IPHONE_6_PLUS;
    if ([modeID isEqualToString:@"iPhone7,2"])    return IPHONE_6;
    if ([modeID isEqualToString:@"iPhone8,1"])    return IPHONE_6S;
    if ([modeID isEqualToString:@"iPhone8,2"])    return IPHONE_6S_PLUS;
    if ([modeID isEqualToString:@"iPhone8,4"])    return IPHONE_SE;
    if ([modeID isEqualToString:@"iPhone9,1"])    return IPHONE_7;
    if ([modeID isEqualToString:@"iPhone9,3"])    return IPHONE_7;
    if ([modeID isEqualToString:@"iPhone9,2"])    return IPHONE_7_PLUS;
    if ([modeID isEqualToString:@"iPhone9,4"])    return IPHONE_7_PLUS;
    if ([modeID isEqualToString:@"iPhone10,1"])   return IPHONE_8;
    if ([modeID isEqualToString:@"iPhone10,4"])   return IPHONE_8;
    if ([modeID isEqualToString:@"iPhone10,2"])   return IPHONE_8_PLUS;
    if ([modeID isEqualToString:@"iPhone10,5"])   return IPHONE_8_PLUS;
    if ([modeID isEqualToString:@"iPhone10,3"])   return IPHONE_X;
    if ([modeID isEqualToString:@"iPhone10,6"])   return IPHONE_X;
    
    if ([modeID isEqualToString:@"iPod1,1"])      return IPOD_TOUCH_1G;
    if ([modeID isEqualToString:@"iPod2,1"])      return IPOD_TOUCH_2G;
    if ([modeID isEqualToString:@"iPod3,1"])      return IPOD_TOUCH_3G;
    if ([modeID isEqualToString:@"iPod4,1"])      return IPOD_TOUCH_4G;
    if ([modeID isEqualToString:@"iPod5,1"])      return IPOD_TOUCH_5G;
    if ([modeID isEqualToString:@"iPod7,1"])      return IPOD_TOUCH_6G;
    
    if ([modeID isEqualToString:@"iPad1,1"])      return IPAD;
    if ([modeID isEqualToString:@"iPad1,2"])      return IPAD_3G;
    if ([modeID isEqualToString:@"iPad2,1"])      return IPAD_2_WIFI;
    if ([modeID isEqualToString:@"iPad2,2"])      return IPAD_2;
    if ([modeID isEqualToString:@"iPad2,3"])      return IPAD_2_CDMA;
    if ([modeID isEqualToString:@"iPad2,4"])      return IPAD_2;
    if ([modeID isEqualToString:@"iPad2,5"])      return IPAD_MINI_WIFI;
    if ([modeID isEqualToString:@"iPad2,6"])      return IPAD_MINI;
    if ([modeID isEqualToString:@"iPad2,7"])      return IPAD_MINI_WIFI_CDMA;
    if ([modeID isEqualToString:@"iPad3,1"])      return IPAD_3_WIFI;
    if ([modeID isEqualToString:@"iPad3,2"])      return IPAD_3_WIFI_CDMA;
    if ([modeID isEqualToString:@"iPad3,3"])      return IPAD_3;
    if ([modeID isEqualToString:@"iPad3,4"])      return IPAD_4_WIFI;
    if ([modeID isEqualToString:@"iPad3,5"])      return IPAD_4;
    if ([modeID isEqualToString:@"iPad3,6"])      return IPAD_4_GSM_CDMA;
    if ([modeID isEqualToString:@"iPad4,1"])      return IPAD_AIR_WIFI;
    if ([modeID isEqualToString:@"iPad4,2"])      return IPAD_AIR_WIFI_GSM;
    if ([modeID isEqualToString:@"iPad4,3"])      return IPAD_AIR_WIFI_CDMA;
    if ([modeID isEqualToString:@"iPad4,4"])      return IPAD_MINI_RETINA_WIFI;
    if ([modeID isEqualToString:@"iPad4,5"])      return IPAD_MINI_RETINA_WIFI_CDMA;
    if ([modeID isEqualToString:@"iPad4,6"])      return IPAD_MINI_RETINA_WIFI_CELLULAR_CN;
    if ([modeID isEqualToString:@"iPad4,7"])      return IPAD_MINI_3_WIFI;
    if ([modeID isEqualToString:@"iPad4,8"])      return IPAD_MINI_3_WIFI_CELLULAR;
    if ([modeID isEqualToString:@"iPad5,3"])      return IPAD_AIR_2_WIFI;
    if ([modeID isEqualToString:@"iPad5,4"])      return IPAD_AIR_2_WIFI_CELLULAR;
    if ([modeID isEqualToString:@"iPad6,3"])      return IPAD_PRO_97_WIFI;
    if ([modeID isEqualToString:@"iPad6,4"])      return IPAD_PRO_97_WIFI_CELLULAR;
    if ([modeID isEqualToString:@"iPad6,7"])      return IPAD_PRO_WIFI;
    if ([modeID isEqualToString:@"iPad6,8"])      return IPAD_PRO_WIFI_CELLULAR;
    if ([modeID isEqualToString:@"iPad6,11"])     return IPAD_5_WIFI;
    if ([modeID isEqualToString:@"iPad6,12"])     return IPAD_5_WIFI_CELLULAR;
    if ([modeID isEqualToString:@"iPad7,1"])      return IPAD_PRO_2G_WIFI;
    if ([modeID isEqualToString:@"iPad7,2"])      return IPAD_PRO_2G_WIFI_CELLULAR;
    if ([modeID isEqualToString:@"iPad7,3"])      return IPAD_PRO_105_WIFI;
    if ([modeID isEqualToString:@"iPad7,4"])      return IPAD_PRO_105_WIFI_CELLULAR;
    
    if ([modeID isEqualToString:@"AppleTV1,1"])   return APPLE_TV_1G;
    if ([modeID isEqualToString:@"AppleTV2,1"])   return APPLE_TV_2G;
    if ([modeID isEqualToString:@"AppleTV3,1"])   return APPLE_TV_3G;
    if ([modeID isEqualToString:@"AppleTV3,1"])   return APPLE_TV_3_2G;
    if ([modeID isEqualToString:@"AppleTV5,3"])   return APPLE_TV_4G;
    
    if ([modeID isEqualToString:@"Watch1,1"])     return APPLE_WATCH_38;
    if ([modeID isEqualToString:@"Watch1,2"])     return APPLE_WATCH_42;
    if ([modeID isEqualToString:@"Watch2,3"])     return APPLE_WATCH_SERIES_2_38;
    if ([modeID isEqualToString:@"Watch2,4"])     return APPLE_WATCH_SERIES_2_42;
    if ([modeID isEqualToString:@"Watch2,6"])     return APPLE_WATCH_SERIES_1_38;
    if ([modeID isEqualToString:@"Watch2,7"])     return APPLE_WATCH_SERIES_1_42;
    
    if ([modeID isEqualToString:@"i386"])         return SIMULATOR;
    if ([modeID isEqualToString:@"x86_64"])       return SIMULATOR;
    if ([modeID hasPrefix:@"iPhone"])             return SIMULATOR;
    if ([modeID hasPrefix:@"iPod"])               return SIMULATOR;
    if ([modeID hasPrefix:@"iPad"])               return SIMULATOR;
    
    // log message that your device is not present in the list
    [self logMessage:modeID];
    
    return NOT_AVAILABLE;
}

- (NSString *)hardwareTypeString {
    NSString *modeID = [self hardwareModeID];
    if ([modeID isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([modeID isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([modeID isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([modeID isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([modeID isEqualToString:@"iPhone3,2"])    return @"iPhone 4";
    if ([modeID isEqualToString:@"iPhone3,3"])    return @"iPhone 4";
    if ([modeID isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([modeID isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([modeID isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([modeID isEqualToString:@"iPhone5,3"])    return @"iPhone 5c";
    if ([modeID isEqualToString:@"iPhone5,4"])    return @"iPhone 5c";
    if ([modeID isEqualToString:@"iPhone6,1"])    return @"iPhone 5s";
    if ([modeID isEqualToString:@"iPhone6,2"])    return @"iPhone 5s";
    if ([modeID isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([modeID isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([modeID isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([modeID isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([modeID isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    if ([modeID isEqualToString:@"iPhone9,1"])    return @"iPhone 7";
    if ([modeID isEqualToString:@"iPhone9,3"])    return @"iPhone 7";
    if ([modeID isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus";
    if ([modeID isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus";
    if ([modeID isEqualToString:@"iPhone10,1"])   return @"iPhone 8";
    if ([modeID isEqualToString:@"iPhone10,4"])   return @"iPhone 8";
    if ([modeID isEqualToString:@"iPhone10,2"])   return @"iPhone 8 Plus";
    if ([modeID isEqualToString:@"iPhone10,5"])   return @"iPhone 8 Plus";
    if ([modeID isEqualToString:@"iPhone10,3"])   return @"iPhone X";
    if ([modeID isEqualToString:@"iPhone10,6"])   return @"iPhone X";
    
    if ([modeID isEqualToString:@"iPod1,1"])      return @"iPod_Touch_1G";
    if ([modeID isEqualToString:@"iPod2,1"])      return @"iPod_Touch_2G";
    if ([modeID isEqualToString:@"iPod3,1"])      return @"iPod_Touch_3G";
    if ([modeID isEqualToString:@"iPod4,1"])      return @"iPod_Touch_4G";
    if ([modeID isEqualToString:@"iPod5,1"])      return @"iPod_Touch_5G";
    if ([modeID isEqualToString:@"iPod7,1"])      return @"iPod_Touch_6G";
    
    if ([modeID isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([modeID isEqualToString:@"iPad1,2"])      return @"iPad 3G";
    if ([modeID isEqualToString:@"iPad2,1"])      return @"iPad 2";
    if ([modeID isEqualToString:@"iPad2,2"])      return @"iPad 2";
    if ([modeID isEqualToString:@"iPad2,3"])      return @"iPad 2";
    if ([modeID isEqualToString:@"iPad2,4"])      return @"iPad 2";
    if ([modeID isEqualToString:@"iPad2,5"])      return @"iPad Mini";
    if ([modeID isEqualToString:@"iPad2,6"])      return @"iPad Mini";
    if ([modeID isEqualToString:@"iPad2,7"])      return @"iPad Mini";
    if ([modeID isEqualToString:@"iPad3,1"])      return @"iPad 3";
    if ([modeID isEqualToString:@"iPad3,2"])      return @"iPad 3";
    if ([modeID isEqualToString:@"iPad3,3"])      return @"iPad 3";
    if ([modeID isEqualToString:@"iPad3,4"])      return @"iPad 4";
    if ([modeID isEqualToString:@"iPad3,5"])      return @"iPad 4";
    if ([modeID isEqualToString:@"iPad3,6"])      return @"iPad 4";
    if ([modeID isEqualToString:@"iPad4,1"])      return @"iPad Air";
    if ([modeID isEqualToString:@"iPad4,2"])      return @"iPad Air";
    if ([modeID isEqualToString:@"iPad4,3"])      return @"iPad Air";
    if ([modeID isEqualToString:@"iPad4,4"])      return @"iPad Mini Retina";
    if ([modeID isEqualToString:@"iPad4,5"])      return @"iPad Mini_Retina";
    if ([modeID isEqualToString:@"iPad4,7"])      return @"iPad Mini 3";
    if ([modeID isEqualToString:@"iPad4,8"])      return @"iPad Mini 3";
    if ([modeID isEqualToString:@"iPad4,9"])      return @"iPad Mini 3";
    if ([modeID isEqualToString:@"iPad5,1"])      return @"iPad Mini 4";
    if ([modeID isEqualToString:@"iPad5,2"])      return @"iPad Mini 4";
    if ([modeID isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([modeID isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    if ([modeID isEqualToString:@"iPad6,3"])      return @"iPad Pro 9.7-inch";
    if ([modeID isEqualToString:@"iPad6,4"])      return @"iPad Pro 9.7-inch";
    if ([modeID isEqualToString:@"iPad6,7"])      return @"iPad Pro 12.9-inch";
    if ([modeID isEqualToString:@"iPad6,8"])      return @"iPad Pro 12.9-inch";
    
    if ([modeID isEqualToString:@"AppleTV1,1"])   return @"Apple_TV_1G";
    if ([modeID isEqualToString:@"AppleTV2,1"])   return @"Apple_TV_2G";
    if ([modeID isEqualToString:@"AppleTV3,1"])   return @"Apple_TV_3G";
    if ([modeID isEqualToString:@"AppleTV3,2"])   return @"Apple_TV_4G";
    if ([modeID isEqualToString:@"AppleTV5,3"])   return @"Apple_TV_5G";
    
    if ([modeID isEqualToString:@"Watch1,1"])     return @"Apple_Watch_38";
    if ([modeID isEqualToString:@"Watch1,2"])     return @"Apple_Watch_42";
    if ([modeID isEqualToString:@"Watch2,3"])     return @"Apple_Watch_Series_2_38";
    if ([modeID isEqualToString:@"Watch2,4"])     return @"Apple_Watch_Series_2_42";
    if ([modeID isEqualToString:@"Watch2,6"])     return @"Apple_Watch_Series_1_38";
    if ([modeID isEqualToString:@"Watch2,7"])     return @"Apple_Watch_Series_1_42";
    
    if ([modeID isEqualToString:@"i386"])         return @"Simulator";
    if ([modeID isEqualToString:@"x86_64"])       return @"Simulator";
    if ([modeID hasPrefix:@"iPhone"])             return @"iPhone";
    if ([modeID hasPrefix:@"iPod"])               return @"iPod";
    if ([modeID hasPrefix:@"iPad"])               return @"iPad";
    
    // log message that your device is not present in the list
    [self logMessage:modeID];
    
    return @"hardware";
}

- (void)logMessage:(NSString *)modeID {
    NSLog(@"This is a device which_is not listed_in this category. Please visit https://github.com/InderKumarRathore/UIDeviceUtil and_add_a comment there.");
    NSLog(@"Your device hardware string is: %@", modeID);
}

- (BOOL)is_iPhone_X {
#if TARGET_IPHONE_SIMULATOR //模拟器
    if ([[UIScreen mainScreen] bounds].size.height == 812.f) {
        return YES;
    }
    return NO;
#elif TARGET_OS_IPHONE //真机
    if ([self hardware] == IPHONE_X) {
        return YES;
    }
    return NO;
#endif
}

@end
