//
//  MXDayItem.m
//  MXTTTXM
//
//  Created by Michael on 5/28/15.
//  Copyright (c) 2015 MXTTTXM UPUPUP. All rights reserved.
//

#import "MXDayItem.h"

#define kMXDayItemLunarLabelHeight  11.f
#define kMXDayItemDayLabelHeight    17.f
#define kMXDayItemLunarFont         [UIFont systemFontOfSize:kMXDayItemLunarLabelHeight]
#define kMXDayItemDateFont          [UIFont systemFontOfSize:kMXDayItemDayLabelHeight]
#define RGB(r, g, b)                [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]

int months[12] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12};

int days[30] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18,
    19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30};

char *chineseYears[60] = {"甲子",   "乙丑",  "丙寅",  "丁卯",  "戊辰",  "己巳",  "庚午",  "辛未",  "壬申",  "癸酉",
    "甲戌",   "乙亥",  "丙子",  "丁丑",  "戊寅",  "己卯",  "庚辰",  "辛己",  "壬午",  "癸未",
    "甲申",   "乙酉",  "丙戌",  "丁亥",  "戊子",  "己丑",  "庚寅",  "辛卯",  "壬辰",  "癸巳",
    "甲午",   "乙未",  "丙申",  "丁酉",  "戊戌",  "己亥",  "庚子",  "辛丑",  "壬寅",  "癸丑",
    "甲辰",   "乙巳",  "丙午",  "丁未",  "戊申",  "己酉",  "庚戌",  "辛亥",  "壬子",  "癸丑",
    "甲寅",   "乙卯",  "丙辰",  "丁巳",  "戊午",  "己未",  "庚申",  "辛酉",  "壬戌",  "癸亥"};

char *chineseMonths[12] = {"正月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "冬月", "腊月"};

char *chineseDays[30] = {"初一", "初二", "初三", "初四", "初五", "初六", "初七", "初八", "初九", "初十",
    "十一", "十二", "十三", "十四", "十五", "十六", "十七", "十八", "十九", "二十",
    "廿一", "廿二", "廿三", "廿四", "廿五", "廿六", "廿七", "廿八", "廿九", "三十"};

@interface MXDayItem ()

@property (nonatomic, assign) BOOL isCurrentMonth;

@end

@implementation MXDayItem

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.selectedBgColor = [UIColor orangeColor];
        self.todayColor = [UIColor whiteColor];
        
        self.layer.borderWidth = 0.5f;
        self.layer.borderColor = [UIColor blackColor].CGColor;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height-kMXDayItemDayLabelHeight, frame.size.width, kMXDayItemDayLabelHeight)];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = kMXDayItemDateFont;
        label.textColor = [UIColor blackColor];
        label.center = CGPointMake(frame.size.width/2, frame.size.height/2);
        self.dayLabel = label;
        [self addSubview:self.dayLabel];
        
        // button
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        button.backgroundColor = [UIColor clearColor];
        [button addTarget:self action:@selector(dayItemSelectedEvent:) forControlEvents:UIControlEventTouchUpInside];
//        [button addTarget:self action:@selector(TouchUpOutside) forControlEvents:UIControlEventTouchUpOutside];
//        [button addTarget:self action:@selector(TouchDown) forControlEvents:UIControlEventTouchDown];
        self.dateButton = button;
        [self addSubview:self.dateButton];
        
    }
    return self;
}

- (void)TouchUpOutside {
    self.layer.borderWidth = 0;
    self.layer.borderColor = [UIColor clearColor].CGColor;
}

- (void)TouchDown {
    self.layer.borderWidth = 1.f;
    self.layer.borderColor = [UIColor greenColor].CGColor;
}

- (void)dayItemSelectedEvent:(UIButton *)sender {
    self.layer.borderWidth = 0;
    self.layer.borderColor = [UIColor clearColor].CGColor;
    if (self.delegate && [self.delegate respondsToSelector:@selector(dayItemDidTapped:)]) {
        [self.delegate dayItemDidTapped:self];
    }
}

