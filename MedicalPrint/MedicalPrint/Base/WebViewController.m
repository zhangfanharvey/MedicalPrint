//
//  WebViewController.m
//  MedicalPrint
//
//  Created by zhangfan on 16/5/9.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import "WebViewController.h"
#import "Masonry.h"
#import "AccountManager.h"

@interface WebViewController ()

@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, strong) NSString *url;

@end

@implementation WebViewController

- (instancetype)initWithWebUrl:(NSString *)url title:(NSString *)title {
    self = [self init];
    if (self) {
        self.url = url;
        self.title = title;
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
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    
    [self setupViewConstraints];
    
    [self initNaviBarItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private

- (void)initNaviBarItem {
//    self.title = self.news.title;
}


- (void)setupViewConstraints {
    UIView *superView = self.view;
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(superView);
    }];
}


@end
