//
//  MXNavigationController.m
//  MXTTTXM
//
//  Created by Michael on 5/28/15.
//  Copyright (c) 2015 MXTTTXM UPUPUP. All rights reserved.
//

#import "MXNavigationController.h"

@interface MXNavigationController ()

@end

@implementation MXNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 设置导航条背景图片
    [self.navigationBar setBackgroundImage:[UIImage imageWithhColor:MXRGB(63, 184, 56)]
                            forBarPosition:UIBarPositionAny
                                barMetrics:UIBarMetricsDefault];
    
//    [self.navigationBar setTintColor:MXRGB(63, 184, 56)];
    
    UIColor *titleColor = [UIColor whiteColor];
    NSDictionary *titleDict = [NSDictionary dictionaryWithObjectsAndKeys:
                               titleColor, NSForegroundColorAttributeName,
                               nil];
    [self.navigationBar setTitleTextAttributes:titleDict];
    
    // 隐藏导航条下面的那根线
//    [self.navigationBar setShadowImage:[UIImage new]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
