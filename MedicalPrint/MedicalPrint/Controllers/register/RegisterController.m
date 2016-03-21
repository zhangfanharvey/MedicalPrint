//
//  RegisterController.m
//  MedicalPrint
//
//  Created by zhangfan on 16/3/18.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import "RegisterController.h"
#import "Masonry.h"
#import "UIImage+Resize.h"
#import "EdgeInputTextField.h"
#import "TagInputView.h"

#define kRegisterInputViewHeight    45

@interface RegisterController () <UITextFieldDelegate>

@property (nonatomic, strong) TagInputView *accountView;
@property (nonatomic, strong) TagInputView *passwordView;
@property (nonatomic, strong) TagInputView *comfirmPasswordView;
@property (nonatomic, strong) TagInputView *phoneNumberView;
@property (nonatomic, strong) TagInputView *codeView;
@property (nonatomic, strong) UIButton *resendCodeButton;

@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UIScrollView *containerView;
@property (nonatomic, strong) MASConstraint *keyboardConstraint;

@property (nonatomic, strong) UITextField *currentActivedTextField;

@end

@implementation RegisterController

- (void)dealloc {
    [self unRegisterKeyboardNotification];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.backgroundImageView = [[UIImageView alloc] init];
    self.backgroundImageView.image = [UIImage imageNamed:@"底图"];
    [self.view addSubview:self.backgroundImageView];
    
    self.containerView = [[UIScrollView alloc] init];
    self.containerView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.containerView];
    
    self.accountView = [[TagInputView alloc] init];
    self.accountView.tagLabel.text = @"账号";
    self.accountView.inputTextField.placeholder = @"";
    self.accountView.inputTextField.delegate = self;
    [self.containerView addSubview:self.accountView];
    
    self.passwordView = [[TagInputView alloc] init];
    self.passwordView.tagLabel.text = @"密码";
    self.passwordView.inputTextField.placeholder = @"";
    [self.containerView addSubview:self.passwordView];

    self.comfirmPasswordView = [[TagInputView alloc] init];
    self.comfirmPasswordView.tagLabel.text = @"确认密码";
    self.comfirmPasswordView.inputTextField.placeholder = @"";
    [self.containerView addSubview:self.comfirmPasswordView];

    self.phoneNumberView = [[TagInputView alloc] init];
    self.phoneNumberView.tagLabel.text = @"手机号码";
    self.phoneNumberView.inputTextField.placeholder = @"";
    [self.containerView addSubview:self.phoneNumberView];

    self.codeView = [[TagInputView alloc] init];
    self.codeView.tagLabel.text = @"验证码";
    self.codeView.inputTextField.placeholder = @"";
    [self.containerView addSubview:self.codeView];
    
    self.resendCodeButton = [[UIButton alloc] init];
    [self.resendCodeButton setTitle:@"登录" forState:UIControlStateNormal];
    [self.resendCodeButton addTarget:self action:@selector(resendCodeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.resendCodeButton setBackgroundImage:[[UIImage imageNamed:@"通用长按钮底_常态"] generalResizableImageWithCenter] forState:UIControlStateNormal];
    [self.resendCodeButton setBackgroundImage:[[UIImage imageNamed:@"通用长按钮底_按下"] generalResizableImageWithCenter] forState:UIControlStateHighlighted];
    [self.containerView addSubview:self.resendCodeButton];

    self.loginButton = [[UIButton alloc] init];
    [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginButton addTarget:self action:@selector(loginButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.loginButton setBackgroundImage:[[UIImage imageNamed:@"通用长按钮底_常态"] generalResizableImageWithCenter] forState:UIControlStateNormal];
    [self.loginButton setBackgroundImage:[[UIImage imageNamed:@"通用长按钮底_按下"] generalResizableImageWithCenter] forState:UIControlStateHighlighted];
    [self.containerView addSubview:self.loginButton];
    
    UIView *superView = self.view;
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(superView);
    }];
    
    CGFloat gap = 20;
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superView.mas_top).offset(0);
        self.keyboardConstraint = make.height.equalTo(superView);
        make.left.and.right.equalTo(superView);
    }];
    
    [self.accountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView.mas_left).offset(gap);
        make.top.equalTo(self.mas_topLayoutGuide).offset(15);
        make.right.equalTo(superView.mas_right).offset(-gap);
        make.height.equalTo(@kRegisterInputViewHeight);
    }];

    [self.passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView.mas_left).offset(gap);
        make.top.equalTo(self.accountView.mas_bottom).offset(15);
        make.right.equalTo(superView.mas_right).offset(-gap);
        make.height.equalTo(@kRegisterInputViewHeight);
    }];

    [self.comfirmPasswordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView.mas_left).offset(gap);
        make.top.equalTo(self.passwordView.mas_bottom).offset(15);
        make.right.equalTo(superView.mas_right).offset(-gap);
        make.height.equalTo(@kRegisterInputViewHeight);
    }];

    [self.phoneNumberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView.mas_left).offset(gap);
        make.top.equalTo(self.comfirmPasswordView.mas_bottom).offset(15);
        make.right.equalTo(superView.mas_right).offset(-gap);
        make.height.equalTo(@kRegisterInputViewHeight);
    }];

    [self.codeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView.mas_left).offset(gap);
        make.top.equalTo(self.phoneNumberView.mas_bottom).offset(15);
        make.right.equalTo(self.resendCodeButton.mas_left).offset(-gap);
        make.height.equalTo(@kRegisterInputViewHeight);
    }];
    
    [self.resendCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.codeView.mas_right).offset(gap);
        make.top.equalTo(self.phoneNumberView.mas_bottom).offset(gap);
        make.right.equalTo(superView.mas_right).offset(-gap);
        make.height.equalTo(@kRegisterInputViewHeight);
    }];
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.containerView.mas_left).offset(gap);
        make.right.equalTo(self.containerView.mas_right).offset(-gap);
        make.height.equalTo(@kRegisterInputViewHeight);
        make.top.equalTo(self.codeView.mas_bottom).offset(30);
    }];
    
    [self registerKeyboardNotification];
    [self addTapGesture];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    //    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction

- (IBAction)loginButtonClicked:(id)sender {
    
}

- (IBAction)resendCodeButtonClicked:(id)sender {
    
}

#pragma mark - private

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
    [self.view endEditing:YES];
}

#pragma mark - keyboard notification

- (void)keyboardWillShow:(NSNotification *)notification {
    NSDictionary* userInfo = [notification userInfo];
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    UIViewAnimationCurve animationCurve = [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] intValue];
    float animationDuration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
//    [self.keyboardConstraint setOffset:-30];
    CGRect rect = [self.containerView convertRect:self.currentActivedTextField.frame fromView:self.currentActivedTextField];
    
    self.keyboardConstraint.offset(-keyboardSize.height);

    [UIView animateWithDuration:animationDuration delay:0 options:(UIViewAnimationOptions)animationCurve animations:^{
        [self.containerView scrollRectToVisible:rect animated:YES];
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
    
    self.keyboardConstraint.offset(0);

    [UIView animateWithDuration:animationDuration delay:0 options:(UIViewAnimationOptions)animationCurve animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        ;
    }];
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.currentActivedTextField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.currentActivedTextField = nil;
}

@end
