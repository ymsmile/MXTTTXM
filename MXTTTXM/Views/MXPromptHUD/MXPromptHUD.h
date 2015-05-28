//
//  MXPromptHUD.h
//  MXTTTXM
//
//  Created by Michael on 9/1/15.
//  Copyright (c) 2015 MXTTTXM UPUPUP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MXPromptHUD : UIView {
    UIColor *textColor_;
    UIColor *bgColor_;
    NSString *info_;
    CGSize fontSize_;
}
/**
 *  显示提示信息
 *
 *  @param view 父视图
 *  @param str  提示文字
 *  @param flag 是否居中
 */
+ (void)showInView:(UIView *)view info:(NSString *)str isCenter:(BOOL)flag;
+ (void)showInView:(UIView *)view info:(NSString *)str isCenter:(BOOL)flag backgroundColor:(UIColor *)bgColor textColor:(UIColor *)txtColor;

@end
