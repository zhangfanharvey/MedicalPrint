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
#import "PublishMedicalHelpController.h"
#import "MedicalCaseDetailController.h"

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
    self.tableView.separatorColor = [UIColor colorWithRed:0.929 green:0.933 blue:0.937 alpha:1.00];

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
    [self initNavBarButtonItemWithTitle:@"发布" action:@selector(publishMedicalCaseHelp:) isLeft:NO];
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
        [self.medicalCaseArray addObjectsFromArray:medicalCaseArray];
        
        [self.tableView reloadData];
        [self.tableView.infiniteScrollingView stopAnimating];
    } failure:^(NSString *msg) {
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

- (IBAction)publishMedicalCaseHelp:(id)sender {
    PublishMedicalHelpController *publishMedicalHelpVC = [[PublishMedicalHelpController alloc] initWithCaseType:self.caseType];
    [self.navigationController pushViewController:publishMedicalHelpVC animated:YES];
}

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
    MedicalCase *medicalCase = [self.medicalCaseArray objectAtIndex:indexPath.row];
    MedicalCaseDetailController *medicalCaseDetailVC = [[MedicalCaseDetailController alloc] initWithMedicalCase:medicalCase];
    [self.navigationController pushViewController:medicalCaseDetailVC animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        MedicalCase *medicalCase = [self.medicalCaseArray objectAtIndex:indexPath.row];
        [self showLoadingWithText:@"删除中..."];
        [UserInfoRequest deleteMedicalCase:medicalCase success:^(BOOL status) {
            [self hideLoadingView];
            [self.self.medicalCaseArray removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        } failure:^(NSString *msg) {
            [self hideLoadingViewWithError:@"删除失败"];
        }];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.medicalCaseArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MedicalCaseCell *cell = [tableView dequeueReusableCellWithIdentifier:[MedicalCaseCell cellIdentifier] forIndexPath:indexPath];
    MedicalCase *medicalCase = [self.medicalCaseArray objectAtIndex:indexPath.row];
    [cell configureWithMedicalCase:medicalCase];
    return cell;
}




@end
