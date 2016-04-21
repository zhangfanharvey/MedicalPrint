//
//  UserProfileEditController.m
//  MedicalPrint
//
//  Created by zhangfan on 16/4/20.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import "UserProfileEditController.h"
#import "TagSexSelectCell.h"
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

@interface UserProfileEditController ()<UITableViewDataSource, UITableViewDelegate, UserPersonalHeadViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UserPersonalHeadView *userHeadView;
@property (nonatomic, strong) UserPersonalCenterNavView *titleView;
@property (nonatomic, strong) NSArray *dataSourceArray;
@property (nonatomic, strong) User *user;

@property (nonatomic, strong) UIButton *saveButton;

@property (nonatomic, assign) BOOL sex;

@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *company;
@property (nonatomic, strong) NSString *department;
@property (nonatomic, strong) NSString *position;

@property (nonatomic, weak) UITextField *currentActivedTextField;
@property (nonatomic, weak) UITextField *nickNameTextField;
@property (nonatomic, weak) UITextField *phoneTextField;
@property (nonatomic, weak) UITextField *emailTextField;
@property (nonatomic, weak) UITextField *companyTextField;
@property (nonatomic, weak) UITextField *departmentTextField;
@property (nonatomic, weak) UITextField *positionTextField;


@end

@implementation UserProfileEditController

- (void)dealloc {
    [self unRegisterKeyboardNotification];
}

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
    
    self.saveButton = [[UIButton alloc] init];
    [self.saveButton addTarget:self action:@selector(saveButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.saveButton setBackgroundImage:[UIImage imageNamed:@"通用长按钮底_常态"] forState:UIControlStateNormal];
    [self.saveButton setBackgroundImage:[UIImage imageNamed:@"通用长按钮底_按下"] forState:UIControlStateHighlighted];
    [self.saveButton setTitle:@"保存" forState:UIControlStateNormal];
    [self.view addSubview:self.saveButton];
    
    [self setupViewConstraints];
    [self initNaviBarItem];
    
    [self.tableView registerClass:[TagLabelCell class] forCellReuseIdentifier:[TagLabelCell cellIdentifier]];
    [self.tableView registerClass:[TagSexSelectCell class] forCellReuseIdentifier:[TagSexSelectCell cellIdentifier]];
    
    [self initDataSource];
    [self configureData];
    [self configureTempData];
    
    [self registerKeyboardNotification];
    [self addTapGesture];

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
        make.bottom.equalTo(self.saveButton.mas_top);
    }];
    
    [self.saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
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
//    [self initNavBarButtonItemWithTitle:@"注销" action:@selector(logoutButtonClicked:) isLeft:NO];
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

- (void)configureTempData {
    if (self.user) {
        self.nickName = self.user.nickName;
        self.phone = self.user.phone;
        self.email = self.user.email;
        self.company = self.user.company;
        self.department = self.user.department;
        self.position = self.user.position;
    }
}

- (void)updateLocalUserInfo {
    self.user.nickName = self.nickName;
    self.user.company = self.company;
    self.user.department = self.department;
    self.user.position = self.position;
    [[AccountManager sharedManager] saveUserInfoData];
}

- (BOOL)canUpdateUserInfo {
    BOOL can = NO;
    if (self.nickName.length > 0 && self.company.length > 0 && self.department.length > 0 && self.position.length > 0) {
        can = YES;
    }
    return can;
}


#pragma mark
- (void)registerKeyboardNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)unRegisterKeyboardNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)addTapGesture {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapView:)];
    [self.view addGestureRecognizer:tapGesture];
}

- (void)didTapView:(UITapGestureRecognizer *)gesture {
    [self.view endEditing:YES];
}

#pragma mark - keyboard notification

