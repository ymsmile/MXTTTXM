//
//  UIImage+MXAddition.h
//  MXTTTXM
//
//  Created by Michael on 5/28/15.
//  Copyright (c) 2015 MXTTTXM UPUPUP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (MXAddition)

/**
 *  使用颜色生成一张图片
 *
 *  @param color 颜色值
 *
 *  @return 生成的图片
 */
+ (UIImage *)imageWithhColor:(UIColor *)color;

- (UIImage *)roundedCornerImageWithCornerRadius:(CGFloat)cornerRadius;

- (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize;

- (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur;

@end
