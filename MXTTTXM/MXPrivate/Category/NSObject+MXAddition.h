//
//  NSObject+MXAddition.h
//  MXTTTXM
//
//  Created by Michael on 6/4/15.
//  Copyright (c) 2015 MXTTTXM UPUPUP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (MXAddition)

+ (BOOL)mx_swizzleMethod:(SEL)origSel withMethod:(SEL)altSel;
+ (BOOL)mx_swizzleClassMethod:(SEL)origSel withMethod:(SEL)altSel;

/**
 *  判断一个对象是否是空的；支持判断数组和字典为空
 *
 *  @return YES：数组、字典等为空
 */
- (BOOL)isEmptyObject;

@end