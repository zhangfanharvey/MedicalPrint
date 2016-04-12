//
//  AddressManagerController.m
//  MedicalPrint
//
//  Created by zhangfan on 16/3/24.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import "AddressManagerController.h"
#import "BaseTableViewCell.h"
#import "Masonry.h"
#import "UserInfoRequest.h"
#import "AddressManagerCell.h"
#import "ShippingAddress.h"
#import "SVPullToRefresh.h"
#import "AddressEditController.h"

@interface AddressManagerController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *shipAddressArray;

@end

@implementation AddressManagerController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.shipAddressArray = [[NSMutableArray alloc] init];
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
    
    [self setupViewConstraints];
    [self initNaviBarItem];
    
    [self.tableView registerClass:[AddressManagerCell class] forCellReuseIdentifier:[AddressManagerCell cellIdentifier]];
    
    [self createRefreshView];
    
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
    self.title = @"地址管理";
    [self initNavBarButtonItemWithImages:@[@"顶部撤回键"] action:@selector(backButtonClicked:) isLeft:YES];
    [self initNavBarButtonItemWithTitle:@"新增" action:@selector(addAddressButtonClicked:) isLeft:NO];
}

- (void)initDataSource {
    [self showLoadingWithText:@""];
    [UserInfoRequest fetchAddressList:0 length:20 success:^(BOOL status, NSArray *addressArray) {
        [self.shipAddressArray addObjectsFromArray:addressArray];
        [self hideLoadingView];
        [self.tableView reloadData];
    } failure:^(NSString *msg) {
        [self hideLoadingViewWithError:@"加载失败"];
    }];
    
}

- (void)loadMoreData {
    [UserInfoRequest fetchAddressList:self.shipAddressArray.count length:20 success:^(BOOL status, NSArray *addressArray) {
        [self.tableView.infiniteScrollingView stopAnimating];
        [self.shipAddressArray addObjectsFromArray:addressArray];
        [self.tableView reloadData];
    } failure:^(NSString *msg) {
        [self.tableView.infiniteScrollingView stopAnimating];
    }];
}

- (void)createRefreshView {
    __weak AddressManagerController *weakSelf = self;
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf loadMoreData];
    }];
}

#pragma mark - IBAction

- (IBAction)editButtonClicked:(id)sender {
    UIButton *button = (UIButton *)sender;
    ShippingAddress *address = [self.shipAddressArray objectAtIndex:button.tag];
    
}

- (IBAction)addAddressButtonClicked:(id)sender {
    AddressEditController *addressEditVC = [[AddressEditController alloc] init];
    [self.navigationController pushViewController:addressEditVC animated:YES];
}

- (IBAction)deleteButtonClicked:(id)sender {
    UIButton *button = (UIButton *)sender;
    ShippingAddress *address = [self.shipAddressArray objectAtIndex:button.tag];
    [self showLoadingWithText:@"删除中..."];
    [UserInfoRequest deleteAddress:address success:^(BOOL status) {
        [self hideLoadingView];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[self.shipAddressArray indexOfObject:address] inSection:0];

        [self.shipAddressArray removeObject:address];
        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView endUpdates];
    } failure:^(NSString *msg) {
        [self hideLoadingViewWithError:@"删除失败"];
    }];
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 124.0f;
}

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
    return self.shipAddressArray.count + 3;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddressManagerCell *cell = [tableView dequeueReusableCellWithIdentifier:[AddressManagerCell cellIdentifier] forIndexPath:indexPath];
    [cell.editButton removeTarget:self action:@selector(editButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [cell.editButton addTarget:self action:@selector(editButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [cell.deleteButton removeTarget:self action:@selector(deleteButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [cell.deleteButton addTarget:self action:@selector(deleteButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    cell.editButton.tag = indexPath.row;
    cell.deleteButton.tag = indexPath.row;
    if (self.shipAddressArray.count > indexPath.row) {
        ShippingAddress *address = [self.shipAddressArray objectAtIndex:indexPath.row];
        [cell configureWithShipAddress:address];
    } else {
        [cell configureWithShipAddress:nil];

    }

    return cell;
}


@end
