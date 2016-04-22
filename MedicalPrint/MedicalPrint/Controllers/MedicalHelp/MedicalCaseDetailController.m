//
//  MedicalCaseDetailController.m
//  MedicalPrint
//
//  Created by zhangfan on 16/4/5.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import "MedicalCaseDetailController.h"
#import "CaseType.h"
#import "Masonry.h"
#import "UserInfoRequest.h"
#import "BaseTableViewCell.h"
#import "MedicalCase.h"
#import "MedicalCaseCell.h"
#import "SVPullToRefresh.h"
#import "MedicalCaseDetailCell.h"
#import "MedicalCaseReply.h"

@interface MedicalCaseDetailController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *medicalCaseReplyArray;
@property (nonatomic, strong) MedicalCase *medicalCase;
@property (nonatomic, strong) UIButton *editButton;

@end

@implementation MedicalCaseDetailController

- (instancetype)initWithMedicalCase:(MedicalCase *)medicalCase {
    self = [self init];
    if (self) {
        self.medicalCase = medicalCase;
        self.medicalCaseReplyArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorColor = [UIColor colorWithRed:0.929 green:0.933 blue:0.937 alpha:1.00];


    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.tableView.estimatedRowHeight = 124.0;

    self.editButton = [[UIButton alloc] init];
    [self.editButton addTarget:self action:@selector(applyButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.editButton setBackgroundImage:[UIImage imageNamed:@"通用长按钮底_常态"] forState:UIControlStateNormal];
    [self.editButton setBackgroundImage:[UIImage imageNamed:@"通用长按钮底_按下"] forState:UIControlStateHighlighted];
    [self.editButton setTitle:@"回复" forState:UIControlStateNormal];
    [self.view addSubview:self.editButton];

    
    [self setupViewConstraints];
    [self initNaviBarItem];
    
    [self.tableView registerClass:[MedicalCaseDetailCell class] forCellReuseIdentifier:[MedicalCaseDetailCell cellIdentifier]];
    
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
        make.left.right.and.top.equalTo(superView);
        make.bottom.equalTo(self.editButton.mas_top);
    }];
    
    [self.editButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.and.bottom.equalTo(superView);
        make.height.equalTo(@45);
    }];
}

#pragma mark - private

- (void)initNaviBarItem
{
    self.title = self.medicalCase.title;
}

- (void)initDataSource {
    [UserInfoRequest fetchMedicalCaseReplyForCase:self.medicalCase withStart:0 length:20 success:^(BOOL status, NSArray *medicalCaseReplyArray) {
        [self.medicalCaseReplyArray addObjectsFromArray:medicalCaseReplyArray];
        [self.tableView reloadData];
    } failure:^(NSString *msg) {
        ;
    }];
}

- (void)loadMoreData  {
    [UserInfoRequest fetchMedicalCaseReplyForCase:self.medicalCase withStart:self.medicalCaseReplyArray.count length:20 success:^(BOOL status, NSArray *medicalCaseReplyArray) {
        [self.medicalCaseReplyArray addObjectsFromArray:medicalCaseReplyArray];
        [self.tableView reloadData];
    } failure:^(NSString *msg) {
        ;
    }];
}

#pragma mark - IBAction

- (IBAction)applyButtonClicked:(id)sender {
    
}

#pragma mark - UITableViewDelegate

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 45.0f;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 38.0f;
}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 0.0001f;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] init];
    [view addSubview:label];
    label.text = self.medicalCase.title;
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(view).insets(UIEdgeInsetsMake(15, 15, 15, 15));
        make.centerY.equalTo(view.mas_centerY);
    }];
    
    return view;
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1 + self.medicalCaseReplyArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MedicalCaseDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:[MedicalCaseDetailCell cellIdentifier] forIndexPath:indexPath];
    [cell configureWithMedicalCase:self.medicalCase];
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    return cell;
}


@end
