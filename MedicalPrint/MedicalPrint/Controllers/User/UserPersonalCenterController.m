//
//  UserPersonalCenterController.m
//  MedicalPrint
//
//  Created by zhangfan on 16/3/22.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import "UserPersonalCenterController.h"
#import "BaseTableViewCell.h"
#import "Masonry.h"
#import "UserPersonalHeadView.h"
#import "UserInfoRequest.h"
#import "UserPersonalCenterNavView.h"
#import "User.h"
#import "IconLabelTableViewCell.h"
#import "AccountManager.h"
#import "UIImageView+WebCache.h"
#import "MessageCenterController.h"
#import "AddressManagerController.h"
#import "FeedbackViewController.h"
#import "MyOrderListViewController.h"

@interface UserPersonalCenterController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UserPersonalHeadView *userHeadView;
@property (nonatomic, strong) UserPersonalCenterNavView *titleView;
@property (nonatomic, strong) NSArray *dataSourceArray;
@property (nonatomic, strong) User *user;

@end

@implementation UserPersonalCenterController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"我的";
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:@"" image:[[UIImage imageNamed:@"我的_常态"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"我的_按下"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        tabBarItem.imageInsets = UIEdgeInsetsMake(4.5, 0, -7, 0);
        tabBarItem.titlePositionAdjustment = UIOffsetMake(0, 50);
        self.tabBarItem = tabBarItem;
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
//
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 44, 0);
    
    self.userHeadView = [[UserPersonalHeadView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 180)];
    self.tableView.tableHeaderView = self.userHeadView;
    
    self.titleView = [[UserPersonalCenterNavView alloc] init];
    [self.view addSubview:self.titleView];
    
    [self setupViewConstraints];
    [self initNaviBarItem];
    
    [self initDataSource];
    
    [self.tableView registerClass:[IconLabelTableViewCell class] forCellReuseIdentifier:[IconLabelTableViewCell cellIdentifier]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
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
    
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.and.right.equalTo(superView);
        make.height.equalTo(@45);
    }];
}

#pragma mark - private

- (void)initNaviBarItem
{
    self.title = @"个人信息";
}

- (void)initDataSource {
    self.dataSourceArray = @[@[@{@"icon":@"消息中心_常态", @"name":@"消息中心"}, @{@"icon":@"申请项目_常态", @"name":@"申请项目"}], @[@{@"icon":@"我的订单_常态", @"name":@"我的订单"}, @{@"icon":@"我的课程_常态",@"name": @"我的课程"}], @[@{@"icon":@"地址管理_常态", @"name":@"地址管理"}, @{@"icon":@"意见提交_常态",@"name":@"意见提交"}],];
}

- (void)configureData {
    AccountManager *accountManager = [AccountManager sharedManager];
    self.user = accountManager.user;
    self.titleView.titleLabel.text = @"个人信息";
//    [self.userHeadView.avatarImageView sd_setImageWithURL:[NSURL URLWithString:nil]];
    self.userHeadView.nameLabel.text = self.user.nickName;
}

#pragma mark - IBAction



#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 20.0f;
//    return 0.0001f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {
                    MessageCenterController *messageCenterVC = [[MessageCenterController alloc] init];
                    [self.navigationController pushViewController:messageCenterVC animated:YES];
                }
                    break;
                case 1:
                {
                    MessageCenterController *messageCenterVC = [[MessageCenterController alloc] init];
                    [self.navigationController pushViewController:messageCenterVC animated:YES];
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
        case 1:
        {
            switch (indexPath.row) {
                case 0:
                {
                    MyOrderListViewController *myOrderListVC = [[MyOrderListViewController alloc] init];
                    [self.navigationController pushViewController:myOrderListVC animated:YES];

                }
                    break;
                case 1:
                {
                    
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
        case 2:
        {
            switch (indexPath.row) {
                case 0:
                {
                    AddressManagerController *addressManagerVC = [[AddressManagerController alloc] init];
                    [self.navigationController pushViewController:addressManagerVC animated:YES];
                }
                    break;
                case 1:
                {
                    FeedbackViewController *feedBackVC = [[FeedbackViewController alloc] init];
                    [self.navigationController pushViewController:feedBackVC animated:YES];
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
        default:
            break;
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *sectionArray = [self.dataSourceArray objectAtIndex:section];
    return sectionArray.count;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IconLabelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[IconLabelTableViewCell cellIdentifier] forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSArray *sectionArray = [self.dataSourceArray objectAtIndex:indexPath.section];
    NSDictionary *dic = [sectionArray objectAtIndex:indexPath.row];
    NSString *iconName = dic[@"icon"];
    NSString *name = dic[@"name"];
    cell.iconImageView.image = [UIImage imageNamed:iconName];
    cell.label.text = name;
    return cell;
}


@end
