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
#import "UserInfoRequest.h"
#import "AppDelegate.h"

#define kRegisterInputViewHeight    45

@interface RegisterController () <UITextFieldDelegate>

@property (nonatomic, strong) TagInputView *accountView;
@property (nonatomic, strong) TagInputView *passwordView;
@property (nonatomic, strong) TagInputView *comfirmPasswordView;
@property (nonatomic, strong) TagInputView *phoneNumberView;
@property (nonatomic, strong) TagInputView *codeView;
@property (nonatomic, strong) UIButton *resendCodeButton;

@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIButton *registerButton;
@property (nonatomic, strong) UIScrollView *containerScrollView;
@property (nonatomic, strong) UIView *containerView;

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
    
    self.containerScrollView = [[UIScrollView alloc] init];
    self.containerScrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.containerScrollView];
    
    self.containerView = [[UIView alloc] init];
//    self.containerView.backgroundColor = [UIColor redColor];
    [self.containerScrollView addSubview:self.containerView];
    
    self.accountView = [[TagInputView alloc] init];
    self.accountView.tagLabel.text = @"账号";
    self.accountView.inputTextField.placeholder = @"";
    self.accountView.inputTextField.delegate = self;
    [self.containerView addSubview:self.accountView];
    
    self.passwordView = [[TagInputView alloc] init];
    self.passwordView.tagLabel.text = @"密码";
    self.passwordView.inputTextField.placeholder = @"";
    self.passwordView.inputTextField.secureTextEntry = YES;
    self.passwordView.inputTextField.delegate = self;
    [self.containerView addSubview:self.passwordView];

    self.comfirmPasswordView = [[TagInputView alloc] init];
    self.comfirmPasswordView.tagLabel.text = @"确认密码";
    self.comfirmPasswordView.inputTextField.placeholder = @"";
    self.comfirmPasswordView.inputTextField.secureTextEntry = YES;
    self.comfirmPasswordView.inputTextField.delegate = self;
    [self.containerView addSubview:self.comfirmPasswordView];

    self.phoneNumberView = [[TagInputView alloc] init];
    self.phoneNumberView.tagLabel.text = @"手机号码";
    self.phoneNumberView.inputTextField.placeholder = @"";
    self.phoneNumberView.inputTextField.delegate = self;
    [self.containerView addSubview:self.phoneNumberView];

    self.codeView = [[TagInputView alloc] init];
    self.codeView.tagLabel.text = @"验证码";
    self.codeView.inputTextField.placeholder = @"";
    self.codeView.inputTextField.delegate = self;
    [self.containerView addSubview:self.codeView];
    
    self.resendCodeButton = [[UIButton alloc] init];
    [self.resendCodeButton setTitle:@"重新发送" forState:UIControlStateNormal];
    [self.resendCodeButton addTarget:self action:@selector(resendCodeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.resendCodeButton setBackgroundImage:[[UIImage imageNamed:@"通用长按钮底_常态"] generalResizableImageWithCenter] forState:UIControlStateNormal];
    [self.resendCodeButton setBackgroundImage:[[UIImage imageNamed:@"通用长按钮底_按下"] generalResizableImageWithCenter] forState:UIControlStateHighlighted];
    [self.containerView addSubview:self.resendCodeButton];

    self.registerButton = [[UIButton alloc] init];
    [self.registerButton setTitle:@"登录" forState:UIControlStateNormal];
    [self.registerButton addTarget:self action:@selector(registerButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.registerButton setBackgroundImage:[[UIImage imageNamed:@"通用长按钮底_常态"] generalResizableImageWithCenter] forState:UIControlStateNormal];
    [self.registerButton setBackgroundImage:[[UIImage imageNamed:@"通用长按钮底_按下"] generalResizableImageWithCenter] forState:UIControlStateHighlighted];
    [self.containerView addSubview:self.registerButton];
    
    UIView *superView = self.view;
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(superView);
    }];
    
    CGFloat gap = 30;
    

    [self.containerScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuide);
        make.left.right.and.bottom.equalTo(superView);
    }];
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.mas_topLayoutGuide);
        make.edges.equalTo(self.containerScrollView);
        make.width.equalTo(self.containerScrollView);

//        make.left.right.and.bottom.equalTo(self.containerScrollView);
        //        make.width.equalTo(self.containerScrollView);
    }];
    
//    NSLog(@"%@", @(self.topLayoutGuide.length));
    [self.accountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.containerView.mas_left).offset(gap);
        make.top.equalTo(self.containerView.mas_top).offset(20);