- (void)setShowLunar:(BOOL)showLunar {
    _showLunar = showLunar;
    
    if (showLunar) {
        self.dayLabel.center = CGPointMake(self.dayLabel.center.x, self.dayLabel.center.y-(kMXDayItemDayLabelHeight/2));
        // lunar label
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, self.dayLabel.frame.origin.y+self.dayLabel.frame.size.height, self.dayLabel.frame.size.width, kMXDayItemLunarLabelHeight)];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = kMXDayItemLunarFont;
        label.text = [self getLunarWithDate:self.date];
        self.lunarLabel = label;
        [self addSubview:self.lunarLabel];
    }
}

- (void)setSelected:(BOOL)selected {
    _isCurrentMonth = selected;
    if(selected) {
        self.dayLabel.textColor = [UIColor blackColor];
        self.lunarLabel.textColor = RGB(123, 123, 123);
        
        // 判断是否是周末
        if ([self isWeekend:self.date]) {
            // 此日期是当前月的某天才会变红色
            if (selected)
                self.dayLabel.textColor = [UIColor redColor];
        }
        
        // 判断是否是今天
        if (self.todayColor && [self isToday:self.date]) {
            [self setBackgroundColor:self.selectedBgColor];
            self.dayLabel.textColor = self.lunarLabel.textColor = self.todayColor;
        }
        
        // 判断节假日、节气...
        NSString *holiday = [self getHolidayWithDate:self.date];
        if (holiday.length > 0) {
            self.lunarLabel.textColor = [UIColor redColor];
            self.lunarLabel.text = holiday;
        }
        
    } else {
        self.dateButton.enabled = NO;
        self.dayLabel.textColor = self.lunarLabel.textColor = RGB(200, 200, 200);
        
        NSString *holiday = [self getHolidayWithDate:self.date];
        if (holiday.length > 0) {
            self.lunarLabel.text = holiday;
        }
    }
}

- (BOOL)isToday:(NSDate *)date {
    NSDateComponents *otherDay = [[NSCalendar currentCalendar] components:NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date];
    NSDateComponents *today = [[NSCalendar currentCalendar] components:NSEraCalendarUnit|NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:[NSDate date]];
    return ([today day] == [otherDay day] &&
            [today month] == [otherDay month] &&
            [today year] == [otherDay year] &&
            [today era] == [otherDay era]);
}

- (BOOL)isWeekend:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components:(NSWeekCalendarUnit | NSWeekdayCalendarUnit |NSWeekdayOrdinalCalendarUnit) fromDate:date];
    NSInteger week = [comps weekday];
    if (week == 1 || week == 7)
        return YES;
    else
        return NO;
}

- (NSString*)getLunarWithDate:(NSDate *)date{
    
    NSCalendar *localeCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSChineseCalendar];
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents *localeComp = [localeCalendar components:unitFlags fromDate:date];
    
//    NSString *month = [NSString stringWithCString:chineseMonths[localeComp.month-1] encoding:NSUTF8StringEncoding];
    NSString *day = [NSString stringWithCString:chineseDays[localeComp.day-1] encoding:NSUTF8StringEncoding];
    
    NSString *lunarDate = [NSString stringWithFormat:@"%@", day];
    
    return lunarDate;
}

