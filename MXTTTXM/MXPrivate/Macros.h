//
//  Macros.h
//  MXTTTXM
//
//  Created by Michael on 5/28/15.
//  Copyright (c) 2015 MXTTTXM UPUPUP. All rights reserved.
//

#ifndef MXTTTXM_Macros_h
#define MXTTTXM_Macros_h

/*==================================================================================================================================*/
#define MX_DISPATCH_ONCE_BLOCK(onceBlock) static dispatch_once_t onceToken; dispatch_once(&onceToken, onceBlock);
//在Main线程上运行
#define MX_DISPATCH_ON_MAIN_THREAD(mainQueueBlock) dispatch_async(dispatch_get_main_queue(), mainQueueBlock);
//在Global Queue上运行
#define MX_DISPATCH_ON_GLOBAL_QUEUE_HIGH(globalBlk) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), globalBlk);
#define MX_DISPATCH_ON_GLOBAL_QUEUE_DEFAULT(globalBlk) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), globalBlk);
#define MX_DISPATCH_ON_GLOBAL_QUEUE_LOW(globalBlk) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), globalBlk);
#define MX_DISPATCH_ON_GLOBAL_QUEUE_BACKGROUND(globalBlk) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), globalBlk);
/*==================================================================================================================================*/
#ifdef DEBUG
#define MXLog(fmt, ...) NSLog(@"%s [Line %d]" fmt, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define MXLog(...)
#endif
/*==================================================================================================================================*/
#ifndef STRONG
#if __has_feature(objc_arc)
#define STRONG strong
#else
#define STRONG retain
#endif
#endif
/*==================================================================================================================================*/
#ifndef WEAK
#if __has_feature(objc_arc_weak)
#define WEAK weak
#elif __has_feature(objc_arc)
#define WEAK unsafe_unretained
#else
#define WEAK assgin
#endif
#endif
/*==================================================================================================================================*/
#define WS(weakSelf) __weak __typeof(&*self)weakSelf = self;
/*==================================================================================================================================*/
#if __has_feature(objc_arc)
#define RELEASE(id) ({ if (id != nil) { id = nil; } })
#else
#define RELEASE(id) ({ if (id != nil) { [id release];id = nil; } })
#endif
/*==================================================================================================================================*/
#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)
/*==================================================================================================================================*/
// View的属性
#define MXGetViewWidth(view)        view.frame.size.width
#define MXGetViewHeight(view)       view.frame.size.height
#define MXGetViewX(view)            view.frame.origin.x
#define MXGetViewY(view)            view.frame.origin.y
#define MXGetViewBottom(view)       view.frame.origin.x + view.frame.size.height
#define MXGetViewRight(view)        view.frame.origin.x + view.frame.size.width
/*==================================================================================================================================*/
#define MXGetScreenWidth            [[UIScreen mainScreen] bounds].size.width
#define MXGetScreenHeight           [[UIScreen mainScreen] bounds].size.height
#define kIS_5_5_Inch                (MXGetScreenHeight == 736 ? YES : NO)
#define kIS_4_7_Inch                (MXGetScreenHeight == 667 ? YES : NO)
#define kIS_4_Inch                  (MXGetScreenHeight == 568 ? YES : NO)
#define kIS_3_5Inch                 (MXGetScreenHeight == 480 ? YES : NO)
/*==================================================================================================================================*/
// 获取图片资源
#define MXGetImage(imageName)       [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]
/*==================================================================================================================================*/
// 颜色配置
#define MXRGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define MXRGBAplha(r, g ,b , a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define MXColorFromHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
/*==================================================================================================================================*/
#define MXGetStoryboard             [UIStoryboard storyboardWithName:@"Main" bundle:nil]
/*==================================================================================================================================*/
#define SET_NSUSERDEFAULTS(_VALUE,_KEY) ({\
[[NSUserDefaults standardUserDefaults] setObject:_VALUE forKey:_KEY];\
[[NSUserDefaults standardUserDefaults] synchronize];\
});
#define GET_NSUSERDEFAULTS(_KEY) ([[NSUserDefaults standardUserDefaults] objectForKey:_KEY])
/*==================================================================================================================================*/
#define MXDocPath   [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
/*==================================================================================================================================*/

/*==================================================================================================================================*/

/*==================================================================================================================================*/

/*==================================================================================================================================*/

/*==================================================================================================================================*/










#endif
