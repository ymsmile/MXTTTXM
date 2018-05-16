//
//  CALayer+MXAddition.m
//  Security
//
//  Created by Michael on 6/18/15.
//  Copyright (c) 2015 MXTTTXM UPUPUP. All rights reserved.
//

#import "CALayer+MXAddition.h"

@implementation CALayer (MXAddition)

- (void)setBorderIBColor:(UIColor *)color {
    self.borderColor = color.CGColor;
}

- (UIColor *)borderIBColor {
    return [UIColor colorWithCGColor:self.borderColor];
}

- (void)setShadowIBColor:(UIColor *)color {
    self.shadowColor = color.CGColor;
}

- (UIColor *)shadowIBColor{
    return [UIColor colorWithCGColor:self.shadowColor];
}

@end
