//
//  MXActionSheet.h
//  MXTTTXM
//
//  Created by Michael on 5/28/15.
//  Copyright (c) 2015 MXTTTXM UPUPUP. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MXActionSheet;

@protocol MXActionSheetDelegate <NSObject>

- (void)actionSheet:(MXActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;

@optional
- (void)actionSheetCancel:(MXActionSheet *)actionSheet;

@end

@interface MXActionSheet : UIView

@property (weak, nonatomic) id<MXActionSheetDelegate> delegate;

- (in)initWithTitle:(NSString *)title
           delegate:(id<MXActionSheetDelegate>)delegate
  cancelButtonTitle:(NSString *)cancelButtonTitle
  otherButtonTitles:(NSArray *)titles;

- (void)showInView:(UIView *)mSuperView;

@end