- (NSString *)getHolidayWithDate:(NSDate *)date {
    NSString *holiday = @"";
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [currentCalendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date];
    int month = (int)[comps month];
    int day = (int)[comps day];
    
    NSCalendar *lunarCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSChineseCalendar];
    NSRange range = [lunarCalendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents *lunarComp = [lunarCalendar components:unitFlags fromDate:date];
    int lunarMonth = months[lunarComp.month-1];
    int lunarDay = days[lunarComp.day-1];
    
    if (month == 1 && day == 1) {
        holiday = @"元旦节";
    } else if (month == 2 && day == 14) {
        holiday = @"情人节";
    } else if (month == 3 && day == 8) {
        holiday = @"妇女节";
    } else if (month == 5 && day == 1) {
        holiday = @"劳动节";
    } else if (month == 6 && day == 1) {
        holiday = @"儿童节";
    } else if (month == 8 && day == 1) {
        holiday = @"建军节";
    } else if (month == 9 && day == 10) {
        holiday = @"教师节";
    } else if (month == 10 && day == 1) {
        holiday = @"国庆节";
    } else if (month == 11 && day == 11) {
        holiday = @"光棍节";
    } else if (month == 12 && day == 24) {
        holiday = @"平安夜";
    } else if (month == 12 && day == 25) {
        holiday = @"圣诞节";
    }
    
    else if (lunarMonth == 12 && lunarComp.day == range.length) {   // 除夕是农历12月的最后一天，有可能是29、30
        holiday = @"除夕";
    } else if (lunarMonth == 1 && lunarDay == 1) {
        holiday = @"春节";
    } else if (lunarMonth == 1 && lunarDay == 15) {
        holiday = @"元宵节";
    } else if (lunarMonth == 4 && lunarDay == 5) {
        holiday = @"清明节";
    } else if (lunarMonth == 5 && lunarDay == 5) {
        holiday = @"端午节";
    }  else if (lunarMonth == 7 && lunarDay == 7) {
        holiday = @"七夕";
    } else if (lunarMonth == 7 && lunarDay == 15) {
        holiday = @"鬼节";
    } else if (lunarMonth == 8 && lunarDay == 15) {
        holiday = @"中秋节";
    } else if (lunarMonth == 9 && lunarDay == 9) {
        holiday = @"重阳节";
    }  else if (lunarMonth == 9 && lunarDay == 16) {
        holiday = @"破壳日";
    } else if (lunarMonth == 12 && lunarDay == 8) {
        holiday = @"腊八节";
    } else if (lunarMonth == 12 && lunarDay == 23) {
        holiday = @"小年";
    }
    
    return holiday;
}

//NSArray *chineseYears = [NSArray arrayWithObjects:
//                         @"甲子", @"乙丑", @"丙寅", @"丁卯",  @"戊辰",  @"己巳",  @"庚午",  @"辛未",  @"壬申",  @"癸酉",
//                         @"甲戌",   @"乙亥",  @"丙子",  @"丁丑", @"戊寅",   @"己卯",  @"庚辰",  @"辛己",  @"壬午",  @"癸未",
//                         @"甲申",   @"乙酉",  @"丙戌",  @"丁亥",  @"戊子",  @"己丑",  @"庚寅",  @"辛卯",  @"壬辰",  @"癸巳",
//                         @"甲午",   @"乙未",  @"丙申",  @"丁酉",  @"戊戌",  @"己亥",  @"庚子",  @"辛丑",  @"壬寅",  @"癸丑",
//                         @"甲辰",   @"乙巳",  @"丙午",  @"丁未",  @"戊申",  @"己酉",  @"庚戌",  @"辛亥",  @"壬子",  @"癸丑",
//                         @"甲寅",   @"乙卯",  @"丙辰",  @"丁巳",  @"戊午",  @"己未",  @"庚申",  @"辛酉",  @"壬戌",  @"癸亥", nil];
//
//NSArray *chineseMonths=[NSArray arrayWithObjects:
//                        @"正月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月",
//                        @"九月", @"十月", @"冬月", @"腊月", nil];
//
//
//NSArray *chineseDays=[NSArray arrayWithObjects:
//                      @"初一", @"初二", @"初三", @"初四", @"初五", @"初六", @"初七", @"初八", @"初九", @"初十",
//                      @"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"二十",
//                      @"廿一", @"廿二", @"廿三", @"廿四", @"廿五", @"廿六", @"廿七", @"廿八", @"廿九", @"三十",  nil];

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
