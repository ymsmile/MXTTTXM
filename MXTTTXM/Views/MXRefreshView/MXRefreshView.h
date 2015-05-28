//
//  MXRefreshView.h
//  MXTTTXM
//
//  Created by Michael on 5/28/15.
//  Copyright (c) 2015 MXTTTXM UPUPUP. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    MXRefreshNone,
	MXRefreshPulling,   // 正在拖拽
	MXRefreshLoading    // 正在加载
}MXRefreshState;

@class MXRefreshView;

@protocol MXRefreshDelegate <NSObject>

/***/
- (void)refreshViewDidEndDragging:(MXRefreshView *)view;
/** 视图是否正在刷新 */
- (BOOL)refreshViewIsLoading:(MXRefreshView *)view;
@optional
- (NSDate *)refreshTableDataSourceLastUpdated:(MXRefreshView *)view;

@end

@interface MXRefreshView : UIView

@property(nonatomic, weak) id<MXRefreshDelegate> delegate;

/** 刷新最后一次更新时间 */
- (void)refreshLastUpdatedDate;

/** 开始滚动的时候调用 */
- (void)refreshViewDidScroll:(UIScrollView *)scrollView;

/** 拖拽完毕后调用 */
- (void)refreshViewDidEndDragging:(UIScrollView *)scrollView;

/** 数据加载完成后调用 */
- (void)refreshViewDidFinishedLoading:(UIScrollView *)scrollView;

@end
