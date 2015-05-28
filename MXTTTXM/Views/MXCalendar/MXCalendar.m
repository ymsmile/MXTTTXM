//
//  MXCalendar.m
//  MXTTTXM
//
//  Created by Michael on 5/28/15.
//  Copyright (c) 2015 MXTTTXM UPUPUP. All rights reserved.
//

#import "MXCalendar.h"
#import "MXDayItem.h"

@interface MXCalendar ()

@property (nonatomic, strong) NSCalendar *calendar;
@property (nonatomic, strong) NSDate *firstDateOfMonth; // 某月的第一天的日期
@property (nonatomic, assign) int bufferDaysBeginning;
@property (nonatomic, assign) int weeksOfMonth; // 某月有多少周
@property (nonatomic, assign) int daysOfMonth; // 某月有多少天

@property (nonatomic, strong) UIButton  *nextMonthBtn;
@property (nonatomic, strong) UIButton  *prevMontehBtn;
@property (nonatomic, strong) UILabel   *monthLabel;
@property (nonatomic, strong) UIView    *calendarView;
@property (nonatomic, strong) UIView    *weekView;

@end

@implementation MXCalendar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        
        // month label
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 30)];
        label.textAlignment = NSTextAlignmentCenter;
        self.monthLabel = label;
        [self addSubview:self.monthLabel];
        
        // previous year button
        UIButton *prevYearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        prevYearBtn.frame = CGRectMake(0, 0, 40, 40);
        [prevYearBtn setImage:[UIImage imageNamed:@"btn_previous_2"] forState:UIControlStateNormal];
        [prevYearBtn setImageEdgeInsets:UIEdgeInsetsMake(5, 20, 5, 0)];
        [prevYearBtn addTarget:self action:@selector(prevYearEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:prevYearBtn];
        // previous month button
        UIButton *prevMonthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        prevMonthBtn.frame = CGRectMake(40, 0, 40, 40);
        [prevMonthBtn setImage:[UIImage imageNamed:@"btn_previous_1"] forState:UIControlStateNormal];
        [prevMonthBtn setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 10)];
        [prevMonthBtn addTarget:self action:@selector(prevMonthEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:prevMonthBtn];
        // next month button
        UIButton *nextMonthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        nextMonthBtn.frame = CGRectMake(frame.size.width-80, 0, 40, 40);
        [nextMonthBtn setImage:[UIImage imageNamed:@"btn_next_1"] forState:UIControlStateNormal];
        [nextMonthBtn setImageEdgeInsets:UIEdgeInsetsMake(5, 10, 5, 5)];
        [nextMonthBtn addTarget:self action:@selector(nextMonthEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:nextMonthBtn];
        // next year button
        UIButton *nextYearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        nextYearBtn.frame = CGRectMake(frame.size.width-40, 0, 40, 40);
        [nextYearBtn setImage:[UIImage imageNamed:@"btn_next_2"] forState:UIControlStateNormal];
        [nextYearBtn setImageEdgeInsets:UIEdgeInsetsMake(5, 0, 5, 20)];
        [nextYearBtn addTarget:self action:@selector(nextYearEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:nextYearBtn];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 30, frame.size.width, 20)];
//        view.layer.borderWidth = 1.f;
//        view.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.weekView = view;
        [self addSubview:self.weekView];
        
        NSArray *arr = @[@"周一", @"周二", @"周三", @"周四", @"周五", @"周六", @"周日"];
        CGFloat width = frame.size.width / 7;
        for (int i = 0; i <  7; i++) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i*width, 0, width, 20)];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:12];
            label.text = arr[i];
            if (i < 5)
                label.textColor = [UIColor blackColor];
            else
                label.textColor = [UIColor redColor];
            [self.weekView addSubview:label];
        }
        
        UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 49, frame.size.width, frame.size.height-49)];
        view2.backgroundColor = [UIColor purpleColor];
//        view2.layer.borderWidth = 1.f;
//        view2.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.calendarView = view2;
        [self addSubview:self.calendarView];
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [self redrawCalendar];
}

- (void)nextYearEvent:(UIButton *)sender {
    [self setDate:1 isMonth:NO];
    [self redrawCalendar];
}

- (void)prevYearEvent:(UIButton *)sender {
    [self setDate:-1 isMonth:NO];
    [self redrawCalendar];
}

- (void)nextMonthEvent:(UIButton *)sender {
    [self setDate:1 isMonth:YES];
    [self redrawCalendar];
}

