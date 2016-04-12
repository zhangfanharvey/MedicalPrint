//
//  MyClassListController.m
//  MedicalPrint
//
//  Created by zhangfan on 16/3/23.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import "MyClassListController.h"
#import "BaseTableViewCell.h"
#import "Masonry.h"
#import "UserInfoRequest.h"
#import "ClassListCell.h"
#import "SVPullToRefresh.h"

@interface MyClassListController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *classListArray;

@end

@implementation MyClassListController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.classListArray = [[NSMutableArray alloc] init];
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
    
    [self.tableView registerClass:[ClassListCell class] forCellReuseIdentifier:[ClassListCell cellIdentifier]];
    
    
    
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
    self.title = @"个人信息";
}

- (void)initDataSource {
    [self showLoadingWithText:@""];
    [UserInfoRequest fetchAddressList:0 length:20 success:^(BOOL status, NSArray *addressArray) {
        [self.classListArray addObjectsFromArray:addressArray];
        [self hideLoadingView];
        [self.tableView reloadData];
    } failure:^(NSString *msg) {
        [self hideLoadingViewWithError:@"加载失败"];
    }];
    
}

- (void)loadMoreData {
    [UserInfoRequest fetchAddressList:self.classListArray.count length:20 success:^(BOOL status, NSArray *addressArray) {
        [self.tableView.infiniteScrollingView stopAnimating];
        [self.classListArray addObjectsFromArray:addressArray];
        [self.tableView reloadData];
    } failure:^(NSString *msg) {
        [self.tableView.infiniteScrollingView stopAnimating];
    }];
}

- (void)createRefreshView {
    __weak MyClassListController *weakSelf = self;
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf loadMoreData];
    }];
}

#pragma mark - IBAction



#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45.0f;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ClassListCell *cell = [tableView dequeueReusableCellWithIdentifier:[ClassListCell cellIdentifier] forIndexPath:indexPath];
    
    return cell;
}


@end
