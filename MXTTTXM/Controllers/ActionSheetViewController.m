//
//  ActionSheetViewController.m
//  MXTTTXM
//
//  Created by Michael on 5/28/15.
//  Copyright (c) 2015 MXTTTXM UPUPUP. All rights reserved.
//

#import "ActionSheetViewController.h"
#import "MXActionSheet.h"

@interface ActionSheetViewController ()<MXActionSheetDelegate>

@end

@implementation ActionSheetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *chickButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [chickButton setFrame:CGRectMake(0, 0, 60, 34)];
    [chickButton setTitle:@"Show" forState:UIControlStateNormal];
    [chickButton setBackgroundColor:[UIColor redColor]];
    [chickButton addTarget:self action:@selector(chickAction) forControlEvents:UIControlEventTouchUpInside];
    [chickButton setCenter:self.view.center];
    [self.view addSubview:chickButton];
}

- (void)chickAction {
    
    MXActionSheet *sheet = [[MXActionSheet alloc] initWithTitle:@"This is the main title"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@[@"WeChat", @"Weibo", @"Twitter", @"QQ"]];
    [sheet showInView:self.navigationController.view];
}

- (void)actionSheet:(MXActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"%@",@(buttonIndex));
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
