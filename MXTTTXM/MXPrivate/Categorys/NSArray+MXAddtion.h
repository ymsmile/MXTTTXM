//
//  NSArray+MXAddtion.h
//  MXTTTXM
//
//  Created by Michael on 5/28/15.
//  Copyright (c) 2015 MXTTTXM UPUPUP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (MXAddtion)

/**
 *  判断数组是否为空；count为空，或者不是NSArray类型
 *
 *  @return YES/NO
 */
- (BOOL)isEmpty;

/**
 *  判断两个数组的内容是否相同，不分顺序；如果数组里存放的是自定义的对象，那该对象需要重写isEqual:和hash方法
 *
 *  @param array 被比较的对象
 *
 *  @return YES/NO
 */
- (BOOL)hasSameContents:(NSArray *)array;

@end
