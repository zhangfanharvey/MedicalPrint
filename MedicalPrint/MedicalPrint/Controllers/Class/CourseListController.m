//
//  CourseListController.m
//  MedicalPrint
//
//  Created by zhangfan on 16/4/14.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import "CourseListController.h"
#import "CourseTopicCell.h"
#import "BaseTableViewCell.h"
#import "Masonry.h"
#import "UserInfoRequest.h"
#import "Course.h"
#import "CourseCell.h"
#import "CourseTopic.h"
#import "SVPullToRefresh.h"
#import "CourseDetailController.h"

@interface CourseListController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *courseArray;
@property (nonatomic, strong) CourseTopic *topic;

@end

@implementation CourseListController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.courseArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (instancetype)initWithCourseTopic:(CourseTopic *)topic {
    self = [self init];
    if (self) {
        self.topic = topic;
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
    
    [self.tableView registerClass:[CourseCell class] forCellReuseIdentifier:[CourseCell cellIdentifier]];
    
    [self createRefreshView];
    
    [self initDataSource];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
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
    self.title = @"培训课程";
}

- (void)initDataSource {
    [self showLoadingWithText:@"加载中..."];
    [UserInfoRequest fetchCourseListForTopic:self.topic withStart:0 length:20 success:^(BOOL status, NSArray *courseArray) {
        [self.courseArray addObjectsFromArray:courseArray];
        [self hideLoadingView];
        [self.tableView reloadData];
    } failure:^(NSString *msg) {
        [self hideLoadingViewWithError:@"加载失败"];
    }];
}

- (void)loadMoreData {
    [UserInfoRequest fetchCourseListForTopic:self.topic withStart:self.courseArray.count length:20 success:^(BOOL status, NSArray *courseArray) {
        [self.tableView.infiniteScrollingView stopAnimating];
        [self.courseArray addObjectsFromArray:courseArray];
        [self.tableView reloadData];
    } failure:^(NSString *msg) {
        [self.tableView.infiniteScrollingView stopAnimating];
    }];
     
}

- (void)createRefreshView {
    __weak CourseListController *weakSelf = self;
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf loadMoreData];
    }];
}

#pragma mark - IBAction



#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 128.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Course *course = [self.courseArray objectAtIndex:indexPath.row];
    CourseDetailController *courseDetailVC = [[CourseDetailController alloc] initWithCourse:course];
    [self.navigationController pushViewController:courseDetailVC animated:YES];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.courseArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CourseCell *cell = [tableView dequeueReusableCellWithIdentifier:[CourseCell cellIdentifier] forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    Course *course = [self.courseArray objectAtIndex:indexPath.row];
    [cell configureWithCourse:course];
    return cell;
}



@end