//        make.top.equalTo(self.mas_).offset(15);
        make.right.equalTo(self.containerView.mas_right).offset(-gap);
        make.height.equalTo(@kRegisterInputViewHeight);
    }];

    [self.passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.containerView.mas_left).offset(gap);
        make.top.equalTo(self.accountView.mas_bottom).offset(15);
        make.right.equalTo(self.containerView.mas_right).offset(-gap);
        make.height.equalTo(@kRegisterInputViewHeight);
    }];

    [self.comfirmPasswordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.containerView.mas_left).offset(gap);
        make.top.equalTo(self.passwordView.mas_bottom).offset(15);
        make.right.equalTo(self.containerView.mas_right).offset(-gap);
        make.height.equalTo(@kRegisterInputViewHeight);
    }];

    [self.phoneNumberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.containerView.mas_left).offset(gap);
        make.top.equalTo(self.comfirmPasswordView.mas_bottom).offset(15);
        make.right.equalTo(self.containerView.mas_right).offset(-gap);
        make.height.equalTo(@kRegisterInputViewHeight);
    }];

    [self.codeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.containerView.mas_left).offset(gap);
        make.top.equalTo(self.phoneNumberView.mas_bottom).offset(15);
        make.height.equalTo(@kRegisterInputViewHeight);
    }];
    
    [self.resendCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.codeView.mas_right).offset(15);
        make.top.equalTo(self.phoneNumberView.mas_bottom).offset(15);
        make.right.equalTo(self.containerView.mas_right).offset(-gap);
        make.height.equalTo(@(kRegisterInputViewHeight - 4));
        make.width.equalTo(@100);
    }];
    
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.containerView.mas_left).offset(gap);
        make.right.equalTo(self.containerView.mas_right).offset(-gap);
        make.height.equalTo(@kRegisterInputViewHeight);
        make.top.equalTo(self.codeView.mas_bottom).offset(15);
    }];
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.registerButton.mas_bottom).offset(30);
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

- (IBAction)registerButtonClicked:(id)sender {
    if (self.accountView.inputTextField.text.length > 0 && self.passwordView.inputTextField.text.length > 0 && self.phoneNumberView.inputTextField.text.length > 0 && self.codeView.inputTextField.text.length > 0) {
        [self showLoadingWithText:@"注册中..."];
        [UserInfoRequest registerWithAccount:self.accountView.inputTextField.text password:self.passwordView.inputTextField.text phone:self.phoneNumberView.inputTextField.text code:self.codeView.inputTextField.text withSuccess:^(User *user, BOOL status) {
            [UserInfoRequest loginWithAccount:self.accountView.inputTextField.text passwork:self.passwordView.inputTextField.text withSuccess:^(User *user, BOOL loginStatus) {
                [self showMainView];
                [self hideLoadingView];
            } failure:^(NSString *msg) {
                [self hideLoadingViewWithError:msg];
            }];
        } failure:^(NSString *msg) {
            [self hideLoadingViewWithError:msg];
        }];
    }
}

- (IBAction)resendCodeButtonClicked:(id)sender {
    if (self.self.phoneNumberView.inputTextField.text.length > 0) {
        [self showLoadingWithText:@"发送中..."];
        [UserInfoRequest sendCodeForPhone:self.phoneNumberView.inputTextField.text WithBlock:^(NSString *code) {
            [self hideLoadingViewWithSuccess:@"发送成功"];
        } failure:^(NSString *msg) {
            [self hideLoadingViewWithError:msg];
        }];
    }
}

- (IBAction)cancelButtonClicked:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - private

- (void)initNaviBarItem {
    self.title = @"用户注册";
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
    [self.view endEditing:YES];
}

- (void)showMainView {
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate showHomeView];
}

#pragma mark - keyboard notification

- (void)keyboardWillShow:(NSNotification *)notification {
    NSDictionary* userInfo = [notification userInfo];
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    UIViewAnimationCurve animationCurve = [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] intValue];
    float animationDuration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    CGRect rect = [self.containerView convertRect:self.currentActivedTextField.frame fromView:self.currentActivedTextField];
    
    CGPoint offsetPoint = CGPointMake(0, CGRectGetMaxY(rect) + 10 - (CGRectGetHeight(self.containerScrollView.frame) - keyboardSize.height));
    if (offsetPoint.y < 0) {
        offsetPoint.y = 0;
    }
    [UIView animateWithDuration:animationDuration delay:0 options:(UIViewAnimationOptions)animationCurve animations:^{
        [self.containerScrollView setContentOffset:offsetPoint];
//        [self.view layoutIfNeeded];
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
        [self.containerScrollView setContentOffset:CGPointMake(0, 0)];
//        [self.view layoutIfNeeded];
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
