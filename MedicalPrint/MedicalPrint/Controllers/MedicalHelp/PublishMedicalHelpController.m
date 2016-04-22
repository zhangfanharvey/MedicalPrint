//
//  PublishMedicalHelpController.m
//  MedicalPrint
//
//  Created by zhangfan on 16/3/30.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import "PublishMedicalHelpController.h"
#import "Masonry.h"
#import "UserInfoRequest.h"
#import "CaseType.h"
#import "UIImage+Resize.h"

@interface PublishMedicalHelpController () <UITextViewDelegate>

@property (nonatomic, strong) UILabel *tagLabel;
@property (nonatomic, strong) UITextField *titleTextField;
@property (nonatomic, strong) UITextView *contentTextView;
@property (nonatomic, strong) UIButton *submitButton;
@property (nonatomic, strong) CaseType *caseType;
@property (nonatomic, strong) UIImageView *topView;

@end

@implementation PublishMedicalHelpController

- (instancetype)initWithCaseType:(id)caseType {
    self = [self init];
    if (self) {
        self.caseType = caseType;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:0.933 green:0.933 blue:0.933 alpha:1.00];
    
    self.topView = [[UIImageView alloc] init];
    self.topView.backgroundColor = [UIColor whiteColor];
    self.topView.image = [[UIImage imageNamed:@"主题输入框底"] generalResizableImageWithCenter];
    [self.view addSubview:self.topView];
    
    
    self.tagLabel = [[UILabel alloc] init];
    self.tagLabel.text = @"主题";
    [self.view addSubview:self.tagLabel];
    
    self.titleTextField = [[UITextField alloc] init];
    self.titleTextField.background = [[UIImage imageNamed:@"address_输入底框"] generalResizableImageWithCenter];
    [self.view addSubview:self.titleTextField];
    
    self.contentTextView = [[UITextView alloc] init];
    self.contentTextView.delegate = self;
    [self.view addSubview:self.contentTextView];
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.submitButton = [[UIButton alloc] init];
    [self.submitButton addTarget:self action:@selector(submitButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.submitButton setBackgroundImage:[UIImage imageNamed:@"通用长按钮底_常态"] forState:UIControlStateNormal];
    [self.submitButton setBackgroundImage:[UIImage imageNamed:@"通用长按钮底_按下"] forState:UIControlStateHighlighted];
    [self.submitButton setTitle:@"提交" forState:UIControlStateNormal];
    
    [self.view addSubview:self.submitButton];
    
    [self initNaviBarItem];
    [self setupViewConstraints];
    
    [self addTapGesture];
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
    CGFloat gap = 15;
    CGFloat height = self.view.bounds.size.height / 3 * 2 - 50;
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(superView);
        make.top.equalTo(self.mas_topLayoutGuide);
        make.height.equalTo(@40);
    }];

    [self.tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView.mas_left).offset(10);
        make.top.equalTo(self.mas_topLayoutGuide).offset(10);
        make.right.lessThanOrEqualTo(@50);
    }];
    
    [self.titleTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView.mas_left).offset(55);
        make.baseline.equalTo(self.tagLabel.mas_baseline);
        make.right.equalTo(superView.mas_right).offset(-15);
        make.height.equalTo(@28);
    }];
    
    [self.contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom).offset(10);
        make.left.equalTo(superView.mas_left).offset(gap);
        make.right.equalTo(superView.mas_right).offset(-gap);
        make.height.equalTo(@(height));
    }];
    
    [self.submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(superView.mas_centerX);
        make.height.equalTo(@45);
        make.left.equalTo(superView.mas_left).offset(15);
        make.right.equalTo(superView.mas_right).offset(-15);
        make.bottom.equalTo(superView.mas_bottom).offset(-15);
    }];
}

- (void)addTapGesture {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapView:)];
    [self.view addGestureRecognizer:tapGesture];
}

- (void)didTapView:(UITapGestureRecognizer *)gesture {
    [self.view endEditing:YES];
}


#pragma mark - IBAction

- (IBAction)submitButtonClicked:(id)sender {
    if (self.contentTextView.text.length > 0 && self.titleTextField.text.length > 0) {
        [self showLoadingWithText:@"加载中..." toView:self.navigationController.view];
        [UserInfoRequest addMyMedicalCaseForType:self.caseType withTitle:self.titleTextField.text content:self.contentTextView.text success:^(BOOL status) {
            [self hideLoadingViewWithError:@"发布成功"];
            [self.navigationController popViewControllerAnimated:YES];
        } failure:^(NSString *msg) {
            [self hideLoadingViewWithError:@"发布失败"];
        }];
    }
}

#pragma mark UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [self didTapView:nil];
        return NO;
    }
    return YES;
}

@end
