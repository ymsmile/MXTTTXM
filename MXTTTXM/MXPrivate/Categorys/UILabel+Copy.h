//
//  UILabel+Copy.h
//  KeepHome
//
//  Created by Michael on 2017/5/19.
//  Copyright © 2017年 Tianlin Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Copy)

/** 
 * 是否支持长按复制功能（复制整个UILabel的内容，暂时不支持选择指定区域复制）。默认不支持，不支持复制则不需要设置此属性的值
 */
@property (nonatomic, assign) BOOL isCopyable;

@end
