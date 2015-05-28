//
//  MXPromptHUD.h
//  MXTTTXM
//
//  Created by Michael on 9/1/15.
//  Copyright (c) 2015 MXTTTXM UPUPUP. All rights reserved.
//

#import "MXPromptHUD.h"

#define kHUDFontSize                18
#define kPPScreenWidth              [UIScreen mainScreen].bounds.size.width
#define kPPScreenHeight             [UIScreen mainScreen].bounds.size.height

@implementation MXPromptHUD

//static void addRoundedRectToPath(CGContextRef context, CGRect rect,
//                                 float ovalWidth,float ovalHeight)
//{
//    float fw, fh;
//    if (ovalWidth == 0 || ovalHeight == 0) { 
//        CGContextAddRect(context, rect);
//        return;
//    }
//    
//    CGContextSaveGState(context); 
//    CGContextTranslateCTM (context, CGRectGetMinX(rect), 
//                           CGRectGetMinY(rect));
//    CGContextScaleCTM (context, ovalWidth, ovalHeight); 
//    fw = CGRectGetWidth (rect) / ovalWidth; 
//    fh = CGRectGetHeight (rect) / ovalHeight; 
//    CGContextMoveToPoint(context, fw, fh/2); 
//    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1); 
//    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1); 
//    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1); 
//    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1); 
//    CGContextClosePath(context); 
//    CGContextRestoreGState(context); 
//}

+ (void)showInView:(UIView *)view info:(NSString *)str isCenter:(BOOL)flag {
    [self showInView:view info:str isCenter:flag backgroundColor:[UIColor blackColor] textColor:[UIColor whiteColor]];
}

+ (void)showInView:(UIView *)view info:(NSString *)str isCenter:(BOOL)flag backgroundColor:(UIColor *)bgColor textColor:(UIColor *)txtColor {
    if (str == nil)
        return;
    CGSize size = [str boundingRectWithSize:CGSizeMake(kPPScreenWidth-30*2, kPPScreenHeight/2)
                                    options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading
                                 attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:kHUDFontSize]}
                                    context:nil].size;
    CGRect frame = CGRectMake(0, 0, size.width, size.height);
    MXPromptHUD *alert = [[MXPromptHUD alloc] initWithFrame:frame info:str backgroundColor:bgColor textColor:txtColor];
    alert.center = CGPointMake(view.center.x, flag == YES ? (view.center.y+40) : view.frame.size.height - 80);
    alert.alpha = 0;
    [view addSubview:alert];
    [view bringSubviewToFront:alert];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.3f];
    alert.alpha = 1.0;
    [UIView commitAnimations];
    
    [alert performSelector:@selector(fadeAway) withObject:nil afterDelay:5];
}

- (id)initWithFrame:(CGRect)frame info:(NSString*)info {
    return [self initWithFrame:frame info:info backgroundColor:[UIColor blackColor] textColor:[UIColor whiteColor]];
}

- (id)initWithFrame:(CGRect)frame info:(NSString*)info backgroundColor:(UIColor *)bgColor textColor:(UIColor *)txtColor {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = bgColor;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 8.f;
        
        //
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, frame.size.width-20, frame.size.height-20)];
        label.numberOfLines = 0;
        label.textColor = txtColor;
        label.font = [UIFont systemFontOfSize:kHUDFontSize];
        label.text = info;
        [self addSubview:label];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetAlpha(context, .8);
//    addRoundedRectToPath(context, rect, 4.0f, 4.0f);
//    CGContextSetFillColorWithColor(context, bgColor_.CGColor);
//    CGContextFillPath(context);
//    CGContextSetAlpha(context, 1.0);
//    float x = (rect.size.width - fontSize_.width) / 2.0;
//    float y = (rect.size.height - fontSize_.height) / 2.0;
//    CGRect r = CGRectMake(x, y, fontSize_.width, fontSize_.height);
//    [info_ drawInRect:r withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:kHUDFontSize],
//                                         NSForegroundColorAttributeName:textColor_}];
}

- (void)remove {
    [self removeFromSuperview];
}

- (void)fadeAway {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.5f];
    self.alpha = 0.0;
    [UIView commitAnimations];
    [self performSelector:@selector(remove) withObject:nil afterDelay:1.5f];
}

@end
