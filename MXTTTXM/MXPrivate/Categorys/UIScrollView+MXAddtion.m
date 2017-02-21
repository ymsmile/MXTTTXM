//
//  UIScrollView+MXAddtion.m
//  MXTTTXM
//
//  Created by Michael on 16/9/13.
//  Copyright © 2016年 MXTTTXM UPUPUP. All rights reserved.
//

#import "UIScrollView+MXAddtion.h"

@implementation UIScrollView (MXAddtion)

/**
 *  根据视图尺寸获取视图截屏（一屏无法显示完整）,适用于UIScrollView UITableviewView UICollectionView UIWebView
 *
 *  @return UIImage 截取的图片
 */
//- (UIImage *)mx_scrollViewScreenshot {
//    //保存
//    CGPoint savedContentOffset = self.contentOffset;
//    CGRect savedFrame = self.frame;
//    
//    self.contentOffset = CGPointZero;
//    self.frame = CGRectMake(0, 0, self.contentSize.width, self.contentSize.height);
//    
//    UIImage *image = [self mx_viewScreenshot];
//    
//    //还原数据
//    self.contentOffset = savedContentOffset;
//    self.frame = savedFrame;
//    
//    return image;
//}

- (UIImage *)mx_scrollViewScreenshot {
    UIImage* viewImage = nil;
    UIScrollView *scrollView = self;
    UIGraphicsBeginImageContextWithOptions(scrollView.contentSize, scrollView.opaque, 0.0);
    {
        CGPoint savedContentOffset = scrollView.contentOffset;
        CGRect savedFrame = scrollView.frame;
        
        scrollView.contentOffset = CGPointZero;
        scrollView.frame = CGRectMake(0, 0, scrollView.contentSize.width, scrollView.contentSize.height);
        
        [scrollView.layer renderInContext: UIGraphicsGetCurrentContext()];
        viewImage = UIGraphicsGetImageFromCurrentImageContext();
        
        scrollView.contentOffset = savedContentOffset;
        scrollView.frame = savedFrame;
    }
    UIGraphicsEndImageContext();
    
    return viewImage;
}

@end
