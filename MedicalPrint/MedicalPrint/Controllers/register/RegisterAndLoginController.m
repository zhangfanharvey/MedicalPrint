//
//  RegisterAndLoginController.m
//  MedicalPrint
//
//  Created by zhangfan on 16/3/18.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import "RegisterAndLoginController.h"
#import "Masonry.h"
#import "UIImage+Resize.h"
#import "LoginViewController.h"
#import "RegisterController.h"

@interface RegisterAndLoginController ()

@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UIButton *registerButton;
@property (nonatomic, strong) UIButton *loginButton;

@end

@implementation RegisterAndLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.backgroundImageView = [[UIImageView alloc] init];
    self.backgroundImageView.image = [UIImage imageNamed:@"底图"];
    [self.view addSubview:self.backgroundImageView];
    
    self.label = [[UILabel alloc] init];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.text = @"医用打印";
    self.label.backgroundColor = [UIColor greenColor];
    self.label.textColor = [UIColor whiteColor];
    self.label.font = [UIFont boldSystemFontOfSize:48.0f];
    [self.view addSubview:self.label];
    self.detailLabel = [[UILabel alloc] init];
    self.label.backgroundColor = [UIColor greenColor];
    self.detailLabel.text = @"test";
    self.detailLabel.textColor = [UIColor whiteColor];
    self.label.font = [UIFont boldSystemFontOfSize:40.0f];

    self.detailLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.detailLabel];
    
    self.registerButton = [[UIButton alloc] init];
//    [self.registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [self.registerButton addTarget:self action:@selector(loginButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [self.registerButton setBackgroundImage:[[UIImage imageNamed:@"登录按钮_常态"] generalResizableImageWithCenter] forState:UIControlStateNormal];
//    [self.registerButton setBackgroundImage:[[UIImage imageNamed:@"登录按钮_按下"] generalResizableImageWithCenter] forState:UIControlStateHighlighted];
    [self.registerButton setBackgroundImage:[UIImage imageNamed:@"登录按钮_常态"] forState:UIControlStateNormal];
    [self.registerButton setBackgroundImage:[UIImage imageNamed:@"登录按钮_按下"] forState:UIControlStateHighlighted];
    [self.view addSubview:self.registerButton];
    
    self.loginButton = [[UIButton alloc] init];
    [self.loginButton setTitle:@"注册" forState:UIControlStateNormal];
    [self.loginButton addTarget:self action:@selector(registerButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.loginButton setBackgroundImage:[[UIImage imageNamed:@"通用长按钮底_常态"] generalResizableImageWithCenter] forState:UIControlStateNormal];
    [self.loginButton setBackgroundImage:[[UIImage imageNamed:@"通用长按钮底_按下"] generalResizableImageWithCenter] forState:UIControlStateHighlighted];
    [self.view addSubview:self.loginButton];
    
    UIView *superView = self.view;
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(superView);
    }];
    
    CGFloat gap = 20;
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superView.mas_top).offset(80);
        make.left.equalTo(superView.mas_left).offset(gap);
        make.right.equalTo(superView.mas_right).offset(-gap);
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.label.mas_bottom).offset(15);
        make.left.equalTo(superView.mas_left).offset(gap);
        make.right.equalTo(superView.mas_right).offset(-gap);
    }];
    
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@235);
        make.centerX.equalTo(superView.mas_centerX);
        make.height.equalTo(@45);
        make.bottom.equalTo(self.loginButton.mas_top).offset(-15);
    }];
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@235);
        make.centerX.equalTo(superView.mas_centerX);
        make.height.equalTo(@45);
        make.bottom.equalTo(superView.mas_bottom).offset(-15);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIAction

- (IBAction)registerButtonClicked:(id)sender {
    RegisterController *registerVC = [[RegisterController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:registerVC];
    [self.navigationController presentViewController:nav animated:YES completion:nil];
}

- (IBAction)loginButtonClicked:(id)sender {
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
    [self.navigationController presentViewController:nav animated:YES completion:nil];
    //    [self.navigationController pushViewController:loginVC animated:YES];
}


@end
