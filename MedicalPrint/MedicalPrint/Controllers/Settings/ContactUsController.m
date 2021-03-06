//
//  ContactUsController.m
//  MedicalPrint
//
//  Created by zhangfan on 16/3/23.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import "ContactUsController.h"
#import "BaseTableViewCell.h"
#import "Masonry.h"
#import "UserInfoRequest.h"
#import "AboutUsInfo.h"
#import "IconLabelTableViewCell.h"
#import "AccountManager.h"
#import "UIImageView+WebCache.h"
#import "AboutUsInfo.h"
#import "BarcodeView.h"

@interface ContactUsController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) AboutUsInfo *aboutUsInfo;
@property (nonatomic, strong) BarcodeView *barcodeView;

@end

@implementation ContactUsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorInset = UIEdgeInsetsZero;
    [self.view addSubview:self.tableView];
    
    [self setupViewConstraints];
    [self initNaviBarItem];
    
    [self createBarcodeView];
    
    [self configureData];
    
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
    self.barcodeView.barcodeImageView.image = [UIImage imageNamed:@"二维码"];
    
}

- (void)createBarcodeView {
    BarcodeView *barcodeView = [[BarcodeView alloc] init];
    self.barcodeView = barcodeView;
    [self.view addSubview:barcodeView];
    
    CGFloat bottomHeight = [self bottomViewHeight];
    UIView *superView = self.view;
    [self.barcodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.and.bottom.equalTo(superView);
        make.height.equalTo(@(bottomHeight));
    }];
}

- (CGFloat)bottomViewHeight {
    CGFloat height = 180;
    height = self.view.bounds.size.height - 5 * 45.0f - 84;
    
    return height;
}

#pragma mark - IBAction



#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 1 && indexPath.row == 1) {
        return [self bottomViewHeight];
    }
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

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 3;
    }
    return 2;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IconLabelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[IconLabelTableViewCell cellIdentifier] forIndexPath:indexPath];
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
        if (indexPath.row == 0) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            iconName = @"公司地址";
            name = self.aboutUsInfo.address;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    cell.iconImageView.image = [UIImage imageNamed:iconName];
    cell.label.text = name;
    return cell;
}


@end
