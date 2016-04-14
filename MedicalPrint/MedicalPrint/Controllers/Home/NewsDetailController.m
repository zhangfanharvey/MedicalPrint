//
//  NewsDetailController.m
//  MedicalPrint
//
//  Created by zhangfan on 16/4/12.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import "NewsDetailController.h"
#import "Masonry.h"
#import "News.h"
#import "AccountManager.h"

@interface NewsDetailController ()

@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, strong) News *news;

@end

@implementation NewsDetailController

- (instancetype)initWithNews:(News *)news {
    self = [self init];
    if (self) {
        self.news = news;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[AccountManager sharedManager] updateCookie];
    
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.webView];
    self.webView.scalesPageToFit = YES;
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[self.news newsDetailUrl]]]];
    
    
    [self setupViewConstraints];
    
    [self initNaviBarItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private

- (void)initNaviBarItem {
    self.title = self.news.title;
}


- (void)setupViewConstraints {
    UIView *superView = self.view;
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(superView);
    }];
}

@end
