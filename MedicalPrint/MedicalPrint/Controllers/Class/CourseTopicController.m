//
//  CourseTopicController.m
//  MedicalPrint
//
//  Created by zhangfan on 16/4/14.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import "CourseTopicController.h"
#import "CourseTopicCell.h"
#import "BaseTableViewCell.h"
#import "Masonry.h"
#import "UserInfoRequest.h"
#import "CourseListController.h"

@interface CourseTopicController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *courseTopicArray;

@end

@implementation CourseTopicController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.courseTopicArray = [[NSMutableArray alloc] init];
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
    
    [self.tableView registerClass:[CourseTopicCell class] forCellReuseIdentifier:[CourseTopicCell cellIdentifier]];
    
    [self initDataSource];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
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
    [UserInfoRequest fetchCourseTopicSuccess:^(BOOL status, NSArray *courseTopicArray) {
        [self.courseTopicArray addObjectsFromArray:courseTopicArray];
        [self hideLoadingView];
        [self.tableView reloadData];
    } failure:^(NSString *msg) {
        [self hideLoadingViewWithError:@"加载失败"];
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
    CourseTopic *topic = [self.courseTopicArray objectAtIndex:indexPath.row];
    CourseListController *courseListVC = [[CourseListController alloc] initWithCourseTopic:topic];
    [self.navigationController pushViewController:courseListVC animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.courseTopicArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CourseTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:[CourseTopicCell cellIdentifier] forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    CourseTopic *topic = [self.courseTopicArray objectAtIndex:indexPath.row];
    [cell configureWithCourseTopic:topic];
    return cell;
}



@end
