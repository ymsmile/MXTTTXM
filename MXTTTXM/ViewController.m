//
//  ViewController.m
//  MXTTTXM
//
//  Created by Michael on 5/28/15.
//  Copyright (c) 2015 MXTTTXM UPUPUP. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    // Do any additional setup after loading the view, typically from a nib.
    [self createRoundedImage];
}

///TODO:创建圆角圆形图
- (void)createRoundedImage {
    UIImage *img = [UIImage imageNamed:@"logo.jpg"];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 70, 120, 120)];
    imgView.image = img;
    [self.view addSubview:imgView];

    [imgView setRounded];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
