//
//  UIScrollView+MXAddtion.h
//  MXTTTXM
//
//  Created by Michael on 16/9/13.
//  Copyright © 2016年 MXTTTXM UPUPUP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (MXAddtion)

/**
 *  根据视图尺寸获取视图截屏（一屏无法显示完整）,适用于UIScrollView UITableviewView UICollectionView UIWebView
 *
 *  @return UIImage 截取的图片
 */
- (UIImage *)mx_scrollViewScreenshot;

@end
