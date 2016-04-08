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

@interface PublishMedicalHelpController ()

@property (nonatomic, strong) UILabel *tagLabel;
@property (nonatomic, strong) UITextField *titleTextField;
@property (nonatomic, strong) UITextView *contentTextView;
@property (nonatomic, strong) UIButton *submitButton;
@property (nonatomic, strong) CaseType *caseType;

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
    
    self.tagLabel = [[UILabel alloc] init];
    [self.view addSubview:self.tagLabel];
    
    self.titleTextField = [[UITextField alloc] init];
    [self.view addSubview:self.titleTextField];
    
    self.contentTextView = [[UITextView alloc] init];
    [self.view addSubview:self.contentTextView];
    
    self.submitButton = [[UIButton alloc] init];
    [self.submitButton addTarget:self action:@selector(submitButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.submitButton];
    
    [self initNaviBarItem];
    [self setupViewConstraints];
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
    [self.tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView.mas_left).offset(15);
        make.top.equalTo(superView.mas_top).offset(10);
    }];
    
    [self.titleTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tagLabel.mas_right).offset(15);
        make.top.equalTo(superView.mas_top).offset(10);
        make.right.equalTo(superView.mas_right).offset(-15);
    }];
    
    [self.contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView.mas_left).offset(15);
        make.right.equalTo(superView.mas_right).offset(-15);
        make.height.equalTo(@200);
    }];
    
    [self.submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(superView.mas_left).offset(15);
        make.right.equalTo(superView.mas_right).offset(-15);
        make.height.equalTo(@45);
    }];
}

#pragma mark - IBAction

- (IBAction)submitButtonClicked:(id)sender {
    if (self.contentTextView.text.length > 0 && self.titleTextField.text.length > 0) {
        [self showLoadingWithText:@"加载中..."];
        [UserInfoRequest addMyMedicalCaseForType:self.caseType withTitle:self.titleTextField.text content:self.contentTextView.text success:^(BOOL status) {
            [self hideLoadingView];
        } failure:^(NSString *msg) {
            [self hideLoadingViewWithError:msg];
        }];
    }
}

@end