- (void)prevMonthEvent:(UIButton *)sender {
    [self setDate:-1 isMonth:YES];
    [self redrawCalendar];
}

- (void)setDate:(int)value isMonth:(BOOL)flag {
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    if (flag) {
        [offsetComponents setMonth:value];
    } else {
        [offsetComponents setYear:value];
    }
    NSDate *month = [self.calendar dateByAddingComponents:offsetComponents toDate:self.firstDateOfMonth options:0];
    [self setSomeInfo:month];
}

- (void)setSomeInfo:(NSDate *)date {
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [currentCalendar components:NSYearCalendarUnit|NSMonthCalendarUnit fromDate:date];
    int year = (int)[comps year];
    int month = (int)[comps month];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM"];
    NSString *str = [NSString stringWithFormat:@"%d-%@%d", year, (month < 10 ? @"0" : @""), month];
    self.firstDateOfMonth = [dateFormatter dateFromString:str];
    
    NSDateComponents *compssss = [self.calendar components:NSWeekdayCalendarUnit | NSDayCalendarUnit fromDate:self.firstDateOfMonth];
    [currentCalendar setFirstWeekday:2];
    NSRange days = [currentCalendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:self.firstDateOfMonth];
    int bufferDaysBeginning = (int)([compssss weekday]-[currentCalendar firstWeekday]);
    if (bufferDaysBeginning < 0)
        bufferDaysBeginning += 7;
    int daysInMonthWithBuffer = (int)(days.length + bufferDaysBeginning);
    int numberOfWeeks = daysInMonthWithBuffer / 7;
    if (daysInMonthWithBuffer % 7) {
        numberOfWeeks++;
    }
    
    self.weeksOfMonth = numberOfWeeks;
    self.bufferDaysBeginning = bufferDaysBeginning;
    self.daysOfMonth = (int)days.length;
}

- (void)redrawCalendar {
    if (!self.firstDateOfMonth)
        [self setSomeInfo:[NSDate date]];
    // 清除之前的所有视图
    for(UIView * view in self.calendarView.subviews) {
        [view removeFromSuperview];
    }
    [self redrawDays];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM"];
    self.monthLabel.text = [formatter stringFromDate:self.firstDateOfMonth];
}

- (void)redrawDays {
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setDay:-self.bufferDaysBeginning];
    NSDate *date = [self.calendar dateByAddingComponents:offsetComponents toDate:self.firstDateOfMonth options:0];
    [offsetComponents setDay:1];
    
    CGFloat width = self.calendarView.frame.size.width;
    CGFloat height = self.calendarView.frame.size.height;
    CGFloat itemWidth = width / 7.0;
    CGFloat itemHeigth = height / self.weeksOfMonth;
    int days = self.weeksOfMonth * 7;
    int x1 = (width - itemWidth * 7) / 2;
    int x = x1;
    int y = (height - itemHeigth * self.weeksOfMonth) / 2;
    for (int i = 0; i < days; i++) {
        if(i && !(i%7)) {
            x = x1;
            y += itemHeigth;
        }
        
        NSDateComponents *comps = [self.calendar components:NSDayCalendarUnit fromDate:date];
        
        MXDayItem *dayItem = [[MXDayItem alloc] initWithFrame:CGRectMake(x, y, itemWidth, itemHeigth)];
        dayItem.date = [date dateByAddingTimeInterval:0];
        dayItem.showLunar = self.showLunar;
        [dayItem setSelected:[self dateInCurrentMonth:date]];
        [dayItem.dayLabel setText:[NSString stringWithFormat:@"%ld",(long)[comps day]]];
        [self.calendarView addSubview:dayItem];
        
        date = [_calendar dateByAddingComponents:offsetComponents toDate:date options:0];
        x += itemWidth;
    }
}

#pragma mark - 

/** 判断某个日期是否在当前月份 */
- (BOOL)dateInCurrentMonth:(NSDate *)date{
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents *comp1 = [self.calendar components:unitFlags fromDate:self.firstDateOfMonth];
    NSDateComponents *comp2 = [self.calendar components:unitFlags fromDate:date];
    return [comp1 year]  == [comp2 year] && [comp1 month] == [comp2 month];
}

/** 判断是否是闰年 */
- (BOOL)isLeapYear:(NSInteger)year {
    if ((year % 4 && year % 400 != 0) || year % 400 == 0) {
        return YES;
    }
    return NO;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
