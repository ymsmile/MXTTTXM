//
//  MXRefreshView.m
//  MXTTTXM
//
//  Created by Michael on 5/28/15.
//  Copyright (c) 2015 MXTTTXM UPUPUP. All rights reserved.
//

#import "MXRefreshView.h"

#define FLIP_ANIMATION_DURATION 0.18f
#define LABELHEIGHT 18.f

@interface MXRefreshView ()
{
    MXRefreshState          _state;             // 当前状态
    UILabel                 *_lastUpdatedLabel; // 最后一次更新时间
    UILabel                 *_statusLabel;      // 状态标签
    CALayer                 *_arrowImage;       // 箭头图片
    UIActivityIndicatorView *_activityView;     // 菊花圈
}
@end

@implementation MXRefreshView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		self.backgroundColor = [UIColor orangeColor];
        
        CGFloat centerY = frame.size.height/2;
        
        _lastUpdatedLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, centerY-LABELHEIGHT, frame.size.width, LABELHEIGHT)];
        _lastUpdatedLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		_lastUpdatedLabel.font = [UIFont systemFontOfSize:13.0f];
		_lastUpdatedLabel.backgroundColor = [UIColor clearColor];
		_lastUpdatedLabel.textAlignment = NSTextAlignmentCenter;
        NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"RefreshTableView_LastRefresh"];
        if (str == nil)
            str = @"从未刷新";
        _lastUpdatedLabel.text = str;
		[self addSubview:_lastUpdatedLabel];
        
        _statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, centerY, frame.size.width, LABELHEIGHT)];
        _statusLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		_statusLabel.font = [UIFont boldSystemFontOfSize:13.0f];
		_statusLabel.backgroundColor = [UIColor clearColor];
		_statusLabel.textAlignment = NSTextAlignmentCenter;
		[self addSubview:_statusLabel];
        
        _arrowImage = [CALayer layer];
        _arrowImage.frame = CGRectMake(30, (frame.size.height-40)/2, 20, 40);
        _arrowImage.contentsGravity = kCAGravityResizeAspect;
        _arrowImage.contents = (id)[UIImage imageNamed:@"refresh_arrow"].CGImage;
        if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
            _arrowImage.contentsScale = [[UIScreen mainScreen] scale];
        }
        [[self layer] addSublayer:_arrowImage];
        
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        _activityView.frame = CGRectMake(30, (frame.size.height-20)/2, 20, 20);
        [self addSubview:_activityView];

		[self setState:MXRefreshNone];

    }
    return self;
}

- (void)setState:(MXRefreshState)aState{
	switch (aState) {
		case MXRefreshPulling:
        {
            _statusLabel.text = @"松开即可刷新";
        
            [CATransaction begin];
			[CATransaction setAnimationDuration:FLIP_ANIMATION_DURATION];
			_arrowImage.transform = CATransform3DMakeRotation((M_PI / 180.0) * 180.0f, 0.0f, 0.0f, 1.0f);
			[CATransaction commit];
        }
			break;
		case MXRefreshNone:
        {
			if (_state == MXRefreshPulling) {
				[CATransaction begin];
				[CATransaction setAnimationDuration:FLIP_ANIMATION_DURATION];
				_arrowImage.transform = CATransform3DIdentity;
				[CATransaction commit];
			}
            
            _statusLabel.text = @"下拉刷新";
            
            [_activityView stopAnimating];
			[CATransaction begin];
			[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
			_arrowImage.hidden = NO;
			_arrowImage.transform = CATransform3DIdentity;
			[CATransaction commit];
    
			[self refreshLastUpdatedDate];
        }
			break;
		case MXRefreshLoading:
        {
			_statusLabel.text = @"正在加载，请稍后...";
			[_activityView startAnimating];
			[CATransaction begin];
			[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
			_arrowImage.hidden = YES;
			[CATransaction commit];
        }
			break;
		default:
			break;
	}
	
	_state = aState;
}

- (void)refreshLastUpdatedDate {
    if ([_delegate respondsToSelector:@selector(refreshTableDataSourceLastUpdated:)]) {
        NSDate *date = [_delegate refreshTableDataSourceLastUpdated:self];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        _lastUpdatedLabel.text = [NSString stringWithFormat:@"上次刷新: %@", [formatter stringFromDate:date]];
        [[NSUserDefaults standardUserDefaults] setObject:_lastUpdatedLabel.text forKey:@"RefreshTableView_LastRefresh"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)refreshViewDidScroll:(UIScrollView *)scrollView {
        
    if (_state == MXRefreshLoading) {
        // 正在加载，设置上内边距
        UIEdgeInsets insets = scrollView.contentInset;
        insets.top = self.frame.size.height;
        scrollView.contentInset = insets;
        
    // scrollView正在拖拽中...
    } else if (scrollView.isDragging) {
        
        BOOL isLoading = NO;
        if ([_delegate respondsToSelector:@selector(refreshViewIsLoading:)])
            isLoading = [_delegate refreshViewIsLoading:self];
//        NSLog(@"%f", scrollView.contentOffset.y);
        
        if (_state == MXRefreshPulling && scrollView.contentOffset.y > -self.frame.size.height
            && scrollView.contentOffset.y < 0.0f && !isLoading) {

            [self setState:MXRefreshNone];

        } else if (_state == MXRefreshNone && !isLoading && scrollView.contentOffset.y < -self.frame.size.height) {
            [self setState:MXRefreshPulling];
        }
    }
}

- (void)refreshViewDidEndDragging:(UIScrollView *)scrollView {
	
	BOOL isLoading = NO;
	if ([_delegate respondsToSelector:@selector(refreshViewIsLoading:)]) {
		isLoading = [_delegate refreshViewIsLoading:self];
	}
    
    if (scrollView.contentOffset.y <= -self.frame.size.height && !isLoading) {
        
        if ([_delegate respondsToSelector:@selector(refreshViewDidEndDragging:)]) {
            [_delegate refreshViewDidEndDragging:self];
        }
        [self setState:MXRefreshLoading];
        
        [UIView animateWithDuration:0.2 animations:^(void){
            UIEdgeInsets insets =  scrollView.contentInset;
            insets.top = self.frame.size.height;
            scrollView.contentInset = insets;
        }];
    }
}

- (void)refreshViewDidFinishedLoading:(UIScrollView *)scrollView {
    
    [self setState:MXRefreshNone];

    [UIView animateWithDuration:0.3 animations:^(void){
        UIEdgeInsets insets =  scrollView.contentInset;
        insets.top = 0;
        scrollView.contentInset = insets;
    }];
}

@end
