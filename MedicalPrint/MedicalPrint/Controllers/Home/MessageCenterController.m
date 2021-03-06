//
//  MessageCenterController.m
//  MedicalPrint
//
//  Created by zhangfan on 16/3/23.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import "MessageCenterController.h"
#import "BaseTableViewCell.h"
#import "Masonry.h"
#import "MessageCenterCell.h"
#import "UserInfoRequest.h"
#import "Message.h"

@interface MessageCenterController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *messageArray;

@end

@implementation MessageCenterController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.messageArray = [[NSMutableArray alloc] init];
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
    
    [self.tableView registerClass:[MessageCenterCell class] forCellReuseIdentifier:[MessageCenterCell cellIdentifier]];
    
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
    self.title = @"消息中心";
}

- (void)initDataSource {
    [self showLoadingWithText:@"加载中..."];
    [UserInfoRequest fetchMessageWithStart:0 length:20 success:^(BOOL status, NSArray *messagesArray) {
        [self hideLoadingView];
        [self.messageArray addObjectsFromArray:messagesArray];
        [self.tableView reloadData];
        if (self.messageArray.count == 0) {
            [self showNoResultPrompt];
        }
    } failure:^(NSString *msg) {
        [self hideLoadingViewWithError:@"加载失败"];
    }];
}

#pragma mark - IBAction



#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messageArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:[MessageCenterCell cellIdentifier] forIndexPath:indexPath];
    Message *message = [self.messageArray objectAtIndex:indexPath.row];
    [cell configureWithMessage:message];
    return cell;
}


@end