- (void)keyboardWillShow:(NSNotification *)notification {
    NSDictionary* userInfo = [notification userInfo];
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    UIViewAnimationCurve animationCurve = [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] intValue];
    float animationDuration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    CGRect rect = [self.tableView convertRect:self.currentActivedTextField.frame fromView:self.currentActivedTextField];
    
    CGPoint offsetPoint = CGPointMake(0, CGRectGetMaxY(rect) + 10 - (CGRectGetHeight(self.tableView.frame) - keyboardSize.height));
    if (CGRectGetMaxY(rect) + 30 < ([UIScreen mainScreen].bounds.size.height - keyboardSize.height)) {
        offsetPoint.y = self.tableView.contentOffset.y;
    }
    if (offsetPoint.y < 0) {
        offsetPoint.y = 0;
    }
    //    CGRect frame = self.tableView.frame;
    UIEdgeInsets edges = self.tableView.contentInset;
    
    [UIView animateWithDuration:animationDuration delay:0 options:(UIViewAnimationOptions)animationCurve animations:^{
        self.tableView.contentInset = UIEdgeInsetsMake(edges.top, edges.left, keyboardSize.height, edges.right);
        [self.tableView setContentOffset:offsetPoint];
        //        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        ;
    }];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    NSDictionary* userInfo = [notification userInfo];
    //    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    UIViewAnimationCurve animationCurve = [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] intValue];
    float animationDuration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //    CGRect frame = self.tableView.frame;
    
    UIEdgeInsets edges = self.tableView.contentInset;
    
    [UIView animateWithDuration:animationDuration delay:0 options:(UIViewAnimationOptions)animationCurve animations:^{
        [self.tableView setContentOffset:CGPointMake(0, 0)];
        self.tableView.contentInset = UIEdgeInsetsMake(edges.top, edges.left, 0, edges.right);
        //        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        ;
    }];
}

#pragma mark - IBAction

- (IBAction)saveButtonClicked:(id)sender {
    if ([self canUpdateUserInfo]) {
        [self showLoadingWithText:@"修改中..."];
        [UserInfoRequest changeUserInfoWithNickname:self.nickName company:self.company department:self.department position:self.position code:0 success:^(BOOL status) {
            [self hideLoadingViewWithSuccess:@"修改成功"];
            [self updateLocalUserInfo];
        } failure:^(NSString *msg) {
            [self hideLoadingViewWithError:@"修改失败"];
        }];
    }
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

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.currentActivedTextField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.currentActivedTextField = nil;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == self.nickNameTextField) {
        self.nickName = self.nickNameTextField.text;
    } else if (textField == self.phoneTextField) {
        self.phone = self.phoneTextField.text;
    } else if (textField == self.emailTextField) {
        self.email = self.emailTextField.text;
    } else if (textField == self.companyTextField) {
        self.company = self.companyTextField.text;
    } else if (textField == self.positionTextField) {
        self.position = self.positionTextField.text;
    } else if (textField == self.companyTextField) {
        self.company = self.companyTextField.text;
    }
    return YES;
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
            cell.label.hidden = YES;
            cell.textField.hidden = NO;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            self.nickNameTextField = cell.textField;
            cell.textField.delegate = self;
            return cell;
        } else {
            TagSexSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:[TagSexSelectCell cellIdentifier] forIndexPath:indexPath];
            cell.tagLabel.text = @"性别";
            [cell.firstButton addTarget:self action:@selector(maleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [cell.secondButton addTarget:self action:@selector(femaleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];

            return cell;
            
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            TagLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:[TagLabelCell cellIdentifier] forIndexPath:indexPath];
            cell.tagLabel.text = @"手机号码";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.label.hidden = YES;
            cell.textField.hidden = NO;
            self.phoneTextField = cell.textField;
            cell.textField.delegate = self;

            return cell;
            
        } else {
            TagLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:[TagLabelCell cellIdentifier] forIndexPath:indexPath];
            cell.tagLabel.text = @"邮箱地址";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.label.hidden = YES;
            cell.textField.hidden = NO;
            self.emailTextField = cell.textField;
            cell.textField.delegate = self;

            return cell;
        }
    }
    else {
        if (indexPath.row == 0) {
            TagLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:[TagLabelCell cellIdentifier] forIndexPath:indexPath];
            cell.tagLabel.text = @"单位";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.label.hidden = YES;
            cell.textField.hidden = NO;
            self.companyTextField = cell.textField;
            cell.textField.delegate = self;

            
            return cell;
            
        } else if (indexPath.row == 1) {
            TagLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:[TagLabelCell cellIdentifier] forIndexPath:indexPath];
            cell.tagLabel.text = @"科室";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.label.hidden = YES;
            cell.textField.hidden = NO;
            self.departmentTextField = cell.textField;
            cell.textField.delegate = self;

            return cell;
        }
        else {
            TagLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:[TagLabelCell cellIdentifier] forIndexPath:indexPath];
            cell.tagLabel.text = @"职位";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.label.hidden = YES;
            cell.textField.hidden = NO;
            self.positionTextField = cell.textField;
            cell.textField.delegate = self;

            return cell;
        }
    }
    return nil;
}

@end
