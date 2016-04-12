//
//  AddressEditController.m
//  MedicalPrint
//
//  Created by zhangfan on 16/4/6.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import "AddressEditController.h"
#import "BaseTableViewCell.h"
#import "Masonry.h"
#import "UserInfoRequest.h"
#import "AddressManagerCell.h"
#import "ShippingAddress.h"
#import "SVPullToRefresh.h"
#import "TagLabelCell.h"
#import "TagSexSelectCell.h"

@interface AddressEditController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *saveButton;

@property (nonatomic, strong) ShippingAddress *shipAddress;

@property (nonatomic, strong) NSNumber *memberId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger sex;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *address;

@property (nonatomic, strong) UITextField *currentActivedTextField;


@end

@implementation AddressEditController

- (void)dealloc {
    [self unRegisterKeyboardNotification];
}

- (instancetype)initWithAddress:(ShippingAddress *)address {
    self = [self init];
    if (self) {
        self.shipAddress = address;
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
    
    self.saveButton = [[UIButton alloc] init];
    [self.saveButton setBackgroundImage:[UIImage imageNamed:@"通用长按钮底_常态"] forState:UIControlStateNormal];
    [self.saveButton setBackgroundImage:[UIImage imageNamed:@"通用长按钮底_按下"] forState:UIControlStateHighlighted];
    [self.saveButton setTitle:@"保存" forState:UIControlStateNormal];
    [self.view addSubview:self.saveButton];
    
    [self setupViewConstraints];
    [self initNaviBarItem];
    
    [self.tableView registerClass:[TagLabelCell class] forCellReuseIdentifier:[TagLabelCell cellIdentifier]];
    [self.tableView registerClass:[TagSexSelectCell class] forCellReuseIdentifier:[TagSexSelectCell cellIdentifier]];
    
    [self registerKeyboardNotification];
    [self addTapGesture];
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
}

#pragma mark - private

- (void)initNaviBarItem
{
    self.title = @"地址管理";
    [self initNavBarButtonItemWithImages:@[@"顶部撤回键"] action:@selector(backButtonClicked:) isLeft:YES];

}

/*
 @property (nonatomic, strong) NSString *name;
 @property (nonatomic, assign) NSInteger sex;
 @property (nonatomic, strong) NSString *phone;
 @property (nonatomic, strong) NSString *address;
*/

- (void)configureTempData {
    if (self.shipAddress) {
        self.name = self.shipAddress.name;
        self.sex = self.shipAddress.sex;
        self.phone = self.shipAddress.phone;
        self.address = self.shipAddress.address;
    }
}

#pragma mark - IBAction

- (IBAction)saveButtonClicked:(id)sender {
    if (self.shipAddress) {
        [UserInfoRequest updateAddress:self.shipAddress success:^(BOOL status, ShippingAddress *shippingAddress) {
            ;
        } failure:^(NSString *msg) {
            ;
        }];
    }
}

- (IBAction)maleButtonClicked:(id)sender{
    TagSexSelectCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    [cell selectMale:YES];
    
}

- (IBAction)femaleButtonClicked:(id)sender {
    TagSexSelectCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    [cell selectMale:NO];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45.0f;
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
    return 5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        TagLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:[TagLabelCell cellIdentifier] forIndexPath:indexPath];
        cell.tagLabel.text = @"真实姓名";
        cell.label.text = self.name;
        cell.label.hidden = YES;
        cell.textField.hidden = NO;
        return cell;
        
    } else if (indexPath.row == 1) {
        TagSexSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:[TagSexSelectCell cellIdentifier] forIndexPath:indexPath];
        cell.tagLabel.text = @"性别";
        [cell.firstButton addTarget:self action:@selector(maleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [cell.secondButton addTarget:self action:@selector(femaleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        if (self.sex) {
            [cell selectMale:YES];
        } else {
            [cell selectMale:NO];
        }
        return cell;
    } else if (indexPath.row == 2) {
        TagLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:[TagLabelCell cellIdentifier] forIndexPath:indexPath];
        cell.tagLabel.text = @"手机号码";
        cell.label.text = self.phone;
        cell.label.hidden = YES;
        cell.textField.hidden = NO;
        return cell;
    } else if (indexPath.row == 3) {
        TagLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:[TagLabelCell cellIdentifier] forIndexPath:indexPath];
        cell.tagLabel.text = @"地区";
        cell.label.text = self.address;
        cell.label.hidden = YES;
        cell.textField.hidden = NO;
        return cell;
    } else if (indexPath.row == 4) {
        TagLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:[TagLabelCell cellIdentifier] forIndexPath:indexPath];
        cell.tagLabel.text = @"地址";
        cell.label.text = self.address;
        cell.label.hidden = YES;
        cell.textField.hidden = NO;
        return cell;
    }
    return nil;
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

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.currentActivedTextField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.currentActivedTextField = nil;
}



@end
