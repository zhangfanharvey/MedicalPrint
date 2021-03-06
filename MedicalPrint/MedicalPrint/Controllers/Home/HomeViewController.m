//
//  HomeViewController.m
//  MedicalPrint
//
//  Created by zhangfan on 16/3/22.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import "HomeViewController.h"
#import "BaseTableViewCell.h"
#import "Masonry.h"
#import "HomeTopHeadView.h"
#import "HomeNewsListCell.h"
#import "UserInfoRequest.h"
#import "MessageCenterController.h"
#import "SearchNewsController.h"
#import "NewsDetailController.h"
#import "NewsListController.h"
#import "NewsCaseTypeListController.h"
#import "Banner.h"
#import "SDCycleScrollView.h"
#import "WebViewController.h"

@interface HomeViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, HomeTopHeadViewDelegate, SDCycleScrollViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) HomeTopHeadView *topHeadView;

@property (nonatomic, strong) NSArray *newsTypeArray;
@property (nonatomic, strong) NSArray *newsListArray;
@property (nonatomic, strong) NSArray *bannerListArray;

@end

@implementation HomeViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"首页";
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:@"" image:[[UIImage imageNamed:@"首页_常态"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"首页_按下"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
        tabBarItem.titlePositionAdjustment = UIOffsetMake(0, 50);
        self.tabBarItem = tabBarItem;

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
    
    self.topHeadView = [[HomeTopHeadView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), [HomeTopHeadView heightForTopHeadView] + 120)];
    self.tableView.tableHeaderView = self.topHeadView;
    self.topHeadView.delegate = self;
    self.topHeadView.cycleScrollView.delegate = self;
    
    [self.topHeadView.rightButon addTarget:self action:@selector(moreButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.topHeadView configureDemoData];
    
    [self setupViewConstraints];
    [self initNaviBarItem];
    
    [self.tableView registerClass:[HomeNewsListCell class] forCellReuseIdentifier:[HomeNewsListCell cellIdentifier]];
    
    [self addSearchView];
    
    [self initDataSource];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
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
    [self initNavBarButtonItemWithImages:@[@"邮件ICON", @"邮件ICON_按下"] action:@selector(messageCenterButtonClicked:) isLeft:NO withBadge:nil];
}

- (void)initNavBarButtonItemWithImages:(NSArray *)imagesArray action:(SEL)selector isLeft:(BOOL)isLeft withBadge:(NSString *)badge
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (imagesArray && imagesArray.count > 0) {
        UIImage *image = [UIImage imageNamed:[imagesArray objectAtIndex:0]];
        [button setImage:image forState:UIControlStateNormal];
        button.frame = CGRectMake(0.0f, 0.0f, image.size.width, image.size.height);
    }
    if (imagesArray && imagesArray.count > 1) {
        [button setImage:[UIImage imageNamed:[imagesArray objectAtIndex:1]] forState:UIControlStateHighlighted];
    }
    if (imagesArray && imagesArray.count > 2) {
        [button setImage:[UIImage imageNamed:[imagesArray objectAtIndex:2]] forState:UIControlStateDisabled];
    }
    if (selector) {
        [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    }
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    if (isLeft) {
        self.navigationItem.leftBarButtonItem = barButtonItem;
    }
    else {
        button.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -9);
        self.navigationItem.rightBarButtonItem = barButtonItem;
    }
}

- (void)initDataSource {
    [UserInfoRequest fetchBannerListWithSuccess:^(BOOL status, NSArray *bannerListArray) {
        if (bannerListArray.count > 0) {
            self.bannerListArray = bannerListArray;
            NSMutableArray *imageUrlArray = [[NSMutableArray alloc] init];
            for (Banner *banner in bannerListArray) {
                [imageUrlArray addObject:banner.imgUrl];
            }
            [self.topHeadView configureWithAidImageUrl:imageUrlArray];
        }
    } failure:^(NSString *msg) {
        ;
    }];
    
    [UserInfoRequest fetchNewsTypeSuccess:^(BOOL status, NSArray *newsTypeArray) {
        self.newsTypeArray = [newsTypeArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            return [obj1 compare:obj2];
        }];
        [self.topHeadView configureNewsTypeWithList:self.newsTypeArray];
    } failure:^(NSString *msg) {
        ;
    }];
    [UserInfoRequest fetchMyNewsListStart:0 length:20 success:^(BOOL status, NSArray *newsArray) {
        self.newsListArray = newsArray;
        [self.tableView reloadData];
    } failure:^(NSString *msg) {
        ;
    }];
}

- (void)configureData {
    
}

- (void)addSearchView {
//    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(-5.0, 0.0, 320.0, 44.0)];
//    searchBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    UITextField *searchTextField = [[UITextField alloc] initWithFrame:CGRectZero];
    searchTextField.borderStyle = UITextBorderStyleRoundedRect;
    CGRect frame = self.view.bounds;
    UIView *searchBarView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, CGRectGetWidth(frame) - 40, 38.0)];
    searchBarView.autoresizingMask = 0;
//    searchBar.delegate = self;
    
    [searchBarView addSubview:searchTextField];
    
    UIButton *button = [[UIButton alloc] init];
    [button addTarget:self action:@selector(searchButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [searchBarView addSubview:button];

    self.navigationItem.titleView = searchBarView;
    [searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(searchBarView.mas_left).offset(4);
        make.right.equalTo(searchBarView.mas_right).offset(-4);
        make.height.equalTo(@32);
        make.bottom.equalTo(searchBarView.mas_bottom).offset(-3);
    }];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(searchTextField);
    }];

}

#pragma mark - IBAction

- (IBAction)messageCenterButtonClicked:(id)sender {
    MessageCenterController *messageCenterVC = [[MessageCenterController alloc] init];
    [self.navigationController pushViewController:messageCenterVC animated:YES];
}

- (IBAction)searchButtonClicked:(id)sender {
    SearchNewsController *searchNewsVC = [[SearchNewsController alloc] init];
    [self.navigationController pushViewController:searchNewsVC animated:YES];
}

- (IBAction)moreButtonClicked:(id)sender {
    NewsCaseTypeListController *caseTypeListVC = [[NewsCaseTypeListController alloc] initWithCaseTypeArray:self.newsTypeArray];
    [self.navigationController pushViewController:caseTypeListVC animated:YES];
}

#pragma mark - HomeTopHeadViewDelegate

- (void)homeTopHeadView:(HomeTopHeadView *)topHeadView didSelectCaseTypeItemAtIndex:(NSInteger)index {
    NewsType *newsType = [self.newsTypeArray objectAtIndex:index];
    NewsListController *newsListVC = [[NewsListController alloc] initWithCaseType:newsType];
    [self.navigationController pushViewController:newsListVC animated:YES];
}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    Banner *banner = [self.bannerListArray objectAtIndex:index];
    WebViewController *webVC = [[WebViewController alloc] initWithWebUrl:[banner bannerDetailUrl] title:banner.title];
    [self.navigationController pushViewController:webVC animated:YES];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 72.0f;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 0.0001f;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 0.0001f;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    News *news = [self.newsListArray objectAtIndex:indexPath.row];
    NewsDetailController *newsDetailVC = [[NewsDetailController alloc] initWithNews:news];
    [self.navigationController pushViewController:newsDetailVC animated:YES];
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


@end
