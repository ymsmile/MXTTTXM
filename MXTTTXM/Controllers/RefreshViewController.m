//
//  RefreshViewController.m
//  MXTTTXM
//
//  Created by Michael on 5/28/15.
//  Copyright (c) 2015 MXTTTXM UPUPUP. All rights reserved.
//

#import "RefreshViewController.h"
#import "MXRefreshView.h"

@interface RefreshViewController ()<MXRefreshDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *infoTableView;
@property (nonatomic, strong) MXRefreshView *headerRefreshView;
@property (nonatomic, assign) BOOL isRefreshing;
@property (nonatomic, strong) NSMutableArray *list;

@end

@implementation RefreshViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
    self.list = [@[@"江西", @"广东", @"贵州", @"湖南", @"安徽", @"河北", @"西藏", @"吉林"] mutableCopy];
    
    _headerRefreshView = [[MXRefreshView alloc] initWithFrame:CGRectMake(0, -50, self.infoTableView.frame.size.width, 50)];
    _headerRefreshView.delegate = self;
    [self.infoTableView addSubview:_headerRefreshView];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ss = @"aaa";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ss];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ss];
    }
    cell.backgroundColor = [UIColor lightGrayColor];
    cell.textLabel.text = self.list[indexPath.row];
    
    return cell;
}

#pragma mark - MXRefreshDelegate

- (NSDate *)refreshTableDataSourceLastUpdated:(MXRefreshView *)view {
    return [NSDate date];
}

- (BOOL)refreshViewIsLoading:(MXRefreshView *)view {
    return _isRefreshing;
}

- (void)refreshViewDidEndDragging:(MXRefreshView *)view {
    _isRefreshing = YES;
    
    double delayInSeconds = 2;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        _isRefreshing = NO;
        [_headerRefreshView refreshViewDidFinishedLoading:self.infoTableView];// 动画去除隐藏顶部的视图
    });
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_headerRefreshView refreshViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [_headerRefreshView refreshViewDidEndDragging:scrollView];
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
