//
//  MXDayItem.h
//  MXTTTXM
//
//  Created by Michael on 5/28/15.
//  Copyright (c) 2015 MXTTTXM UPUPUP. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MXDayItem;

@protocol MXDayItemDelegate <NSObject>

- (void)dayItemDidTapped:(MXDayItem *)dayItem;

@end

@interface MXDayItem : UIView

@property (nonatomic, strong) UIColor   *selectedBgColor;     // 选中的背景色
@property (nonatomic, strong) UIColor   *todayColor;          // 当天的颜色
@property (nonatomic, strong) UIButton  *dateButton;
@property (nonatomic, strong) UILabel   *dayLabel;            // 显示日期
@property (nonatomic, strong) UILabel   *lunarLabel;          // 显示农历或节日
@property (nonatomic, strong) NSDate    *date;
@property (nonatomic, assign) BOOL      showLunar;  // 是否需要显示阴历，默认为NO

@property (nonatomic, weak)  id<MXDayItemDelegate>delegate;

- (void)setSelected:(BOOL)selected;

@end
