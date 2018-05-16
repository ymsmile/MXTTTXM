//
//  UIDevice+Hardware.m
//  EnjoyHomePlus
//
//  Created by Michael on 2017/09/30.
//  Copyright © 2017年 Tianlin Inc. All rights reserved.
//
//  https://github.com/InderKumarRathore/DeviceUtil

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, Hardware) {
    NOT_AVAILABLE,
    
    IPHONE_2G,
    IPHONE_3G,
    IPHONE_3GS,
    IPHONE_4,
    IPHONE_4_CDMA,
    IPHONE_4S,
    IPHONE_5,
    IPHONE_5_CDMA_GSM,
    IPHONE_5C,
    IPHONE_5C_CDMA_GSM,
    IPHONE_5S,
    IPHONE_5S_CDMA_GSM,
    IPHONE_6,
    IPHONE_6_PLUS,
    IPHONE_6S,
    IPHONE_6S_PLUS,
    IPHONE_SE,
    IPHONE_7,
    IPHONE_7_PLUS,
    IPHONE_8,
    IPHONE_8_PLUS,
    IPHONE_X,
    
    IPOD_TOUCH_1G,
    IPOD_TOUCH_2G,
    IPOD_TOUCH_3G,
    IPOD_TOUCH_4G,
    IPOD_TOUCH_5G,
    IPOD_TOUCH_6G,
    
    IPAD,
    IPAD_2,
    IPAD_2_WIFI,
    IPAD_2_CDMA,
    IPAD_3,
    IPAD_3G,
    IPAD_3_WIFI,
    IPAD_3_WIFI_CDMA,
    IPAD_4,
    IPAD_4_WIFI,
    IPAD_4_GSM_CDMA,
    IPAD_5_WIFI,
    IPAD_5_WIFI_CELLULAR,
    IPAD_MINI,
    IPAD_MINI_WIFI,
    IPAD_MINI_WIFI_CDMA,
    IPAD_MINI_RETINA_WIFI,
    IPAD_MINI_RETINA_WIFI_CDMA,
    IPAD_MINI_RETINA_WIFI_CELLULAR_CN,
    IPAD_MINI_3_WIFI,
    IPAD_MINI_3_WIFI_CELLULAR,
    IPAD_MINI_3_WIFI_CELLULAR_CN,
    IPAD_MINI_4_WIFI,
    IPAD_MINI_4_WIFI_CELLULAR,
    IPAD_AIR_WIFI,
    IPAD_AIR_WIFI_GSM,
    IPAD_AIR_WIFI_CDMA,
    IPAD_AIR_2_WIFI,
    IPAD_AIR_2_WIFI_CELLULAR,
    IPAD_PRO_97_WIFI,
    IPAD_PRO_97_WIFI_CELLULAR,
    IPAD_PRO_WIFI,
    IPAD_PRO_WIFI_CELLULAR,
    IPAD_PRO_2G_WIFI,
    IPAD_PRO_2G_WIFI_CELLULAR,
    IPAD_PRO_105_WIFI,
    IPAD_PRO_105_WIFI_CELLULAR,
    
    APPLE_TV_1G,
    APPLE_TV_2G,
    APPLE_TV_3G,
    APPLE_TV_3_2G,
    APPLE_TV_4G,
    
    APPLE_WATCH_38,
    APPLE_WATCH_42,
    APPLE_WATCH_SERIES_2_38,
    APPLE_WATCH_SERIES_2_42,
    APPLE_WATCH_SERIES_1_38,
    APPLE_WATCH_SERIES_1_42,
    
    SIMULATOR
};

@interface UIDevice (Hardware)

/** 型号，如iPhone9,1 */
- (NSString *)hardwareModeID;

/** This method returns the Hardware enum depending upon harware string */
- (Hardware)hardware;

/** 机型，如iPhone 6 */
- (NSString *)hardwareTypeString;

/** 是否是 iPhone X 设备 */
- (BOOL)is_iPhone_X;

@end
