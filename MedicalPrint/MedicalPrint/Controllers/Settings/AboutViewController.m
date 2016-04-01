//
//  AbountViewController.m
//  MedicalPrint
//
//  Created by zhangfan on 16/3/22.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import "AboutViewController.h"
#import "BaseTableViewCell.h"
#import "Masonry.h"
#import "UIImage+MDQRCode.h"
#import "UserInfoRequest.h"
#import "AboutUsInfo.h"
#import "IconLabelTableViewCell.h"
#import "AccountManager.h"
#import "UIImageView+WebCache.h"
#import "AboutUsInfo.h"

@interface AboutViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) AboutUsInfo *aboutUsInfo;

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self setupViewConstraints];
    [self initNaviBarItem];
    
    [self initDataSource];
    
    [self.tableView registerClass:[IconLabelTableViewCell class] forCellReuseIdentifier:[IconLabelTableViewCell cellIdentifier]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
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
    self.title = @"联系我们";
}

- (void)initDataSource {
    [UserInfoRequest fetchAboutUsWithSuccess:^(BOOL status, AboutUsInfo *aboutUsInfo) {
        self.aboutUsInfo = aboutUsInfo;
        [self.tableView reloadData];
    } failure:^(NSString *msg) {
        ;
    }];
}

- (void)configureData {
    
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
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 3;
    }
    return 1;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IconLabelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[IconLabelTableViewCell cellIdentifier] forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSString *iconName = @"";
    NSString *name = @"";
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            iconName = @"联系电话";
            name = [NSString stringWithFormat:@"%@%@", @"联系电话:", self.aboutUsInfo.phoneNumber];
        } else if (indexPath.row == 1) {
            iconName = @"公司传真";
            name = [NSString stringWithFormat:@"%@%@", @"公司传真:", self.aboutUsInfo.fax];
//            name = @"公司传真";
        } else if (indexPath.row) {
            iconName = @"邮箱地址";
            name = self.aboutUsInfo.email;
        }
    } else {
        iconName = @"公司地址";
        name = self.aboutUsInfo.address;
    }
    cell.iconImageView.image = [UIImage imageNamed:iconName];
    cell.label.text = name;
    return cell;
}

@end
