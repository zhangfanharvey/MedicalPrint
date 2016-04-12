//
//  FeedbackViewController.m
//  MedicalPrint
//
//  Created by zhangfan on 16/3/23.
//  Copyright © 2016年 Medical. All rights reserved.
//

#import "FeedbackViewController.h"
#import "Masonry.h"
#import "UserInfoRequest.h"

@interface FeedbackViewController () <UITextViewDelegate>

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIButton *commitButton;

@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithRed:0.929 green:0.933 blue:0.937 alpha:1.00];
    
    self.textView = [[UITextView alloc] init];
    self.textView.delegate = self;
    [self.view addSubview:self.textView];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.commitButton = [[UIButton alloc] init];
    [self.commitButton addTarget:self action:@selector(commitButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.commitButton setBackgroundImage:[UIImage imageNamed:@"通用长按钮底_常态"] forState:UIControlStateNormal];
    [self.commitButton setBackgroundImage:[UIImage imageNamed:@"通用长按钮底_按下"] forState:UIControlStateHighlighted];
    [self.commitButton setTitle:@"提交" forState:UIControlStateNormal];

    [self.view addSubview:self.commitButton];
    
    [self initNaviBarItem];
    
    [self setupViewConstraints];
    
    [self addTapGesture];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private

- (void)initNaviBarItem
{
    self.title = @"意见反馈";
}

- (void)setupViewConstraints {
    UIView *superView = self.view;
//    UIEdgeInsets insets = UIEdgeInsetsMake(20, 15, 80, 15);
    CGFloat gap = 15;
    CGFloat height = self.view.bounds.size.height / 3 * 2;
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.and.right.equalTo(superView).insets(insets);
        make.top.equalTo(self.mas_topLayoutGuide).offset(8);
        make.left.equalTo(superView.mas_left).offset(gap);
        make.right.equalTo(superView.mas_right).offset(-gap);
        make.height.equalTo(@(height));
    }];
    
    [self.commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(superView.mas_centerX);
        make.height.equalTo(@45);
        make.width.equalTo(@260);
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

- (IBAction)commitButtonClicked:(id)sender {
    if (self.textView.text.length > 0) {
        [self showLoadingWithText:@"加载中..."];
        [UserInfoRequest sendFeedbackWithConten:self.textView.text success:^(BOOL status) {
            [self hideLoadingView];
            [self.navigationController popViewControllerAnimated:YES];
        } failure:^(NSString *msg) {
            [self hideLoadingViewWithError:@"提交失败"];
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
