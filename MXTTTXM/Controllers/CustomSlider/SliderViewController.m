//
//  SliderViewController.m
//  MXTTTXM
//
//  Created by Michael on 5/28/15.
//  Copyright (c) 2015 MXTTTXM UPUPUP. All rights reserved.
//

#import "SliderViewController.h"

@interface SliderViewController ()

@end

@implementation SliderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UISlider *slider = [[UISlider alloc]initWithFrame:CGRectMake(20, 100, 280, 10)];
    [slider setMinimumTrackImage:[UIImage imageNamed:@"slider_bg1"] forState:UIControlStateNormal];
    [slider setMaximumTrackImage:[UIImage imageNamed:@"slider_bg1"] forState:UIControlStateNormal];
    [slider setThumbImage:[UIImage imageNamed:@"slider_indicator"] forState:UIControlStateNormal];
    [slider setThumbImage:[UIImage imageNamed:@"slider_indicator"] forState:UIControlStateHighlighted];
    // 拖动结束时才调用
    [slider addTarget:self action:@selector(controlEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:slider];
}

- (void)controlEvent:(UISlider *)slider {
    
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
