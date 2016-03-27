//
//  LoginViewController.m
//  MedicalPrint
//
//  Created by zhangfan on 16/3/18.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import "LoginViewController.h"
#import "Masonry.h"
#import "UIImage+Resize.h"
#import "EdgeInputTextField.h"
#import "FindPasswordController.h"
#import "UserInfoRequest.h"
#import "AppDelegate.h"

@interface LoginViewController ()

@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) EdgeInputTextField *phoneNumberTextField;
@property (nonatomic, strong) EdgeInputTextField *passwordTextField;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) MASConstraint *keyboardConstraint;
@property (nonatomic, strong) UIButton *findPasswordButton;


@end

@implementation LoginViewController

- (void)dealloc {
    [self unRegisterKeyboardNotification];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.backgroundImageView = [[UIImageView alloc] init];
    self.backgroundImageView.image = [UIImage imageNamed:@"底图"];
    [self.view addSubview:self.backgroundImageView];
    
    self.containerView = [[UIView alloc] init];
    self.containerView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.containerView];

    self.phoneNumberTextField = [[EdgeInputTextField alloc] init];
    self.phoneNumberTextField.placeholder = @"请输入账号";
    [self.phoneNumberTextField setBackground:[[UIImage imageNamed:@"注册界面输入框1"] generalResizableImageWithCenter]];
    [self.containerView addSubview:self.phoneNumberTextField];
    
    self.passwordTextField = [[EdgeInputTextField alloc] init];
    self.passwordTextField.placeholder = @"请输入密码";
    self.passwordTextField.secureTextEntry = YES;
    [self.passwordTextField setBackground:[[UIImage imageNamed:@"注册界面输入框1"] generalResizableImageWithCenter]];
    [self.containerView addSubview:self.passwordTextField];
    
    
    self.loginButton = [[UIButton alloc] init];
    [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginButton addTarget:self action:@selector(loginButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.loginButton setBackgroundImage:[[UIImage imageNamed:@"通用长按钮底_常态"] generalResizableImageWithCenter] forState:UIControlStateNormal];
    [self.loginButton setBackgroundImage:[[UIImage imageNamed:@"通用长按钮底_按下"] generalResizableImageWithCenter] forState:UIControlStateHighlighted];
    [self.containerView addSubview:self.loginButton];
    
    self.findPasswordButton = [[UIButton alloc] init];
    [self.findPasswordButton setTitle:@"找回密码" forState:UIControlStateNormal];
    [self.findPasswordButton addTarget:self action:@selector(findPasswordButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.containerView addSubview:self.findPasswordButton];

    
    UIView *superView = self.view;
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(superView);
    }];
    
    
    CGFloat gap = 20;
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        self.keyboardConstraint = make.top.equalTo(superView.mas_top).offset(0);
        make.left.right.and.bottom.equalTo(superView);
    }];
    
    [self.phoneNumberTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.containerView.mas_left).offset(gap);
        make.right.equalTo(self.containerView.mas_right).offset(-gap);
        make.top.equalTo(self.mas_topLayoutGuide).offset(30);
        make.height.equalTo(@45);
    }];
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.containerView.mas_left).offset(gap);
        make.right.equalTo(self.containerView.mas_right).offset(-gap);
        make.top.equalTo(self.phoneNumberTextField.mas_bottom).offset(30);
        make.height.equalTo(@45);
    }];
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.containerView.mas_left).offset(gap);
        make.right.equalTo(self.containerView.mas_right).offset(-gap);
        make.height.equalTo(@45);
        make.top.equalTo(self.passwordTextField.mas_bottom).offset(30);
    }];
    
    [self.findPasswordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(superView.mas_centerX);
        make.height.equalTo(@(45));
        make.width.equalTo(@150);
        make.bottom.equalTo(superView.mas_bottom).offset(-30);
    }];
    
    [self registerKeyboardNotification];
    [self addTapGesture];
    
    [self initNaviBarItem];

}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    //    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction

- (IBAction)loginButtonClicked:(id)sender {
    [self.view endEditing:YES];
    if (self.phoneNumberTextField.text.length > 0 && self.passwordTextField.text.length > 0) {
        [self showLoadingWithText:@"加载中..." toView:self.navigationController.view];
        [UserInfoRequest loginWithAccount:self.phoneNumberTextField.text passwork:self.passwordTextField.text withSuccess:^(User *user, BOOL loginStatus) {
            [self hideLoadingView];
            [self showMainView];
        } failure:^(NSString *msg) {
            [self hideLoadingViewWithError:msg];
        }];
    }
}


- (IBAction)findPasswordButtonClicked:(id)sender {
    FindPasswordController *findPasswordVC = [[FindPasswordController alloc] init];
    [self.navigationController pushViewController:findPasswordVC animated:YES];

}

- (IBAction)cancelButtonClicked:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - private

- (void)showMainView {
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate showHomeView];
}

- (void)initNaviBarItem {
    self.title = @"用户登录";
//    [self initNavBarButtonItemWithTitle:@"取消" action:@selector(cancelButtonClicked:) isLeft:YES];
}


- (void)registerKeyboardNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)unRegisterKeyboardNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)addTapGesture {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapView:)];
    [self.view addGestureRecognizer:tapGesture];
}

- (void)didTapView:(UITapGestureRecognizer *)gesture {
    if (self.phoneNumberTextField.isFirstResponder || self.passwordTextField.isFirstResponder) {
        [self.view endEditing:YES];
    }
}

#pragma mark - keyboard notification

- (void)keyboardWillShow:(NSNotification *)notification {
    NSDictionary* userInfo = [notification userInfo];
    //    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    UIViewAnimationCurve animationCurve = [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] intValue];
    float animationDuration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [self.keyboardConstraint setOffset:-30];
    
    [UIView animateWithDuration:animationDuration delay:0 options:(UIViewAnimationOptions)animationCurve animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        ;
    }];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    NSDictionary* userInfo = [notification userInfo];
    //    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    UIViewAnimationCurve animationCurve = [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] intValue];
    float animationDuration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:animationDuration delay:0 options:(UIViewAnimationOptions)animationCurve animations:^{
        [self.keyboardConstraint setOffset:0];
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        ;
    }];
}



@end
