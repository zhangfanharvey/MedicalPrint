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


@end

@implementation AddressEditController

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
    
    self.saveButton = [[UIButton alloc] init];
    [self.view addSubview:self.saveButton];
    
    [self setupViewConstraints];
    [self initNaviBarItem];
    
    [self.tableView registerClass:[TagLabelCell class] forCellReuseIdentifier:[TagLabelCell cellIdentifier]];
    [self.tableView registerClass:[TagSexSelectCell class] forCellReuseIdentifier:[TagSexSelectCell cellIdentifier]];
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
    [UserInfoRequest updateAddress:self.shipAddress success:^(BOOL status, ShippingAddress *shippingAddress) {
        ;
    } failure:^(NSString *msg) {
        ;
    }];
}

- (IBAction)maleButtonClicked:(id)sender{
    
}

- (IBAction)femaleButtonClicked:(id)sender {
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
        
    } else if (indexPath.row == 1) {
        TagSexSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:[TagSexSelectCell cellIdentifier] forIndexPath:indexPath];
        cell.tagLabel.text = @"性别";
        [cell.firstButton addTarget:self action:@selector(maleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [cell.secondButton addTarget:self action:@selector(maleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        if (self.sex) {
            [cell selectMale:YES];
        } else {
            [cell selectMale:NO];
        }
    } else if (indexPath.row == 2) {
        TagLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:[TagLabelCell cellIdentifier] forIndexPath:indexPath];
        cell.tagLabel.text = @"手机号码";
        cell.label.text = self.phone;
    } else if (indexPath.row == 3) {
        TagLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:[TagLabelCell cellIdentifier] forIndexPath:indexPath];
        cell.tagLabel.text = @"地区";
        cell.label.text = self.address;
    } else if (indexPath.row == 4) {
        TagLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:[TagLabelCell cellIdentifier] forIndexPath:indexPath];
        cell.tagLabel.text = @"地址";
        cell.label.text = self.address;
    }
    return nil;
}


@end
