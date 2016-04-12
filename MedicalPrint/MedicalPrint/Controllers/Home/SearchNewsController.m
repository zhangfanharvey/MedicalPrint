//
//  SearchNewsController.m
//  MedicalPrint
//
//  Created by zhangfan on 16/4/11.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import "SearchNewsController.h"
#import "BaseTableViewCell.h"
#import "Masonry.h"
#import "HomeTopHeadView.h"
#import "HomeNewsListCell.h"
#import "UserInfoRequest.h"
#import "MessageCenterController.h"
#import "MLPAutoCompleteTextField.h"


@interface SearchNewsController () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, MLPAutoCompleteTextFieldDataSource, MLPAutoCompleteTextFieldDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) MLPAutoCompleteTextField *searchTextField;
@property (nonatomic, strong) NSMutableArray *newsListArray;
@property (nonatomic, strong) UIView *myNavBarView;

@end

@implementation SearchNewsController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.newsListArray = [[NSMutableArray alloc] init];
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
    
    
    [self setupViewConstraints];
    [self initNaviBarItem];
    
    [self.tableView registerClass:[BaseTableViewCell class] forCellReuseIdentifier:[BaseTableViewCell cellIdentifier]];
    
    [self addSearchView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
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
    [self initNavBarButtonItemWithTitle:@"搜索" action:@selector(searchButtonClicked:) isLeft:NO];
}

- (void)addSearchView {
    [self createNavBar];
    
    UIView *superView = self.view;

    self.searchTextField = [[MLPAutoCompleteTextField alloc] initWithFrame:CGRectZero];
    self.searchTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.searchTextField.returnKeyType = UIReturnKeySearch;
    self.searchTextField.delegate = self;
    self.searchTextField.autoCompleteDataSource = self;
    self.searchTextField.autoCompleteDelegate = self;
    self.searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.searchTextField.showAutoCompleteTableWhenEditingBegins = YES;
//    CGRect frame = self.view.bounds;
//    UIView *searchBarView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, CGRectGetWidth(frame) - 40, 38.0)];
//    searchBarView.autoresizingMask = 0;
//        searchBar.delegate = self;
    
    [self.view addSubview:self.searchTextField];
    
//    self.navigationItem.titleView = searchBarView;
//    [self.view addSubview:searchBarView];
    
//    [self.searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(searchBarView.mas_left).offset(4);
//        make.right.equalTo(searchBarView.mas_right).offset(-4);
//        make.height.equalTo(@32);
//        make.bottom.equalTo(searchBarView.mas_bottom).offset(-3);
//    }];
    
    [self.searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superView.mas_top).offset(23);
        //        make.left.and.right.equalTo(superView);
        make.left.equalTo(superView.mas_left).offset(44);
        make.right.equalTo(superView.mas_right).offset(-44);
        make.height.equalTo(@32);
    }];
    
//    [searchBarView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(superView.mas_top).offset(20);
////        make.left.and.right.equalTo(superView);
//        make.left.equalTo(superView.mas_left).offset(44);
//        make.right.equalTo(superView.mas_right).offset(-40);
//        make.height.equalTo(@44);
//    }];
}

- (void)createNavBar {
    UIView *superView = self.view;
    
    UIView *myNavBarView = [[UIView alloc] init];
    [self.view addSubview:myNavBarView];
    myNavBarView.backgroundColor = [UIColor colorWithRed:0.031 green:0.765 blue:0.945 alpha:1.00];
    self.myNavBarView = myNavBarView;
    
    UIButton *backButton = [[UIButton alloc] init];
    [backButton setImage:[UIImage imageNamed:@"顶部撤回键"] forState:UIControlStateNormal];
//    backButton addTarget:self action:@selector(backbuttonc) forControlEvents:<#(UIControlEvents)#>
    [myNavBarView addSubview:backButton];
    
    UIButton *searchButton = [[UIButton alloc] init];
    [searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(searchButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [myNavBarView addSubview:searchButton];
    
    [self.myNavBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.and.right.equalTo(superView);
        make.height.equalTo(@64);
    }];
    
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(myNavBarView.mas_left);
        make.bottom.equalTo(myNavBarView.mas_bottom);
        make.height.equalTo(@45);
        make.width.equalTo(@40);
    }];
    
    [searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(myNavBarView.mas_right);
        make.bottom.equalTo(myNavBarView.mas_bottom);
        make.height.equalTo(@45);
        make.width.equalTo(@40);
    }];

    
}

#pragma mark - IBAction

- (IBAction)searchButtonClicked:(id)sender {
    if (self.searchTextField.text.length > 0) {
        [self showLoadingWithText:@"加载中..."];
        [UserInfoRequest searchHomePageNewsWithText:self.searchTextField.text success:^(BOOL status, NSArray *newsArray) {
            [self hideLoadingView];
        } failure:^(NSString *msg) {
            [self hideLoadingViewWithError:@"搜索失败"];
        }];
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 72.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.newsListArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeNewsListCell *cell = [tableView dequeueReusableCellWithIdentifier:[HomeNewsListCell cellIdentifier] forIndexPath:indexPath];
    News *news = [self.newsListArray objectAtIndex:indexPath.row];
    [cell configureWithNews:news];
    //    cell.newsImageView.image = [UIImage imageNamed:@"广告小图"];
    //    cell.titleLabel.text = @"test";
    //    cell.detailLabel.text = @"test";
    return cell;
}


#pragma mark - UITextFieldDelegate


#pragma mark - MLPAutoCompleteTextFieldDataSource

#pragma mark - MLPAutoCompleteTextFieldDelegate

- (void)autoCompleteTextField:(MLPAutoCompleteTextField *)textField
 possibleCompletionsForString:(NSString *)string
            completionHandler:(void(^)(NSArray *suggestions))handler {
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < 4; ++i) {
        [resultArray addObject:@"fdsaf"];

    }
    handler(resultArray);
    return;

}

- (NSArray *)autoCompleteTextField:(MLPAutoCompleteTextField *)textField
      possibleCompletionsForString:(NSString *)string {
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    
    return resultArray;
}

@end
