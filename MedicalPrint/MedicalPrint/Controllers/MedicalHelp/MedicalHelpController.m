//
//  MedicalHelpController.m
//  MedicalPrint
//
//  Created by zhang fan on 3/27/16.
//  Copyright © 2016 Medical. All rights reserved.
//

#import "MedicalHelpController.h"
#import "MedicalHelpCollectionViewCell.h"
#import "UserInfoRequest.h"
#import "CaseType.h"
#import "Masonry.h"
#import "MedicalCaseListController.h"

@interface MedicalHelpController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) NSArray *caseTypeArray;

@end

@implementation MedicalHelpController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"病例求助";
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:@"" image:[[UIImage imageNamed:@"病理求助_常态"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"病理求助_按下"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
        tabBarItem.titlePositionAdjustment = UIOffsetMake(0, 50);
        self.tabBarItem = tabBarItem;

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.caseTypeArray = [[NSArray alloc] init];
    
    CGRect frame = self.view.bounds;
    self.layout = [[UICollectionViewFlowLayout alloc] init];
    self.layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.layout.minimumLineSpacing = 0;
    self.layout.minimumInteritemSpacing = 0;
    self.layout.itemSize = CGSizeMake(CGRectGetWidth(frame) / 2.0, 80);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerClass:[MedicalHelpCollectionViewCell class] forCellWithReuseIdentifier:[MedicalHelpCollectionViewCell cellIdentifier]];
    
    [self setupViewConstraints];
    
    [self loadCaseTypeList];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private

- (void)initNaviBarItem {
    self.title = @"发布求助";
}




- (void)setupViewConstraints {
    UIView *superView = self.view;
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(superView);
    }];
}

- (void)loadCaseTypeList {
    [self showLoadingWithText:@"加载中..."];
    [UserInfoRequest fetchListCaseTypeWithSuccess:^(BOOL status, NSArray *caseTypeArray) {
        [self hideLoadingView];
        self.caseTypeArray = caseTypeArray;
        [self.collectionView reloadData];
    } failure:^(NSString *msg) {
        [self hideLoadingViewWithError:msg];
    }];
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    CaseType *caseType = [self.caseTypeArray objectAtIndex:indexPath.row];
    MedicalCaseListController *medicalCaseListVC = [[MedicalCaseListController alloc] initWtithCaseType:caseType];
    [self.navigationController pushViewController:medicalCaseListVC animated:YES];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.caseTypeArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MedicalHelpCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[MedicalHelpCollectionViewCell cellIdentifier] forIndexPath:indexPath];
    CaseType *caseType = [self.caseTypeArray objectAtIndex:indexPath.row];
    [cell configureWithCaseType:caseType];
    return cell;
}

@end
