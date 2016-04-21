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
#import "UserInfoRequest.h"
#import "AboutUsInfo.h"
#import "IconLabelTableViewCell.h"
#import "AccountManager.h"
#import "UIImageView+WebCache.h"
#import "AboutUsInfo.h"

@interface AboutViewController ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UITextView *aboutTextView;

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.imageView = [[UIImageView alloc] init];
    self.imageView.image = [UIImage imageNamed:@"广告大图"];
    [self.view addSubview:self.imageView];
    
    self.aboutTextView = [[UITextView alloc] init];
    self.aboutTextView.font = [UIFont systemFontOfSize:15];
//    self.aboutTextView
    self.aboutTextView.userInteractionEnabled = NO;
    self.aboutTextView.selectable = NO;
    self.aboutTextView.textColor = [UIColor colorWithRed:0.514 green:0.514 blue:0.514 alpha:1.00];
    [self.view addSubview:self.aboutTextView];
    
    [self setupViewConstraints];
    [self initNaviBarItem];
    
    
    [self initDataSource];
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
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(superView);
        make.height.equalTo(@315);
    }];
    
    [self.aboutTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.and.bottom.equalTo(superView).insets(UIEdgeInsetsMake(15, 15, 15, 15));
        make.top.equalTo(self.imageView.mas_bottom).offset(15);
    }];
}

#pragma mark - private

- (void)initNaviBarItem
{
    self.title = @"关于我们";
}

- (void)initDataSource {
    self.aboutTextView.text = @"中国数字骨科基金（DOF）由华裔科学会（CSOS），人骨研究会中国数字骨科基金, 中国数字骨科基金（DOF）由华裔科学会（CSOS），人骨研究会中国数字骨科基金, 中国数字骨科基金（DOF）由华裔科学会（CSOS），人骨研究会中国数字骨科基金, 中国数字骨科基金（DOF）由华裔科学会（CSOS），人骨研究会中国数字骨科基金, 中国数字骨科基金（DOF）由华裔科学会（CSOS），人骨研究会中国数字骨科基金, 中国数字骨科基金（DOF）由华裔科学会（CSOS），人骨研究会中国数字骨科基金, 中国数字骨科基金（DOF）由华裔科学会（CSOS），人骨研究会中国数字骨科基金, 中国数字骨科基金（DOF）由华裔科学会（CSOS），人骨研究会中国数字骨科基金,";
}

@end
