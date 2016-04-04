//
//  MedicalCaseListController.m
//  MedicalPrint
//
//  Created by zhangfan on 16/3/31.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import "MedicalCaseListController.h"
#import "CaseType.h"
#import "Masonry.h"
#import "UserInfoRequest.h"
#import "BaseTableViewCell.h"
#import "MedicalCase.h"
#import "MedicalCaseCell.h"
#import "SVPullToRefresh.h"

@interface MedicalCaseListController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) CaseType *caseType;
@property (nonatomic, strong) NSMutableArray *medicalCaseArray;

@end

@implementation MedicalCaseListController


- (instancetype)initWtithCaseType:(CaseType *)caseType {
    self = [self init];
    if (self) {
        self.caseType = caseType;
        self.medicalCaseArray = [[NSMutableArray alloc] init];
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
    
    [self setupViewConstraints];
    [self initNaviBarItem];
    
    [self.tableView registerClass:[MedicalCaseCell class] forCellReuseIdentifier:[MedicalCaseCell cellIdentifier]];
    
    [self addPushFresh];
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
    self.title = self.caseType.name;
}

- (void)initDataSource {
    [self showLoadingWithText:@"加载中..."];
    [UserInfoRequest fetchMedicalCaseListForType:self.caseType withStart:0 length:20 success:^(BOOL status, NSArray *medicalCaseArray) {
        [self hideLoadingView];
        [self.medicalCaseArray addObjectsFromArray:medicalCaseArray];
        
        [self.tableView reloadData];
    } failure:^(NSString *msg) {
        [self hideLoadingViewWithError:@"加载失败"];
    }];
}

- (void)loadMoreData {
    [UserInfoRequest fetchMedicalCaseListForType:self.caseType withStart:self.medicalCaseArray.count length:20 success:^(BOOL status, NSArray *medicalCaseArray) {
        [self hideLoadingView];
        [self.medicalCaseArray addObjectsFromArray:medicalCaseArray];
        
        [self.tableView reloadData];
        [self.tableView.infiniteScrollingView stopAnimating];
    } failure:^(NSString *msg) {
        [self hideLoadingViewWithError:msg];
        [self.tableView.infiniteScrollingView stopAnimating];
    }];
}

- (void)addPushFresh {
    __weak MedicalCaseListController *weakSelf = self;
    
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf loadMoreData];
    }];
}

#pragma mark - IBAction



#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 82.0f;
}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 20.0f;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 0.0001f;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.medicalCaseArray.count + 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MedicalCaseCell *cell = [tableView dequeueReusableCellWithIdentifier:[MedicalCaseCell cellIdentifier] forIndexPath:indexPath];
    [cell configureWithMedicalCase:nil];
    return cell;
}




@end
