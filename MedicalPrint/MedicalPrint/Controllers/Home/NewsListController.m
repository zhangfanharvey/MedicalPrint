//
//  NewsListController.m
//  MedicalPrint
//
//  Created by zhangfan on 16/4/19.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import "NewsListController.h"
#import "Masonry.h"
#import "UserInfoRequest.h"
#import "BaseTableViewCell.h"
#import "HomeNewsListCell.h"
#import "NewsType.h"
#import "NewsDetailController.h"
#import "SVPullToRefresh.h"

@interface NewsListController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NewsType *newsType;
@property (nonatomic, strong) NSMutableArray *newsListArray;


@end

@implementation NewsListController

- (instancetype)initWithCaseType:(NewsType *)newsType; {
    self = [self init];
    if (self) {
        self.newsType = newsType;
        self.newsListArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorColor = [UIColor colorWithRed:0.929 green:0.933 blue:0.937 alpha:1.00];

    [self setupViewConstraints];
    [self initNaviBarItem];
    
    [self createRefreshView];
    
    [self.tableView registerClass:[HomeNewsListCell class] forCellReuseIdentifier:[HomeNewsListCell cellIdentifier]];
    
    [self initDataSource];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - View Auto-Layout

- (void)setupViewConstraints
{
    UIView *superView = self.view;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(superView);
    }];
}

#pragma mark - private

- (void)initNaviBarItem
{
    self.title = self.newsType.name ? self.newsType.name : @"资讯列表";
}

- (void)initDataSource {
    [self showLoadingWithText:@"加载中..."];
    [UserInfoRequest fetchNewsListForType:self.newsType withStart:0 length:20 success:^(BOOL status, NSArray *newsArray) {
        [self.newsListArray addObjectsFromArray:newsArray];
        [self hideLoadingView];
        [self.tableView reloadData];
    } failure:^(NSString *msg) {
        [self hideLoadingViewWithError:@"加载失败"];
    }];
}

- (void)loadMoreData {
    [UserInfoRequest fetchNewsListForType:self.newsType withStart:self.newsListArray.count length:20 success:^(BOOL status, NSArray *newsArray) {
        [self.newsListArray addObjectsFromArray:newsArray];
        [self.tableView reloadData];
        [self.tableView.infiniteScrollingView stopAnimating];
    } failure:^(NSString *msg) {
        [self.tableView.infiniteScrollingView stopAnimating];
    }];
}

- (void)createRefreshView {
    __weak NewsListController *weakSelf = self;
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf loadMoreData];
    }];
}

#pragma mark - IBAction



#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 72.0f;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 0.0001f;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 0.0001f;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    News *news = [self.newsListArray objectAtIndex:indexPath.row];
    NewsDetailController *newsDetailVC = [[NewsDetailController alloc] initWithNews:news];
    [self.navigationController pushViewController:newsDetailVC animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.newsListArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeNewsListCell *cell = [tableView dequeueReusableCellWithIdentifier:[HomeNewsListCell cellIdentifier] forIndexPath:indexPath];
    News *news = [self.newsListArray objectAtIndex:indexPath.row];
    [cell configureWithNews:news];
    return cell;
}



@end
