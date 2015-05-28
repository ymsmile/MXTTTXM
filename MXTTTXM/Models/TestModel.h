//
//  TestModel.h
//  MXTTTXM
//
//  Created by Michael on 5/28/15.
//  Copyright (c) 2015 MXTTTXM UPUPUP. All rights reserved.
//

// 此Model专为验证NSArray类别下hasSameContents方法

#import <Foundation/Foundation.h>

@interface TestModel : NSObject

/** 设备ID */
@property (nonatomic, strong) NSString  *speakerID;

/** 设备名 */
@property (nonatomic, strong) NSString  *speakerName;

/** 设备的声道 */
@property (nonatomic, strong) NSString  *speakerChannel;


// 以下两属性没很大用处，主要用来判断两对象是否相同

/** 所在的组的ID */
@property (nonatomic, strong) NSString  *belongGroupID;
/** 所在的组的IP */
@property (nonatomic, strong) NSString  *belongGroupIP;

@end
