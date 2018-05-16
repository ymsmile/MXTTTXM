//
//  UILabel+Copy.m
//  KeepHome
//
//  Created by Michael on 2017/5/19.
//  Copyright © 2017年 Tianlin Inc. All rights reserved.
//

#import "UILabel+Copy.h"

#import <objc/runtime.h>

@implementation UILabel (Copy)

- (BOOL)canBecomeFirstResponder {
    BOOL isCopy = [objc_getAssociatedObject(self, @selector(isCopyable)) boolValue];
    return isCopy;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    return (action == @selector(copyTextEvent:));
}

- (void)setIsCopyable:(BOOL)isCopy {
    objc_setAssociatedObject(self, @selector(isCopyable), [NSNumber numberWithBool:isCopy], OBJC_ASSOCIATION_ASSIGN);
    [self addLongPressGesture];
}

- (BOOL)isCopyable {
    return [objc_getAssociatedObject(self, @selector(isCopyable)) boolValue];
}

- (void)addLongPressGesture {
    BOOL isCopy = [objc_getAssociatedObject(self, @selector(isCopyable)) boolValue];
    if (isCopy) {
        self.userInteractionEnabled = YES;
        
        UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressEvent:)];
        [self addGestureRecognizer:gesture];
    }
}

- (void)handleLongPressEvent:(UIGestureRecognizer *)gesture {
    if ([UIMenuController sharedMenuController].isMenuVisible) {
        return;
    }
    
    [self becomeFirstResponder];
    
    UIMenuItem *item = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(copyTextEvent:)];
    [[UIMenuController sharedMenuController] setMenuItems:[NSArray arrayWithObject:item]];
    [[UIMenuController sharedMenuController] setTargetRect:self.frame inView:self.superview];
    [[UIMenuController sharedMenuController] setMenuVisible:YES animated:YES];
}

- (void)copyTextEvent:(id)sender {
    UIPasteboard *pBoard = [UIPasteboard generalPasteboard];

    if (self.text) {
        [pBoard setString:self.text];
    }
    else if (self.attributedText.string) {
        [pBoard setString:self.attributedText.string];
    }
    else {
        
    }
}

@end
