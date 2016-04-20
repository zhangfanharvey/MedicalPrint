//
//  NewsCaseTypeListController.m
//  MedicalPrint
//
//  Created by zhangfan on 16/4/19.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import "NewsCaseTypeListController.h"
#import "Masonry.h"
#import "UserInfoRequest.h"
#import "BaseTableViewCell.h"
#import "NewsCaseTypeListCell.h"
#import "NewsType.h"
#import "NewsListController.h"

@interface NewsCaseTypeListController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *newsTypeArray;

@end

@implementation NewsCaseTypeListController

- (instancetype)initWithCaseTypeArray:(NSArray *)newsTypeArray {
    self = [self init];
    if (self) {
        self.newsTypeArray = newsTypeArray;
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
    
    [self.tableView registerClass:[NewsCaseTypeListCell class] forCellReuseIdentifier:[NewsCaseTypeListCell cellIdentifier]];
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
    self.title = @"资讯分类";
}

#pragma mark - IBAction



#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 65.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NewsType *newsType = [self.newsTypeArray objectAtIndex:indexPath.row];
    NewsListController *newsListVC = [[NewsListController alloc] initWithCaseType:newsType];
    [self.navigationController pushViewController:newsListVC animated:YES];

}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.newsTypeArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsCaseTypeListCell *cell = [tableView dequeueReusableCellWithIdentifier:[NewsCaseTypeListCell cellIdentifier] forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NewsType *newsType = [self.newsTypeArray objectAtIndex:indexPath.row];
    [cell configureWithCaseType:newsType];
    return cell;
}


@end
