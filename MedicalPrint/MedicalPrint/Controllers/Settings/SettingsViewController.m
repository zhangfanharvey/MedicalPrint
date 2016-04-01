//
//  SettingsViewController.m
//  MedicalPrint
//
//  Created by zhangfan on 16/3/22.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import "SettingsViewController.h"
#import "BaseTableViewCell.h"
#import "Masonry.h"
#import "UserInfoRequest.h"
#import "YNBaseSwitchTableViewCell.h"
#import "TagLabelCell.h"
#import "YNBaseInfoTableViewCell.h"
#import "AboutViewController.h"
#import "FeedbackViewController.h"
#import "ContactUsController.h"
#import "SDImageCache.h"

@interface SettingsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSUInteger cacheSize;

@end

@implementation SettingsViewController

- (void)dealloc {
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"更多";
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:@"更多" image:[[UIImage imageNamed:@"更多_常态"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"更多_按下"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        tabBarItem.imageInsets = UIEdgeInsetsMake(7, 0, -7, 0);
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
    
    [self setupViewConstraints];
    [self initNaviBarItem];
    
    [self.tableView registerClass:[YNBaseSwitchTableViewCell class] forCellReuseIdentifier:[YNBaseSwitchTableViewCell cellIdentifier]];
    [self.tableView registerClass:[TagLabelCell class] forCellReuseIdentifier:[TagLabelCell cellIdentifier]];
    [self.tableView registerClass:[YNBaseInfoTableViewCell class] forCellReuseIdentifier:[YNBaseInfoTableViewCell cellIdentifier]];
    
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
    self.title = @"设置";
}

- (void)initDataSource {
    [[SDImageCache sharedImageCache] calculateSizeWithCompletionBlock:^(NSUInteger fileCount, NSUInteger totalSize) {
        self.cacheSize = totalSize;
        [self.tableView reloadData];
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
    if (section > 0) {
        return 20.0f;
    } else {
        return 0.0001f;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0001f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            ContactUsController *contactUsVC = [[ContactUsController alloc] init];
            [self.navigationController pushViewController:contactUsVC animated:YES];
        } else {
            AboutViewController *abountUsVC = [[AboutViewController alloc] init];
            [self.navigationController pushViewController:abountUsVC animated:YES];
        }
        
    } else {
        if (indexPath.row == 0) {
        } else if (indexPath.row == 1) {
        } else {
        }
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger number = 0;
    if (section == 0) {
        number = 1;
    } else if (section == 1) {
        number = 2;
    } else if (section == 2) {
        number = 2;
    }
    return number;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        YNBaseSwitchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[YNBaseSwitchTableViewCell cellIdentifier] forIndexPath:indexPath];
        cell.tagLabel.text = @"信息推送";
        return cell;
    } else if (indexPath.section == 1) {
        YNBaseInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[YNBaseInfoTableViewCell cellIdentifier] forIndexPath:indexPath];
        if (indexPath.row == 0) {
            cell.infoLabel.text = @"联系我们";
        } else {
            cell.infoLabel.text = @"关于我们";
        }
        return cell;

    } else {
        if (indexPath.row == 0) {
            TagLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:[TagLabelCell cellIdentifier] forIndexPath:indexPath];
            cell.tagLabel.text = @"清理缓存";
            NSString *fileSizeStr = [NSByteCountFormatter stringFromByteCount:self.cacheSize countStyle:NSByteCountFormatterCountStyleFile];
            cell.label.text = fileSizeStr;
            return cell;
        } else if (indexPath.row == 1) {
            TagLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:[TagLabelCell cellIdentifier] forIndexPath:indexPath];
            cell.tagLabel.text = @"使用帮助";
            cell.label.text = @"";
            return cell;
        } else {
            TagLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:[TagLabelCell cellIdentifier] forIndexPath:indexPath];
            cell.tagLabel.text = @"";
            return cell;
        }
    }
    
    return nil;
}


@end
