//
//  UIView+MXAddtion.h
//  MXTTTXM
//
//  Created by Michael on 5/28/15.
//  Copyright (c) 2015 MXTTTXM UPUPUP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (MXAddtion)

/** View的X坐标 */
@property (nonatomic, assign) CGFloat   x;

/** View的Y坐标 */
@property (nonatomic, assign) CGFloat   y;

/** View的width */
@property (nonatomic, assign) CGFloat   width;

/** View的height */
@property (nonatomic, assign) CGFloat   height;

/** View's origin - Sets X and Y Positions */
@property (nonatomic, assign) CGPoint   origin;

/** View's size - Sets Width and Height */
@property (nonatomic, assign) CGSize    size;

/** view的最底部的Y坐标 **/
@property (nonatomic, assign) CGFloat   bottom;

/** view的最右边的X坐标 **/
@property (nonatomic, assign) CGFloat   right;

/** view的中点的X坐标 **/
@property (nonatomic, assign) CGFloat   centerX;

/** view的中点的Y坐标 **/
@property (nonatomic, assign) CGFloat   centerY;

/** Returns the Subview with the heighest X value **/
@property (nonatomic, strong, readonly) UIView *lastSubviewOnX;

/** Returns the Subview with the heighest Y value **/
@property (nonatomic, strong, readonly) UIView *lastSubviewOnY;

/**
 Centers the view to its parent view (if exists)
 */
//- (void) centerToParent;

@end
