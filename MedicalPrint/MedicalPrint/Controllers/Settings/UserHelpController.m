//
//  UserHelpController.m
//  MedicalPrint
//
//  Created by zhangfan on 16/4/13.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import "UserHelpController.h"
#import "Masonry.h"
#import "News.h"
#import "AccountManager.h"


@interface UserHelpController ()

@property (nonatomic, strong) UIWebView *webView;


@end

@implementation UserHelpController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[AccountManager sharedManager] updateCookie];
    
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.webView];
    self.webView.scalesPageToFit = YES;
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"www.baidu.com"]]];
    
    
    [self setupViewConstraints];
    
    [self initNaviBarItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private

- (void)initNaviBarItem {
    self.title = @"使用帮助";
}


- (void)setupViewConstraints {
    UIView *superView = self.view;
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(superView);
    }];
}

@end
