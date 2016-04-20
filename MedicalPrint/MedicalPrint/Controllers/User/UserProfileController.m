//
//  UserProfileController.m
//  MedicalPrint
//
//  Created by zhangfan on 16/4/20.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import "UserProfileController.h"
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
#import "MyClassListController.h"
#import "CourseTopicController.h"
#import "UserProfileEditController.h"
#import "TagSexSelectCell.h"
#import "TagLabelCell.h"
#import "AccountManager.h"

@interface UserProfileController ()<UITableViewDataSource, UITableViewDelegate, UserPersonalHeadViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UserPersonalHeadView *userHeadView;
@property (nonatomic, strong) UserPersonalCenterNavView *titleView;
@property (nonatomic, strong) NSArray *dataSourceArray;
@property (nonatomic, strong) User *user;

@property (nonatomic, strong) UIButton *editButton;

@property (nonatomic, assign) BOOL sex;

@end

@implementation UserProfileController

- (instancetype)init
{
    self = [super init];
    if (self) {
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
    [self.titleView.backButton addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.titleView];
    
    self.editButton = [[UIButton alloc] init];
    [self.editButton addTarget:self action:@selector(editButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.editButton setBackgroundImage:[UIImage imageNamed:@"通用长按钮底_常态"] forState:UIControlStateNormal];
    [self.editButton setBackgroundImage:[UIImage imageNamed:@"通用长按钮底_按下"] forState:UIControlStateHighlighted];
    [self.editButton setTitle:@"编辑" forState:UIControlStateNormal];
    [self.view addSubview:self.editButton];
    
    [self setupViewConstraints];
    [self initNaviBarItem];
    
    [self.tableView registerClass:[TagLabelCell class] forCellReuseIdentifier:[TagLabelCell cellIdentifier]];
    [self.tableView registerClass:[TagSexSelectCell class] forCellReuseIdentifier:[TagSexSelectCell cellIdentifier]];

    [self initDataSource];
    [self configureData];
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
        make.left.right.and.top.equalTo(superView);
        make.bottom.equalTo(self.editButton.mas_top);
    }];
    
    [self.editButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.and.bottom.equalTo(superView);
        make.height.equalTo(@45);
    }];
    
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(superView);
        make.top.equalTo(superView.mas_top).offset(20);
        make.height.equalTo(@45);
    }];
}

#pragma mark - private

- (void)initNaviBarItem
{
    self.title = @"个人信息";
    [self initNavBarButtonItemWithTitle:@"注销" action:@selector(logoutButtonClicked:) isLeft:NO];
}

- (void)initDataSource {
    self.dataSourceArray = @[@[@{@"icon":@"消息中心_常态", @"name":@"消息中心"}, @{@"icon":@"申请项目_常态", @"name":@"申请项目"}], @[@{@"icon":@"我的订单_常态", @"name":@"我的订单"}, @{@"icon":@"我的课程_常态",@"name": @"我的课程"}], @[@{@"icon":@"地址管理_常态", @"name":@"地址管理"}, @{@"icon":@"意见提交_常态",@"name":@"意见提交"}, @{@"icon":@"意见提交_常态",@"name":@"意见提交"}],];
}

- (void)configureData {
    AccountManager *accountManager = [AccountManager sharedManager];
    self.user = accountManager.user;
    self.titleView.titleLabel.text = @"个人信息";
    self.titleView.backButton.hidden = NO;
    //    [self.userHeadView.avatarImageView sd_setImageWithURL:[NSURL URLWithString:nil]];
    self.userHeadView.nameLabel.text = [self.user showNickName];
}

#pragma mark - IBAction

- (IBAction)editButtonClicked:(id)sender {
    UserProfileEditController *editController = [[UserProfileEditController alloc] init];
    [self.navigationController pushViewController:editController animated:YES];
}

- (IBAction)logoutButtonClicked:(id)sender {
    [[AccountManager sharedManager] logoutAccount];
}

- (IBAction)maleButtonClicked:(id)sender{
    self.sex = YES;
    TagSexSelectCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    [cell selectMale:YES];
    
}

- (IBAction)femaleButtonClicked:(id)sender {
    self.sex = NO;
    TagSexSelectCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    [cell selectMale:NO];
}

#pragma mark - UserPersonalHeadViewDelegate

- (void)personalHeadView:(UserPersonalHeadView *)headView didClickedAvatarView:(UIImageView *)avatarView {
    
}

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
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            TagLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:[TagLabelCell cellIdentifier] forIndexPath:indexPath];
            cell.tagLabel.text = @"姓名";
            cell.label.text = [self.user showNickName];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            return cell;
        } else {
            TagSexSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:[TagSexSelectCell cellIdentifier] forIndexPath:indexPath];
            cell.tagLabel.text = @"性别";
            
            return cell;

        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            TagLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:[TagLabelCell cellIdentifier] forIndexPath:indexPath];
            cell.tagLabel.text = @"手机号码";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.label.text = self.user.phone;
            
            
            return cell;

        } else {
            TagLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:[TagLabelCell cellIdentifier] forIndexPath:indexPath];
            cell.tagLabel.text = @"邮箱地址";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.label.text = self.user.email;
            return cell;
        }
    }
    else {
        if (indexPath.row == 0) {
            TagLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:[TagLabelCell cellIdentifier] forIndexPath:indexPath];
            cell.tagLabel.text = @"单位";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.label.text = self.user.company;
            
            
            return cell;
            
        } else if (indexPath.row == 1) {
            TagLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:[TagLabelCell cellIdentifier] forIndexPath:indexPath];
            cell.tagLabel.text = @"科室";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.label.text = self.user.department;
            return cell;
        }
        else {
            TagLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:[TagLabelCell cellIdentifier] forIndexPath:indexPath];
            cell.tagLabel.text = @"职位";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.label.text = self.user.position;
            return cell;
        }
    }
    return nil;
}


@end
